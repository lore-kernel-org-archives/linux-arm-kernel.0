From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Jan 2013 12:19:43 +0000
Subject: [PATCH 1/9] ARM: PRIMA2: add CSR SiRFmarco device tree .dts
In-Reply-To: <1356005639-23466-2-git-send-email-Barry.Song@csr.com>
References: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
 <1356005639-23466-2-git-send-email-Barry.Song@csr.com>
Message-ID: <20130102121943.GC25907@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 12:13:51PM +0000, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> SiRFmarco is a dual-core cortex-a9 SMP SoC from CSR. this patch
> adds the .dtsi and a basic evb board .dts for it.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/boot/dts/marco-evb.dts |   51 +++
>  arch/arm/boot/dts/marco.dtsi    |  749 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 800 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/marco-evb.dts
>  create mode 100644 arch/arm/boot/dts/marco.dtsi

[...]

> diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
> new file mode 100644
> index 0000000..00b5eb7
> --- /dev/null
> +++ b/arch/arm/boot/dts/marco.dtsi
> @@ -0,0 +1,749 @@
> +/*
> + * DTS file for CSR SiRFmarco SoC
> + *
> + * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +/include/ "skeleton.dtsi"
> +/ {
> +       compatible = "sirf,marco";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               cpu at 0 {
> +                       compatible = "arm,cortex-a9";
> +               };
> +               cpu at 1 {
> +                       compatible = "arm,cortex-a9";
> +               };
> +       };

It would be good if the cpu nodes had their reg property set, so the logical
map can be populated. They should also have their device_type set to "cpu".

> +
> +       axi {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x40000000 0x40000000 0xa0000000>;
> +
> +               l2-cache-controller at c0030000 {
> +                       compatible = "arm,pl310-cache", "sirf,marco-pl310-cache";

I believe the order of these should be swapped such that the most specific
match comes first.

> +                       reg = <0xc0030000 0x1000>;
> +                       interrupts = <0 59 0>;
> +                       arm,tag-latency = <1 1 1>;
> +                       arm,data-latency = <1 1 1>;
> +                       arm,filter-ranges = <0x40000000 0x80000000>;
> +               };

[...]

> +               peri-iobg {
> +                       compatible = "simple-bus";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0xcc000000 0xcc000000 0x2000000>;
> +
> +                       timer at cc020000 {
> +                               compatible = "sirf,marco-tick";
> +                               reg = <0xcc020000 0x1000>;
> +                               interrupts = <0 0 0
> +                                             0 1 0
> +                                             0 2 0
> +                                             0 49 0
> +                                             0 50 0
> +                                             0 51 0>;

Small nit: could we have these individually bracketed as below? We're doing
this fairly consistently across platforms now.

[...]

> +                       gpio: pinctrl at cc120000 {
> +                               #gpio-cells = <2>;
> +                               #interrupt-cells = <2>;
> +                               compatible = "sirf,marco-pinctrl";
> +                               reg = <0xcc120000 0x10000>;
> +                               interrupts = <0 43 0>,
> +                                          <0 44 0>,
> +                                          <0 45 0>,
> +                                          <0 46 0>,
> +                                          <0 47 0>;

>From this point on you seem to bracket interrupts individually consistently.

Thanks,
Mark.
