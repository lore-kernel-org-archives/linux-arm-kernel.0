From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2011 16:20:37 +0200
Subject: [RFC PATCH 11/11] arm/versatile: Add device tree support
In-Reply-To: <20110616044311.29371.49018.stgit@ponder>
References: <20110616042653.29371.2052.stgit@ponder>
	<20110616044311.29371.49018.stgit@ponder>
Message-ID: <201106161620.37205.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 June 2011, Grant Likely wrote:
> This patch adds a new versatile platform for when using the device
> tree.  Add platform and amba devices are discovered and registered by
> parsing the device tree.  Clocks and initial io mappings are still
> configured statically.

Hi Grant,

Two small questions about the device tree contents:

> +       i2c at 10002000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "arm,versatile-i2c";
> +               reg = <0x10002000 0x1000>;
> +
> +               rtc at 68 {
> +                       compatible = "dallas,ds1338";
> +                       reg = <0x68>;
> +               };
> +       };
> +
> +       net at 10010000 {
> +               compatible = "smsc,lan91c111";
> +               reg = <0x10010000 0x10000>;
> +               interrupts = <25>;
> +       };
> +
> +       lcd at 10008000 {
> +               compatible = "arm,versatile-lcd";
> +               reg = <0x10008000 0x1000>;
> +       };

Why are these devices on the top level, rather than on the AMBA bus or
the FPGA? From the documentation, it seems that they are implemented
in the FPGA, which would also match the address layout.

> +       amba {
> +               compatible = "arm,amba-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               vic: intc at 10140000 {
> +                       compatible = "arm,versatile-vic", "arm,vic";
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +                       reg = <0x10140000 0x1000>;
> +               };
> +

Why the empty ranges property? All device registers are based on 0x10000000,
so I'd expect this to be described like that here.

	Arnd
