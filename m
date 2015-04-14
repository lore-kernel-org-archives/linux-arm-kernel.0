From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 16:44:34 +0200
Subject: [PATCH v2 6/6] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <1428916660-25910-7-git-send-email-bintian.wang@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <1428916660-25910-7-git-send-email-bintian.wang@huawei.com>
Message-ID: <13386244.3fdoQHV2u9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 April 2015 17:17:40 Bintian Wang wrote:
> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;

Just one comment here: on a 64-bit system, the bus nodes must have
"dma-ranges" properties that describe the width of the bus. By default,
we assume that the bus is only 32-bit wide, which means that if you
install memory over the 4GB address boundary, devices will not be
able to do DMA there, even if the devices themselves are 64-bit DMA
capable.

> +               ao_ctrl: ao_ctrl {
> +                       compatible = "hisilicon,aoctrl", "syscon";
> +                       reg = <0x0 0xf7800000 0x0 0x2000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               sys_ctrl: sys_ctrl {
> +                       compatible = "hisilicon,sysctrl", "syscon";
> +                       reg = <0x0 0xf7030000 0x0 0x2000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               media_ctrl: media_ctrl {
> +                       compatible = "hisilicon,mediactrl", "syscon";
> +                       reg = <0x0 0xf4410000 0x0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               pm_ctrl: pm_ctrl {
> +                       compatible = "hisilicon,pmctrl", "syscon";
> +                       reg = <0x0 0xf7032000 0x0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               uart0: uart at f8015000 {  /* console */
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x0 0xf8015000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl HI6220_UART0_PCLK>;
> +                       clock-names = "uartclk", "apb_pclk";

So far, none of hte devices you list are DMA masters, so there is no
effect, but please check what DMA masters you have in the system, and
whether they are capable of doing 64-bit DMA.

	Arnd
