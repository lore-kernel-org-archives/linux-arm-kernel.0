From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 26 Jul 2011 19:19:57 +0800
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110725204630.GD26735@ponder.secretlab.ca>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
Message-ID: <CAMPhdO8s6+T+VzTcAYKGT5K3dMWWx+Q4YQ2xqiMHBZu2S7km-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 4:46 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jul 25, 2011 at 11:07:46PM +0800, Shawn Guo wrote:
>> It adds function mxc_iomuxc_dt_init() to parse iomuxc pad configuration
>> from device tree.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> ?.../devicetree/bindings/arm/fsl/iomuxc.txt ? ? ? ? | ? 47 +++++++++++++
>> ?arch/arm/mach-mx5/Makefile ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
>> ?arch/arm/mach-mx5/iomuxc-dt.c ? ? ? ? ? ? ? ? ? ? ?| ? 72 ++++++++++++++++++++
>> ?arch/arm/plat-mxc/include/mach/common.h ? ? ? ? ? ?| ? ?3 +
>> ?4 files changed, 124 insertions(+), 0 deletions(-)
>> ?create mode 100644 Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
>> ?create mode 100644 arch/arm/mach-mx5/iomuxc-dt.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt b/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
>> new file mode 100644
>> index 0000000..ae9292b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
>> @@ -0,0 +1,47 @@
>> +* Freescale i.MX IOMUX Controller (IOMUXC)
>> +
>> +Required properties:
>> +- compatible : "fsl,<soc>-iomuxc";
>> +
>> +Sub-nodes present individual PAD configuration, and node name is the
>> +PAD name given by hardware document.
>> +
>> +Required properties:
>> +- reg : Should contain the offset of registers
>> + ?IOMUXC_SW_MUX_CTL_PAD_<pad-name> and IOMUXC_SW_PAD_CTL_PAD_<pad-name>.
>> +- fsl,iomuxc-mux-mode : Should specify the MUX_MODE setting of register
>> + ?IOMUXC_SW_MUX_CTL_PAD_<pad-name>.
>> +
>> +Optional properties:
>> +- fsl,iomuxc-sion : Indicates that bit SION of register
>> + ?IOMUXC_SW_MUX_CTL_PAD_<pad-name> needs to be set for given MUX_MODE
>> + ?setting of the PAD.
>> +- fsl,iomuxc-select-input : Specify the offset of register
>> + ?IOMUXC_<...>_SELECT_INPUT and the value of bit-field DAISY for given
>> + ?MUX_MODE setting of the PAD.
>
> This could get really verbose in a really big hurry. ?Fortunately the
> dtb format is sophisticated enough to only store each unique property
> name once, so the data shouldn't be huge, but it is still going to
> make for huge source files. ?Can you think of a more concise
> representation?
>
> The current linux code has each pin config simply a u64. ?Now, an
> engineer certainly wouldn't be asked to write raw u64 values, but we
> could add some form of #define or macro syntax to dtc so that the
> symbolic names currently used in the board.c file would continue to
> work. ?Alternately, we could just make each pin configuration a string
> that can be parsed by the kernel at runtime. ?A string would certainly
> be the most extensible, at the cost of some more init code in the
> kernel.
>
> Something along the lines of:
> ? ? ? ?iomuxc at 53fa8000 {
> ? ? ? ? ? ? ? ?compatible = "fsl,imx53-iomuxc"
> ? ? ? ? ? ? ? ?fsl,iomux-pads = "csi0-dat10,uart1-txd",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"csi0-dat11,uart1-rxd",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?...;
> ? ? ? ?};

This format looks very promising (and apparently better than the one
below in my humble POV). However, I still have some concerns:

1. there has to be a table to interpret the pin name, e.g. "csi0-dat10"
to the register, and the function name "uart1-txd" to register bits. Yet
the this mapping itself is kind of description and is supposed to be
encoded by the DT data itself

2. how we gonna implement dynamic IOMUX change, there are callbacks
during run-time where pin IOMUX properties are changed. e.g. when SD
card slot is empty, the Card Detect pin could be configured to normal
GPIO and triggers an interrupt when a card presence is detected. And
one other example is some pins are multiplexed by two components
and they could be properly managed to make both components usable
at run-time.

