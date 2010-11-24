From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Nov 2010 11:59:03 +0100
Subject: [PATCH] MXC IOMUX-V3 replace struct pad_desc with bitmapped
	cookie (step 2)
In-Reply-To: <19690.11351.308680.365060@ipc1.ka-ro>
References: <1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
	<19690.11351.308680.365060@ipc1.ka-ro>
Message-ID: <20101124105903.GK6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Mon, Nov 22, 2010 at 09:39:51AM +0100, Lothar Wa?mann wrote:
> This patch actually replaces the 'struct pad_desc' with a u64 cookie
> to facilitate adding platform specific pad_ctrl settings to an
> existing pad definition.
> 
> So, instead of:
> 	iomux_v3_cfg_t power_key = MX51_PAD_EIM_A27__GPIO_2_21;
> 	power_key.pad_ctrl = MX51_GPIO_PAD_CTRL_2;
> 	mxc_iomux_v3_setup_pad(&power_key);
> one can write:
> 	mxc_iomux_v3_setup_pad((MX51_PAD_EIM_A27__GPIO_2_21 & ~MUX_PAD_CTRL_MASK) | MX51_GPIO_PAD_CTRL_2);
> 
> Patch applies to branch 'imx-for-2.6.38' of git://git.pengutronix.de/git/imx/linux-2.6
> 
> Signed-Off-By: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  mach-mx3/mach-pcm043.c           |   14 +++---
>  mach-mx5/board-mx51_babbage.c    |   11 ++---
>  plat-mxc/include/mach/iomux-v3.h |   84 ++++++++++++++++++++++-----------------
>  plat-mxc/iomux-v3.c              |    4 -
>  4 files changed, 63 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 66b07d8..35b8f61 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -348,7 +348,8 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
>  static void __init mxc_board_init(void)
>  {
>  	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
> -	iomux_v3_cfg_t power_key = MX51_PAD_EIM_A27__GPIO_2_21;
> +	iomux_v3_cfg_t power_key = (MX51_PAD_EIM_A27__GPIO_2_21 &
> +				~MUX_PAD_CTRL_MASK) | MX51_GPIO_PAD_CTRL_2;
>  

This does not work. MX51_GPIO_PAD_CTRL_2 is defined as:

#define MX51_GPIO_PAD_CTRL_2	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
					PAD_CTL_PUS_100K_UP)

It has to be shifted to the correct location in the bit field. The
following fixes this, but it does not look particularly nice:

+	iomux_v3_cfg_t power_key = (MX51_PAD_EIM_A27__GPIO_2_21 &
+				~MUX_PAD_CTRL_MASK) | ((iomux_v3_cfg_t)(MX51_GPIO_PAD_CTRL_2) << MUX_PAD_CTRL_SHIFT);

How do we proceed from here?

Some

#define MUX_PAD_CTRL(mode) ((iomux_v3_cfg_t)(mode) << MUX_PAD_CTRL_SHIFT)

Macro would be nice. Unfortunately the name is already used for a
function doing the opposite.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
