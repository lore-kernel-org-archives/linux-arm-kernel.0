From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 2 Apr 2014 22:01:25 +0200
Subject: [PATCH] ARM: i.MX6: update KSZ9031 phy fixup
In-Reply-To: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
References: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
Message-ID: <20140402220125.4e203cd2@crub>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Mar 2014 18:08:07 +0100
Hubert Chaumette <hchaumette@adeneo-embedded.com> wrote:

> Update KSZ9031RN phy fixup for Congatec conga-QEVAL and conga-QMX6 combo :
> set RGMII GTX_CLK and RX_CLK pad skew to +0.96ns.
> 
> Signed-off-by: Hubert Chaumette <hchaumette@adeneo-embedded.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 76e5db4..db307c2 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -77,6 +77,9 @@ static int ksz9031rn_phy_fixup(struct phy_device *dev)
>  	mmd_write_reg(dev, 2, 5, 0);
>  	mmd_write_reg(dev, 2, 8, 0x003ff);
>  
> +	/* For Congatec conga-QMX6 board */
> +	mmd_write_reg(dev, 0x02, 0x06, 0xffff);

The patch sets TX Data Pad Skew TXD0-TXD3 but the commit message states
that it sets GTX/RX CLK pad skew. The GTX/RX CLK pad skew is already
set to +0.96ns by writing 0x003ff to the register 8.

It would be better to configure the pad skews in the board specific
way in the device tree. There is a binding for ksz9021 PHY in
Documentation/devicetree/bindings/net/micrel-ksz9021.txt.
I have a patch for setting ksz9031rn GTX/RX CLK pad skew in a similar
way over device tree and plan to submit it when the net-next merge
window for v3.16 opens.
