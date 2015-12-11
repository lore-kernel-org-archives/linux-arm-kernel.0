From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 Dec 2015 19:04:20 +0800
Subject: [PATCH] ARM: dts: imx53: fix EIM_D27/29 pad UART2 configuration
In-Reply-To: <1449496084-11122-1-git-send-email-linux-kernel-dev@beckhoff.com>
References: <1449496084-11122-1-git-send-email-linux-kernel-dev@beckhoff.com>
Message-ID: <20151211110420.GC11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 02:48:04PM +0100, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Br?nn <p.bruenn@beckhoff.com>
> 
> On Tue, Dec 1, 2015 at 20:52:25 PST, shawnguo at kernel.org wrote:
> > On Thu, Nov 26, 2015 at 11:59:15AM +0100, linux-kernel-dev at beckhoff.com wrote:
> >> MX53_PAD_EIM_D27__UART2_RXD_MUX and MX53_PAD_EIM_D29__UART2_RTS input_val must be configured as 0 instead of 1 to have UART2 muxed on EIM pins working
> >
> > I'm not sure why you think that.  But the i.MX53 Reference Manual in my hands doesn't agree with that.  It says ...
> >> 
> >> Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>
> >> ---
> >>  arch/arm/boot/dts/imx53-pinfunc.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
> >> index aec406b..a4c973d 100644
> >> --- a/arch/arm/boot/dts/imx53-pinfunc.h
> >> +++ b/arch/arm/boot/dts/imx53-pinfunc.h
> >> @@ -532,7 +532,7 @@
> >>  #define MX53_PAD_EIM_D26__IPU_DISP1_DAT_22			0x144 0x48c 0x000 0x7 0x0
> >>  #define MX53_PAD_EIM_D27__EMI_WEIM_D_27				0x148 0x490 0x000 0x0 0x0
> >>  #define MX53_PAD_EIM_D27__GPIO3_27				0x148 0x490 0x000 0x1 0x0
> >> -#define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x1
> >> +#define MX53_PAD_EIM_D27__UART2_RXD_MUX				0x148 0x490 0x880 0x2 0x0
> >
> > IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT DAISY field descriptions
> >
> > 000 - Selecting Pad: EIM_D26 for Mode: ALT2.
> > 001 - Selecting Pad: EIM_D27 for Mode: ALT2.
> > 010 - Selecting Pad: PATA_DMARQ for Mode: ALT3.
> > 011 - Selecting Pad: PATA_BUFFER_EN for Mode: ALT3.
> > 100 - Selecting Pad: GPIO_7 for Mode: ALT4.
> > 101 - Selecting Pad: GPIO_8 for Mode: ALT4.
> 
> 
> Thanks for the hint. I had a closer look at the reference manual and our schematics. Of course, you are right. The defines are good as they are, my patch was stupid.
> 
> I just realized RXD and TXD are inverted on our hardware (CX9020 Embedded PC). Which requires a pinmux configuration like this:
> EIM_D26->UART2_RXD
> EIM_D27->UART2_TXD
> EIM_D28->UART2_RTS
> EIM_D29->UART2_CTS
> 
> In my opinion the reference manual allows such a configuration, but I am not sure if it's appropriate for mainline.
> 
> Would you accept a patch like the following:

No, I'm not going to accept it.  But it doesn't mean you cannot define
and use it in your own board DTS file.

Shawn

