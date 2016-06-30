From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Jun 2016 11:53:09 +0100
Subject: [RFC PATCH v2 6/9] firmware: Add legacy SCPI protocol driver
In-Reply-To: <1466503374-28841-7-git-send-email-narmstrong@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-7-git-send-email-narmstrong@baylibre.com>
Message-ID: <5774FA15.6060302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/06/16 11:02, Neil Armstrong wrote:
> Add legacy SCPI driver based on the latest SCPI driver but modified to behave
> like an earlier technology preview SCPI implementation that at least the
> Amlogic GXBB ARMv8 based platform uses in it's SCP firmware implementation.
>
> The main differences between the mainline, public and recommended SCPI
> implementation are :
>   - virtual channels is not implemented
>   - command word is passed by the MHU instead of the virtual channel ID
>   - uses "sender id" in the command word for each commands groups
>   - payload size shift in command word is different
>   - command word is not in SRAM, so command queuing is not possible
>   - command indexes are different
>   - command data structures differs
>   - commands are redirected to low or high priority channels by their indexes,
>     so round-robin redirection is not possible

I doubt if that's the case. At-least the original arm scp f/w didn't
check that. Can you please trying sending any commands on any channel ?

>
> A clear disclaimer is added to make it clear this implementation should not
> be used for new products and is only here to support already released SoCs.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/firmware/Kconfig       |  20 ++
>   drivers/firmware/Makefile      |   1 +
>   drivers/firmware/legacy_scpi.c | 644 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 665 insertions(+)
>   create mode 100644 drivers/firmware/legacy_scpi.c
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 95b01f4..b9c2a33 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -31,6 +31,26 @@ config ARM_SCPI_PROTOCOL
>   	  This protocol library provides interface for all the client drivers
>   	  making use of the features offered by the SCP.
>
> +config LEGACY_SCPI_PROTOCOL
> +	bool "Legacy System Control and Power Interface (SCPI) Message Protocol"

Do we really need to add another config ? I thought we could just manage
with compatibles.

> +	default y if ARCH_MESON
> +	select ARM_SCPI_FW
> +	help
> +	  System Control and Power Interface (SCPI) Message Protocol is
> +	  defined for the purpose of communication between the Application
> +	  Cores(AP) and the System Control Processor(SCP). The MHU peripheral
> +	  provides a mechanism for inter-processor communication between SCP
> +	  and AP.

[...]

> diff --git a/drivers/firmware/legacy_scpi.c b/drivers/firmware/legacy_scpi.c
> new file mode 100644
> index 0000000..4bd3ff7
> --- /dev/null
> +++ b/drivers/firmware/legacy_scpi.c
> @@ -0,0 +1,644 @@

[...]

> +
> +#define CMD_ID_SHIFT		0
> +#define CMD_ID_MASK		0x7f
> +#define CMD_SENDER_ID_SHIFT	8
> +#define CMD_SENDER_ID_MASK	0xff

Again this is something I introduced in the earlier driver. But from SCP
f/w perspective, it just sends that as is to the sender. I think we
retain token concept as is from the latest driver. Could you check
dropping them and check if f/w makes any assumption about these. It
should not IMO.

