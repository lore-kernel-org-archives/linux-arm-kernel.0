From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 5 Sep 2017 16:04:53 +0100
Subject: [PATCH v2 05/18] firmware: arm_scmi: add initial support for
 performance protocol
In-Reply-To: <1501857104-11279-6-git-send-email-sudeep.holla@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <2690239b-27a7-dce3-88a6-d53808e8e93c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 04/08/17 15:31, Sudeep Holla wrote:
> The performance protocol is intended for the performance management of
> group(s) of device(s) that run in the same performance domain. It
> includes even the CPUs. A performance domain is defined by a set of
> devices that always have to run at the same performance level.
> For example, a set of CPUs that share a voltage domain, and have a
> common frequency control, is said to be in the same performance domain.
> 
> The commands in this protocol provide functionality to describe the
> protocol version, describe various attribute flags, set and get the
> performance level of a domain. It also supports discovery of the list
> of performance levels supported by a performance domain, and the
> properties of each performance level.
> 
> This patch adds basic support for the performance protocol.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/firmware/arm_scmi/Makefile |   2 +-
>   drivers/firmware/arm_scmi/common.h |   1 +
>   drivers/firmware/arm_scmi/perf.c   | 511 +++++++++++++++++++++++++++++++++++++
>   include/linux/scmi_protocol.h      |  31 +++
>   4 files changed, 544 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/firmware/arm_scmi/perf.c
> 
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 21d01d1d6b9c..159de726ee45 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -1,2 +1,2 @@
>   obj-$(CONFIG_ARM_SCMI_PROTOCOL)	= arm_scmi.o
> -arm_scmi-y = base.o driver.o
> +arm_scmi-y = base.o driver.o perf.o
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index e3fe5d9acc82..7473dfcad4ee 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -30,6 +30,7 @@
>   #define PROTOCOL_REV_MAJOR(x)	((x) >> PROTOCOL_REV_MINOR_BITS)
>   #define PROTOCOL_REV_MINOR(x)	((x) & PROTOCOL_REV_MINOR_MASK)
>   #define MAX_PROTOCOLS_IMP	16
> +#define MAX_OPPS		16
>   
>   enum scmi_std_protocol {
>   	SCMI_PROTOCOL_BASE = 0x10,
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> new file mode 100644
> index 000000000000..13d84d829201
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -0,0 +1,511 @@
> +/*
> + * System Control and Management Interface (SCMI) Performance Protocol
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/sort.h>
> +
> +#include "common.h"
> +
> +enum scmi_performance_protocol_cmd {
> +	PERF_DOMAIN_ATTRIBUTES = 0x3,
> +	PERF_DESCRIBE_LEVELS = 0x4,
> +	PERF_LIMITS_SET = 0x5,
> +	PERF_LIMITS_GET = 0x6,
> +	PERF_LEVEL_SET = 0x7,
> +	PERF_LEVEL_GET = 0x8,
> +	PERF_NOTIFY_LIMITS = 0x9,
> +	PERF_NOTIFY_LEVEL = 0xa,
> +};
> +
> +struct scmi_opp {
> +	u32 perf;
> +	u32 power;
> +	u32 trans_latency_us;
> +};
> +
> +struct scmi_msg_resp_perf_attributes {
> +	__le16 num_domains;
> +	__le16 flags;
> +#define POWER_SCALE_IN_MILLIWATT(x)	((x) & BIT(0))
> +	__le32 stats_addr_low;
> +	__le32 stats_addr_high;
> +	__le32 stats_size;
> +};
> +
> +struct scmi_msg_resp_perf_domain_attributes {
> +	__le32 flags;
> +#define SUPPORTS_SET_LIMITS(x)		((x) & BIT(31))
> +#define SUPPORTS_SET_PERF_LVL(x)	((x) & BIT(30))
> +#define SUPPORTS_PERF_LIMIT_NOTIFY(x)	((x) & BIT(29))
> +#define SUPPORTS_PERF_LEVEL_NOTIFY(x)	((x) & BIT(28))
> +	__le32 rate_limit_us;
> +	__le32 sustained_freq_khz;
> +	__le32 sustained_perf_level;
> +	    u8 name[SCMI_MAX_STR_SIZE];
> +};
> +
> +struct scmi_msg_perf_describe_levels {
> +	__le32 domain;
> +	__le32 level_index;
> +};
> +
> +struct scmi_perf_set_limits {
> +	__le32 domain;
> +	__le32 max_level;
> +	__le32 min_level;
> +};
> +
> +struct scmi_perf_get_limits {
> +	__le32 max_level;
> +	__le32 min_level;
> +};
> +
> +struct scmi_perf_set_level {
> +	__le32 domain;
> +	__le32 level;
> +};
> +
> +struct scmi_perf_notify_level_or_limits {
> +	__le32 domain;
> +	__le32 notify_enable;
> +};
> +
> +struct scmi_msg_resp_perf_describe_levels {
> +	__le16 num_returned;
> +	__le16 num_remaining;
> +	struct {
> +		__le32 perf_val;
> +		__le32 power;
> +		__le16 transition_latency_us;
> +		__le16 reserved;
> +	} opp[0];
> +};
> +
> +struct perf_dom_info {
> +	bool set_limits;
> +	bool set_perf;
> +	bool perf_limit_notify;
> +	bool perf_level_notify;
> +	u32 opp_count;
> +	u32 sustained_freq_khz;
> +	u32 sustained_perf_level;
> +	u32 mult_factor;
> +	char name[SCMI_MAX_STR_SIZE];
> +	struct scmi_opp opp[MAX_OPPS];
> +};
> +
> +struct scmi_perf_info {
> +	int num_domains;
> +	bool power_scale_mw;
> +	u64 stats_addr;
> +	u32 stats_size;
> +	struct perf_dom_info *dom_info;
> +};
> +
> +static struct scmi_perf_info perf_info;
> +
> +static int scmi_perf_attributes_get(const struct scmi_handle *handle,
> +				    struct scmi_perf_info *perf_info)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_resp_perf_attributes *attr;
> +
> +	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +				 SCMI_PROTOCOL_PERF, 0, sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = scmi_do_xfer(handle, t);
> +	if (!ret) {
> +		u16 flags = le16_to_cpu(attr->flags);
> +
> +		perf_info->num_domains = le16_to_cpu(attr->num_domains);
> +		perf_info->power_scale_mw = POWER_SCALE_IN_MILLIWATT(flags);
> +		perf_info->stats_addr = le32_to_cpu(attr->stats_addr_low) |
> +				(u64)le32_to_cpu(attr->stats_addr_high) << 32;

This seems odd, shouldn't it be the following?
le64_to_cpu(attr->stats_addr_low | (__le64)attr->stats_addr_high << 32)

Cheers,

-- 
Julien Thierry