> 
> >8------------------------------------------------------8<
> ARM: dts: imx53: add EIM pad config for UART2
> 
> Add another pinmux configuration to mux UART2 on EIM pads:
> 
> EIM_D26->UART2_RXD
> EIM_D27->UART2_TXD
> EIM_D28->UART2_RTS
> EIM_D29->UART2_CTS
> 
> Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>
> ---
>  arch/arm/boot/dts/imx53-pinfunc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-pinfunc.h b/arch/arm/boot/dts/imx53-pinfunc.h
> index aec406b..7d26d16 100644
> --- a/arch/arm/boot/dts/imx53-pinfunc.h
> +++ b/arch/arm/boot/dts/imx53-pinfunc.h
> @@ -525,6 +525,7 @@
>  #define MX53_PAD_EIM_D26__EMI_WEIM_D_26                                0x144 0x48c 0x000 0x0 0x0
>  #define MX53_PAD_EIM_D26__GPIO3_26                             0x144 0x48c 0x000 0x1 0x0
>  #define MX53_PAD_EIM_D26__UART2_TXD_MUX                                0x144 0x48c 0x000 0x2 0x0
> +#define MX53_PAD_EIM_D26__UART2_RXD_MUX                                0x144 0x48c 0x880 0x2 0x0
>  #define MX53_PAD_EIM_D26__FIRI_RXD                             0x144 0x48c 0x80c 0x3 0x0
>  #define MX53_PAD_EIM_D26__IPU_CSI0_D_1                         0x144 0x48c 0x000 0x4 0x0
>  #define MX53_PAD_EIM_D26__IPU_DI1_PIN11                                0x144 0x48c 0x000 0x5 0x0
> @@ -532,6 +533,7 @@
>  #define MX53_PAD_EIM_D26__IPU_DISP1_DAT_22                     0x144 0x48c 0x000 0x7 0x0
>  #define MX53_PAD_EIM_D27__EMI_WEIM_D_27                                0x148 0x490 0x000 0x0 0x0
>  #define MX53_PAD_EIM_D27__GPIO3_27                             0x148 0x490 0x000 0x1 0x0
> +#define MX53_PAD_EIM_D27__UART2_TXD_MUX                                0x148 0x490 0x000 0x2 0x0
>  #define MX53_PAD_EIM_D27__UART2_RXD_MUX                                0x148 0x490 0x880 0x2 0x1
>  #define MX53_PAD_EIM_D27__FIRI_TXD                             0x148 0x490 0x000 0x3 0x0
>  #define MX53_PAD_EIM_D27__IPU_CSI0_D_0                         0x148 0x490 0x000 0x4 0x0
> @@ -541,6 +543,7 @@
>  #define MX53_PAD_EIM_D28__EMI_WEIM_D_28                                0x14c 0x494 0x000 0x0 0x0
>  #define MX53_PAD_EIM_D28__GPIO3_28                             0x14c 0x494 0x000 0x1 0x0
>  #define MX53_PAD_EIM_D28__UART2_CTS                            0x14c 0x494 0x000 0x2 0x0
> +#define MX53_PAD_EIM_D28__UART2_RTS                            0x14c 0x494 0x87c 0x2 0x0
>  #define MX53_PAD_EIM_D28__IPU_DISPB0_SER_DIO                   0x14c 0x494 0x82c 0x3 0x1
>  #define MX53_PAD_EIM_D28__CSPI_MOSI                            0x14c 0x494 0x788 0x4 0x1
>  #define MX53_PAD_EIM_D28__I2C1_SDA                             0x14c 0x494 0x818 0x5 0x1
> @@ -548,6 +551,7 @@
>  #define MX53_PAD_EIM_D28__IPU_DI0_PIN13                                0x14c 0x494 0x000 0x7 0x0
>  #define MX53_PAD_EIM_D29__EMI_WEIM_D_29                                0x150 0x498 0x000 0x0 0x0
>  #define MX53_PAD_EIM_D29__GPIO3_29                             0x150 0x498 0x000 0x1 0x0
> +#define MX53_PAD_EIM_D29__UART2_CTS                            0x150 0x498 0x000 0x2 0x0
>  #define MX53_PAD_EIM_D29__UART2_RTS                            0x150 0x498 0x87c 0x2 0x1
>  #define MX53_PAD_EIM_D29__IPU_DISPB0_SER_RS                    0x150 0x498 0x000 0x3 0x0
>  #define MX53_PAD_EIM_D29__CSPI_SS0                             0x150 0x498 0x78c 0x4 0x2
> --
> 1.9.1
> 