> +#define CMD_DATA_SIZE_SHIFT	20
> +#define CMD_DATA_SIZE_MASK	0x1ff
> +#define PACK_SCPI_CMD(cmd_id, sender, tx_sz)				\
> +	((((cmd_id) & CMD_ID_MASK) << CMD_ID_SHIFT) |			\
> +	(((sender) & CMD_SENDER_ID_MASK) << CMD_SENDER_ID_SHIFT) |	\
> +	(((tx_sz) & CMD_DATA_SIZE_MASK) << CMD_DATA_SIZE_SHIFT))
> +
> +#define CMD_SIZE(cmd)	(((cmd) >> CMD_DATA_SIZE_SHIFT) & CMD_DATA_SIZE_MASK)
> +#define CMD_UNIQ_MASK	(CMD_TOKEN_ID_MASK << CMD_TOKEN_ID_SHIFT | CMD_ID_MASK)
> +#define CMD_XTRACT_UNIQ(cmd)	((cmd) & CMD_UNIQ_MASK)
> +
> +#define MAX_DVFS_DOMAINS	3
> +#define MAX_DVFS_OPPS		16
> +#define DVFS_LATENCY(hdr)	(le32_to_cpu(hdr) >> 16)
> +#define DVFS_OPP_COUNT(hdr)	((le32_to_cpu(hdr) >> 8) & 0xff)
> +
> +#define MAX_RX_TIMEOUT          (msecs_to_jiffies(30))
> +
> +enum legacy_scpi_error_codes {

This along with many other defines are exactly same, not need to
duplicate them.

> +	SCPI_SUCCESS = 0, /* Success */
> +	SCPI_ERR_PARAM = 1, /* Invalid parameter(s) */
> +	SCPI_ERR_ALIGN = 2, /* Invalid alignment */
> +	SCPI_ERR_SIZE = 3, /* Invalid size */
> +	SCPI_ERR_HANDLER = 4, /* Invalid handler/callback */
> +	SCPI_ERR_ACCESS = 5, /* Invalid access/permission denied */
> +	SCPI_ERR_RANGE = 6, /* Value out of range */
> +	SCPI_ERR_TIMEOUT = 7, /* Timeout has occurred */
> +	SCPI_ERR_NOMEM = 8, /* Invalid memory area or pointer */
> +	SCPI_ERR_PWRSTATE = 9, /* Invalid power state */
> +	SCPI_ERR_SUPPORT = 10, /* Not supported or disabled */
> +	SCPI_ERR_DEVICE = 11, /* Device error */
> +	SCPI_ERR_BUSY = 12, /* Device busy */
> +	SCPI_ERR_MAX
> +};
> +
> +enum legacy_scpi_client_id {

Could be removed as mentioned above ?

> +	SCPI_CL_NONE,
> +	SCPI_CL_CLOCKS,
> +	SCPI_CL_DVFS,
> +	SCPI_CL_POWER,
> +	SCPI_CL_THERMAL,
> +	SCPI_CL_REMOTE,
> +	SCPI_CL_LED_TIMER,
> +	SCPI_MAX,
> +};
> +
> +enum legacy_scpi_std_cmd {
> +	SCPI_CMD_INVALID		= 0x00,
> +	SCPI_CMD_SCPI_READY		= 0x01,
> +	SCPI_CMD_SCPI_CAPABILITIES	= 0x02,
> +	SCPI_CMD_EVENT			= 0x03,
> +	SCPI_CMD_SET_CSS_PWR_STATE	= 0x04,
> +	SCPI_CMD_GET_CSS_PWR_STATE	= 0x05,
> +	SCPI_CMD_CFG_PWR_STATE_STAT	= 0x06,
> +	SCPI_CMD_GET_PWR_STATE_STAT	= 0x07,
> +	SCPI_CMD_SYS_PWR_STATE		= 0x08,
> +	SCPI_CMD_L2_READY		= 0x09,
> +	SCPI_CMD_SET_AP_TIMER		= 0x0a,
> +	SCPI_CMD_CANCEL_AP_TIME		= 0x0b,
> +	SCPI_CMD_DVFS_CAPABILITIES	= 0x0c,
> +	SCPI_CMD_GET_DVFS_INFO		= 0x0d,
> +	SCPI_CMD_SET_DVFS		= 0x0e,
> +	SCPI_CMD_GET_DVFS		= 0x0f,
> +	SCPI_CMD_GET_DVFS_STAT		= 0x10,
> +	SCPI_CMD_SET_RTC		= 0x11,
> +	SCPI_CMD_GET_RTC		= 0x12,
> +	SCPI_CMD_CLOCK_CAPABILITIES	= 0x13,
> +	SCPI_CMD_SET_CLOCK_INDEX	= 0x14,
> +	SCPI_CMD_SET_CLOCK_VALUE	= 0x15,
> +	SCPI_CMD_GET_CLOCK_VALUE	= 0x16,
> +	SCPI_CMD_PSU_CAPABILITIES	= 0x17,
> +	SCPI_CMD_SET_PSU		= 0x18,
> +	SCPI_CMD_GET_PSU		= 0x19,
> +	SCPI_CMD_SENSOR_CAPABILITIES	= 0x1a,
> +	SCPI_CMD_SENSOR_INFO		= 0x1b,
> +	SCPI_CMD_SENSOR_VALUE		= 0x1c,
> +	SCPI_CMD_SENSOR_CFG_PERIODIC	= 0x1d,
> +	SCPI_CMD_SENSOR_CFG_BOUNDS	= 0x1e,
> +	SCPI_CMD_SENSOR_ASYNC_VALUE	= 0x1f,
> +	SCPI_CMD_COUNT
> +};
> +
> +struct legacy_scpi_xfer {
> +	u32 cmd;
> +	u32 status;
> +	const void *tx_buf;
> +	void *rx_buf;
> +	unsigned int tx_len;
> +	unsigned int rx_len;
> +	struct completion done;
> +};
> +
> +struct legacy_scpi_chan {
> +	struct mbox_client cl;
> +	struct mbox_chan *chan;
> +	void __iomem *tx_payload;
> +	void __iomem *rx_payload;
> +	spinlock_t rx_lock; /* locking for the rx pending list */
> +	struct mutex xfers_lock;
> +	struct legacy_scpi_xfer t;
> +};
> +
> +struct legacy_scpi_drvinfo {
> +	int num_chans;
> +	struct legacy_scpi_chan *channels;
> +	struct scpi_dvfs_info *dvfs[MAX_DVFS_DOMAINS];
> +};
> +

Even these data structures could remain, and mended wherever needed or
an alternate can be added at worse. Complete copy paste seems
unnecessary to me.

> +	legacy_scpi_info->channels = legacy_scpi_chan;
> +	legacy_scpi_info->num_chans = count;
> +	platform_set_drvdata(pdev, legacy_scpi_info);
> +
> +	ret = devm_scpi_ops_register(dev, &legacy_scpi_ops);

Though the concept of registering scpi ops is really nice, I think we
may not require that for support this legacy scpi protocol.

In general, I see lot of code duplication, can you try not add another
file or config and introduce the legacy support into arm_scpi.c itself ?

-- 
Regards,
Sudeep
