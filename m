From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Oct 2017 12:32:11 +0200
Subject: [RESEND][PATCH 3/7] nvmem: imx-ocotp: Add support for banked
 OTP addressing
In-Reply-To: <1507155921-824-4-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
 <1507155921-824-4-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507199531.8473.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 23:25 +0100, Bryan O'Donoghue wrote:
> The i.MX7S/D takes the bank address in the CTRLn.ADDR field and the
> data
> value in one of the DATAx {0, 1, 2, 3} register fields. The current
> write
> routine is based on writing the CTRLn.ADDR field and writing a single
> DATA
> register only.
> 
> Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
> ?drivers/nvmem/imx-ocotp.c | 71
> +++++++++++++++++++++++++++++++++++++++++------
> ?1 file changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index fed76a4..8034937 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -40,7 +40,10 @@
> ?#define IMX_OCOTP_ADDR_CTRL_SET		0x0004
> ?#define IMX_OCOTP_ADDR_CTRL_CLR		0x0008
> ?#define IMX_OCOTP_ADDR_TIMING		0x0010
> -#define IMX_OCOTP_ADDR_DATA		0x0020
> +#define IMX_OCOTP_ADDR_DATA0		0x0020
> +#define IMX_OCOTP_ADDR_DATA1		0x0030
> +#define IMX_OCOTP_ADDR_DATA2		0x0040
> +#define IMX_OCOTP_ADDR_DATA3		0x0050
> ?
> ?#define IMX_OCOTP_BM_CTRL_ADDR		0x0000007F
> ?#define IMX_OCOTP_BM_CTRL_BUSY		0x00000100
> @@ -55,6 +58,8 @@ static DEFINE_MUTEX(ocotp_mutex);
> ?
> ?struct octp_params {
> ?	unsigned int nregs;
> +	bool banked;
> +	unsigned int regs_per_bank;
> ?};

Instead of the separate banked parameter you could just use
(regs_per_bank != 0).

regards
Philipp
