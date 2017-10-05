From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Oct 2017 12:52:43 +0200
Subject: [RESEND][PATCH 5/7] nvmem: imx-ocotp: Add i.MX7D timing write
 clock setup support
In-Reply-To: <1507155921-824-6-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
 <1507155921-824-6-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507200763.8473.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 23:25 +0100, Bryan O'Donoghue wrote:
> This patch adds logic to correctly setup the write timing parameters
> when blowing an OTP fuse for the i.MX7S/D.
> 
> Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
> ?drivers/nvmem/imx-ocotp.c | 61
> ++++++++++++++++++++++++++++++++++++++++++-----
> ?1 file changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 0cd7e03..40a1669 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -51,6 +51,7 @@
> ?#define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
> ?
> ?#define DEF_RELAX			20 /* > 16.5ns */
> +#define DEF_FSOURCE			1001
> ?#define IMX_OCOTP_WR_UNLOCK		0x3E770000
> ?#define IMX_OCOTP_READ_LOCKED_VAL	0xBADABADA
> ?
> @@ -60,6 +61,7 @@ struct octp_params {
> ?	unsigned int nregs;
> ?	bool banked;
> ?	unsigned int regs_per_bank;
> +	bool mx7_timing;
> ?};
> ?
> ?struct ocotp_priv {
> @@ -194,6 +196,25 @@ static void imx_ocotp_set_imx6_timing(struct
> ocotp_priv *priv)
> ?	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
> ?}
> ?
> +static void imx_ocotp_set_imx7_timing(struct ocotp_priv *priv)
> +{
> +	unsigned long clk_rate = 0;
> +	unsigned long fsource, strobe_prog;
> +	u32 timing = 0;
> +
> +	/* i.MX 7Solo Applications Processor Reference Manual, Rev.
> 0.1
> +	?* 6.4.3.3
> +	?*/
> +	clk_rate = clk_get_rate(priv->clk);
> +	fsource = DIV_ROUND_UP(((clk_rate / 1000) * DEF_FSOURCE),
> 1000000) + 1;
> +	strobe_prog = ((clk_rate * 10) / 1000000) + 1;
> +
> +	timing = strobe_prog & 0x00000FFF;
> +	timing |= (fsource???????<< 12) & 0x000FF000;
> +
> +	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
> +}
> +
> ?static int imx_ocotp_write(void *context, unsigned int offset, void
> *val,
> ?			???size_t bytes)
> ?{
> @@ -220,7 +241,10 @@ static int imx_ocotp_write(void *context,
> unsigned int offset, void *val,
> ?	}
> ?
> ?	/* Setup the write timing values */
> -	imx_ocotp_set_imx6_timing(priv);
> +	if (priv->params->mx7_timing)
> +		imx_ocotp_set_imx7_timing(priv);
> +	else
> +		imx_ocotp_set_imx6_timing(priv);

Do we expect this to grow more different cases in the future?

Maybe it would be better to just store a .set_timing function pointer in
the params.

> ?
> ?	/* 47.3.1.3.2
> ?	?* Check that HW_OCOTP_CTRL[BUSY] and HW_OCOTP_CTRL[ERROR]
> are clear.
> @@ -373,11 +397,36 @@ static struct nvmem_config
> imx_ocotp_nvmem_config = {
> ?};
> ?
> ?static const struct octp_params params[] = {
> -	{ .nregs = 128, .banked = false, .regs_per_bank = 0},
> -	{ .nregs = 64,??.banked = false, .regs_per_bank = 0},
> -	{ .nregs = 128, .banked = false, .regs_per_bank = 0},
> -	{ .nregs = 128, .banked = false, .regs_per_bank = 0},
> -	{ .nregs = 64,??.banked = true, .regs_per_bank = 4},
> +	{
> +		.nregs = 128,
> +		.banked = false,
> +		.regs_per_bank = 0,
> +		.mx7_timing = false
> +	},
> +	{
> +		.nregs = 64,
> +		.banked = false,
> +		.regs_per_bank = 0,
> +		.mx7_timing = false
> +	},
> +	{
> +		.nregs = 128,
> +		.banked = false,
> +		.regs_per_bank = 0,
> +		.mx7_timing = false
> +	},
> +	{
> +		.nregs = 128,
> +		.banked = false,
> +		.regs_per_bank = 0,
> +		.mx7_timing = false
> +	},
> +	{
> +		.nregs = 64,
> +		.banked = true,
> +		.regs_per_bank = 4,
> +		.mx7_timing = true
> +	},
> ?};
> ?
> ?static const struct of_device_id imx_ocotp_dt_ids[] = {

regards
Philipp