>
> Or if you prefer doing the parsing in dtc:
> ? ? ? ?iomuxc at 53fa8000 {
> ? ? ? ? ? ? ? ?compatible = "fsl,imx53-iomuxc"
> ? ? ? ? ? ? ? ?fsl,iomux-pads = <MX53_PAD_CSI0_DAT10__UART1_TXD_MUX
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?MX53_PAD_CSI0_DAT11__UART2_RXD_MUX
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?...
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?>;
> ? ? ? ?};
>
> And we'd need a syntax for the macros. ?However, right now
> iomux-mx53.h is *huge*, which I'm not hugely keen on also bringing
> into DTC... ?but there might just not be any good way around that
> because pinmux configuration is by definition complexe. ?It would
> certainly be better to be pre-processing that large data block in dtc
> rather than trying to encode the whole thing into kernel setup code.
>
> A third option would be to create the pinmux table in C code with gcc and
> objdump, and include it into the dtb with a /bin-inc/ statement. ?That
> option would work right now without having to change the format of the
> iomux #defines.
>
> g.
>
>> +
>> +Examples:
>> +
>> +iomuxc at 53fa8000 {
>> + ? ? #address-cells = <2>;
>> + ? ? #size-cells = <0>;
>> + ? ? compatible = "fsl,imx53-iomuxc";
>> + ? ? reg = <0x53fa8000 0x4000>;
>> +
>> + ? ? /*
>> + ? ? ?* I2C2
>> + ? ? ?*/
>> + ? ? key-col3 { /* I2C2_SCL */
>> + ? ? ? ? ? ? reg = <0x3c 0x364>;
>> + ? ? ? ? ? ? fsl,iomuxc-mux-mode = <4>;
>> + ? ? ? ? ? ? fsl,iomuxc-sion;
>> + ? ? ? ? ? ? fsl,iomuxc-select-input = <0x81c 0x0>;
>> + ? ? };
>> +
>> + ? ? key-row3 { /* I2C2_SDA */
>> + ? ? ? ? ? ? reg = <0x40 0x368>;
>> + ? ? ? ? ? ? fsl,iomuxc-mux-mode = <4>;
>> + ? ? ? ? ? ? fsl,iomuxc-sion;
>> + ? ? ? ? ? ? fsl,iomuxc-select-input = <0x820 0x0>;
>> + ? ? };
>> +};
>> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
>> index 383e7cd..71379f6 100644
>> --- a/arch/arm/mach-mx5/Makefile
>> +++ b/arch/arm/mach-mx5/Makefile
>> @@ -22,3 +22,5 @@ obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
>> ?obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
>> ?obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
>> ?obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
>> +
>> +obj-$(CONFIG_OF) += iomuxc-dt.o
>> diff --git a/arch/arm/mach-mx5/iomuxc-dt.c b/arch/arm/mach-mx5/iomuxc-dt.c
>> new file mode 100644
>> index 0000000..2cfe6e7
>> --- /dev/null
>> +++ b/arch/arm/mach-mx5/iomuxc-dt.c
>> @@ -0,0 +1,72 @@
>> +/*
>> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + * Copyright 2011 Linaro Ltd.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <asm/io.h>
>> +
>> +#define IOMUXC_CONFIG_SION ? (1 << 4)
>> +
>> +void mxc_iomuxc_dt_init(const struct of_device_id *match)
>> +{
>> + ? ? struct device_node *node = of_find_matching_node(NULL, match);
>> + ? ? struct device_node *child;
>> + ? ? void __iomem *base;
>> + ? ? u32 reg[2], select_input[2];
>> + ? ? u32 mux_mode, pad_ctl;
>> +
>> + ? ? if (!node) {
>> + ? ? ? ? ? ? pr_warn("%s: no iomuxc node found\n", __func__);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> +
>> + ? ? if (of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg))) {
>> + ? ? ? ? ? ? pr_warn("%s: property 'reg' not found\n", __func__);
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? base = ioremap(reg[0], reg[1]);
>> + ? ? if (!base) {
>> + ? ? ? ? ? ? pr_warn("%s: ioremap failed\n", __func__);
>> + ? ? ? ? ? ? goto out;
>> + ? ? }
>> +
>> + ? ? for_each_child_of_node(node, child) {
>> + ? ? ? ? ? ? /* get regsister offset of mux_ctl and pad_ctl */
>> + ? ? ? ? ? ? if (of_property_read_u32_array(child, "reg", reg,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(reg)))
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> +
>> + ? ? ? ? ? ? /* set register mux_ctl */
>> + ? ? ? ? ? ? if (of_property_read_u32(child, "fsl,iomuxc-mux-mode",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&mux_mode))
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? if (of_get_property(child, "fsl,iomuxc-sion", NULL))
>> + ? ? ? ? ? ? ? ? ? ? mux_mode |= IOMUXC_CONFIG_SION;
>> + ? ? ? ? ? ? writel(mux_mode, base + reg[0]);
>> +
>> + ? ? ? ? ? ? /* set register pad_ctl */
>> + ? ? ? ? ? ? if (!of_property_read_u32(child, "fsl,iomuxc-pad-ctl",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &pad_ctl))
>> + ? ? ? ? ? ? ? ? ? ? writel(pad_ctl, base + reg[1]);
>> +
>> + ? ? ? ? ? ? /* get offset/value pair and set select_input register */
>> + ? ? ? ? ? ? if (!of_property_read_u32_array(child,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "fsl,iomuxc-select-input", select_input,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(select_input)))
>> + ? ? ? ? ? ? ? ? ? ? writel(select_input[1], base + select_input[0]);
>> + ? ? }
>> +
>> + ? ? iounmap(base);
>> +
>> +out:
>> + ? ? of_node_put(node);
>> +}
>> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
>> index 4e3d978..12b7499 100644
>> --- a/arch/arm/plat-mxc/include/mach/common.h
>> +++ b/arch/arm/plat-mxc/include/mach/common.h
>> @@ -13,6 +13,7 @@
>>
>> ?struct platform_device;
>> ?struct clk;
>> +struct of_device_id;
>>
>> ?extern void mx1_map_io(void);
>> ?extern void mx21_map_io(void);
>> @@ -72,4 +73,6 @@ extern void mxc_arch_reset_init(void __iomem *);
>> ?extern void mx51_efikamx_reset(void);
>> ?extern int mx53_revision(void);
>> ?extern int mx53_display_revision(void);
>> +
>> +extern void mxc_iomuxc_dt_init(const struct of_device_id *match);
>> ?#endif
>> --
>> 1.7.4.1
>>
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
