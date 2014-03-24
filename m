From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Mar 2014 10:55:02 +0100
Subject: [PATCH v2 2/3] arm64: dts: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1395652179-9216-3-git-send-email-mohun106@gmail.com>
References: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
 <1395652179-9216-3-git-send-email-mohun106@gmail.com>
Message-ID: <4827584.NY6fTFPNNK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014 14:39:38 mohun106 at gmail.com wrote:
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               clocks {
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       refclk50mhz: refclk50mhz {
> +                               compatible = "fixed-clock";
> +                               #clock-cells = <0>;
> +                               clock-frequency = <50000000>;
> +                               clock-output-names = "refclk50mhz";
> +                       };
> +               };
> +
> +               ahci0: host-bus-adapter at 810000000000 {
> +                       compatible = "snps,spear-ahci";
> +                       reg = <0x8100 0x0 0x0 0x1100>;
> +                       interrupts = <1 32 4>;
> +               };


The use of "snps,spear-ahci" by itself seems wrong here: that is
the specific implementation used in the ST "spear" SoC. I don't know
why we don't already have a "generic-ahci" binding, but please add
one so you can match against that.

I would also recommend adding a more specific string for your soc.
If you want to keep compatibility with older kernels, you can keep
the spear string as well, but it would be nicer to drop that.
If you can find out what version the synopsys macro has, that would
be ideal.

You could end up for instance with

	compatible = "cavium,thunder-123456-ahci", "snps,ahci-1.23.45",
			"snps,spear-ahci", "generic-ahci";

The driver only needs to match the last one of these, but if we
find that we have to work around some bug, it's good to have the
option of determining the exact version.

> +               nic0: ethernet at 843000000000 {
> +                       compatible = "smsc,lan9115";
> +                       reg-io-width = <4>;
> +                       reg = <0x8430 0x0 0x0 0x1000>;
> +                       interrupts = <1 31 4>;
> +               };
> +
> +               uaa0: uart at 87e024000000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x87e0 0x24000000 0x0 0x1000>;
> +                       interrupts = <1 21 4>;
> +                       clocks = <&refclk50mhz>;
> +                       clock-names = "apb_pclk";
> +               };
> +
> +               uaa1: uart at 87e025000000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x87e0 0x25000000 0x0 0x1000>;
> +                       interrupts = <1 22 4>;
> +                       clocks = <&refclk50mhz>;
> +                       clock-names = "apb_pclk";

The generic name for uarts in DT is "serial", not "uart" (yes, a
lot of others get this wrong, too).

	Arnd
