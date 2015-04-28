From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 28 Apr 2015 11:10:43 -0500
Subject: [PATCH v4 2/2] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <553F870B.9040606@codeaurora.org>
References: <1430169836-1999-1-git-send-email-galak@codeaurora.org>
 <1430169836-1999-2-git-send-email-galak@codeaurora.org>
 <553F870B.9040606@codeaurora.org>
Message-ID: <0D6BD158-28A6-43F9-97AB-D3D0976AF828@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 28, 2015, at 8:11 AM, Christopher Covington <cov@codeaurora.org> wrote:
> 
> Hi Kumar,
> 
> On 04/27/2015 05:23 PM, Kumar Gala wrote:
> 
>> --- /dev/null
>> +++ b/drivers/firmware/qcom_scm-64.c
>> @@ -0,0 +1,465 @@
>> +/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> + * 02110-1301, USA.
>> + */
>> +
>> +#include <linux/cpumask.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +#include <linux/qcom_scm.h>
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/compiler.h>
>> +#include <asm/smp_plat.h>
>> +
>> +#include "qcom_scm.h"
>> +
>> +#define QCOM_SCM_SIP_FNID(s, c) (((((s) & 0xFF) << 8) | ((c) & 0xFF)) | 0x02000000)
>> +
>> +#define MAX_QCOM_SCM_ARGS 10
>> +#define MAX_QCOM_SCM_RETS 3
>> +
>> +#define QCOM_SCM_ARGS_IMPL(num, a, b, c, d, e, f, g, h, i, j, ...) (\
>> +			(((a) & 0xff) << 4) | \
>> +			(((b) & 0xff) << 6) | \
>> +			(((c) & 0xff) << 8) | \
>> +			(((d) & 0xff) << 10) | \
>> +			(((e) & 0xff) << 12) | \
>> +			(((f) & 0xff) << 14) | \
>> +			(((g) & 0xff) << 16) | \
>> +			(((h) & 0xff) << 18) | \
>> +			(((i) & 0xff) << 20) | \
>> +			(((j) & 0xff) << 22) | \
>> +			(num & 0xffff))
>> +
>> +#define QCOM_SCM_ARGS(...) QCOM_SCM_ARGS_IMPL(__VA_ARGS__, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
>> +
>> +/**
>> + * struct qcom_scm_desc
>> + * @arginfo: Metadata describing the arguments in args[]
>> + * @args: The array of arguments for the secure syscall
>> + * @ret: The values returned by the secure syscall
>> + * @extra_arg_buf: The buffer containing extra arguments
>> +		   (that don't fit in available registers)
>> + * @x5: The 4rd argument to the secure syscall or physical address of
>> +	extra_arg_buf
>> + */
>> +struct qcom_scm_desc {
>> +	u32 arginfo;
>> +	u64 args[MAX_QCOM_SCM_ARGS];
>> +	u64 ret[MAX_QCOM_SCM_RETS];
>> +
>> +	/* private */
>> +	void *extra_arg_buf;
>> +	u64 x5;
>> +};
>> +
>> +
>> +#define QCOM_SCM_ENOMEM		-5
>> +#define QCOM_SCM_EOPNOTSUPP	-4
>> +#define QCOM_SCM_EINVAL_ADDR	-3
>> +#define QCOM_SCM_EINVAL_ARG	-2
>> +#define QCOM_SCM_ERROR		-1
>> +#define QCOM_SCM_INTERRUPTED	1
>> +#define QCOM_SCM_EBUSY		-55
>> +#define QCOM_SCM_V2_EBUSY	-12
> 
> Any reason to duplicate ENOMEM through INTERRUPTED rather than put them in the
> common header?

No reason to duplicate them, just hadn?t noticed.

>> +static DEFINE_MUTEX(qcom_scm_lock);
>> +
>> +#define QCOM_SCM_EBUSY_WAIT_MS 30
>> +#define QCOM_SCM_EBUSY_MAX_RETRY 20
>> +
>> +#define N_EXT_QCOM_SCM_ARGS 7
>> +#define FIRST_EXT_ARG_IDX 3
>> +#define SMC_ATOMIC_SYSCALL 31
>> +#define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
>> +#define SMC64_MASK 0x40000000
>> +#define SMC_ATOMIC_MASK 0x80000000
>> +#define IS_CALL_AVAIL_CMD 1
>> +
>> +#define R0_STR "x0"
>> +#define R1_STR "x1"
>> +#define R2_STR "x2"
>> +#define R3_STR "x3"
>> +#define R4_STR "x4"
>> +#define R5_STR "x5"
> 
> What is the purpose of these macros?

Probably left over from when those code was merged between 32 and 64-bit, I?ll just inline them.

Thanks for the review.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
