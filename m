From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Apr 2013 13:59:16 +0100
Subject: [PATCH 4/4] arm64: Add initial DTS for APM X-Gene Storm SOC
 and APM Mustang board
In-Reply-To: <CAPrCYkezfig2Drr+_dQpt7DxLRWt-v93o8hfS_ghcizussPq0w@mail.gmail.com>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-5-git-send-email-vkale@apm.com>
 <20130422111453.GA3791@e106331-lin.cambridge.arm.com>
 <CAPrCYkezfig2Drr+_dQpt7DxLRWt-v93o8hfS_ghcizussPq0w@mail.gmail.com>
Message-ID: <20130422125916.GB3791@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 01:23:51PM +0100, Vinayak Kale wrote:
> On Mon, Apr 22, 2013 at 4:44 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > I have a couple of minor comments on the dts:
> >
> >> diff --git a/arch/arm64/boot/dts/storm.dtsi b/arch/arm64/boot/dts/storm.dtsi
> >> new file mode 100644
> >> index 0000000..8cab5d1
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/storm.dtsi
> >> @@ -0,0 +1,116 @@
> >> +/*
> >> + * dts file for AppliedMicro (APM) X-Gene Storm SOC
> >> + *
> >> + * Copyright (C) 2013, Applied Micro Circuits Corporation
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License as
> >> + * published by the Free Software Foundation; either version 2 of
> >> + * the License, or (at your option) any later version.
> >> + */
> >> +
> >> +/ {
> >> +     compatible = "apm,xgene,storm", "apm,xgene";
> >> +     interrupt-parent = <&gic>;
> >> +     #address-cells = <2>;
> >> +     #size-cells = <2>;
> >> +
> >> +     cpus {
> >> +             #address-cells = <1>;
> >
> > The reg is 64-bit, so address-cells should be 2.
> >
> Please see my comment below regarding 'reg' property & cpu node naming.
> >> +             #size-cells = <0>;
> >> +
> >> +             cpu at 0 {
> >> +                     device_type = "cpu";
> >> +                     compatible = "arm,armv8";
> >
> > It might be good to also have a compatible string for the X-Gene's CPU
> > implementation, e.g.
> >
> > compatible = "apm,xgene-cpu", "arm,armv8";
> >
> Okay, will add a compatible string for APM-Xgene.
> >> +                     reg = <0x0 0x0000>;
> >> +                     enable-method = "spin-table";
> >> +                     cpu-release-addr = <0x1 0x0000fff8>;
> >> +             };
> >> +             cpu at 1 {
> >> +                     device_type = "cpu";
> >> +                     compatible = "arm,armv8";
> >> +                     reg = <0x0 0x0001>;
> >> +                     enable-method = "spin-table";
> >> +                     cpu-release-addr = <0x1 0x0000fff8>;
> >> +             };
> >> +             cpu at 2 {
> >> +                     device_type = "cpu";
> >> +                     compatible = "arm,armv8";
> >> +                     reg = <0x0 0x0100>;
> >> +                     enable-method = "spin-table";
> >> +                     cpu-release-addr = <0x1 0x0000fff8>;
> >> +             };
> >
> > This should be cpu at 101 to match the reg property (and the following nodes
> > should be fixed up similarly).
> >
> I would like to keep the cpu numbering as is (0 to 7). It helps the
> boot-loader to iterate over cpu nodes based on logical numbers to do
> fix-ups. Also here 'reg' property is not holding an address instead it
> contains value to be compared with mpidr_el1.

We use the address bits in a cpu node's reg property to hold the mpidr_el1
value. Regardless of the semantics of an address vs CPU id, the address bits in
the reg property take 2 cells, and hence #address-cells should be 2, as ePAPR
states:

"The #address-cells property defines the number of <u32> cells used to encode
the address field in a child node?s reg property."

Regarding the unit-address, ePAPR states:

"The unit-address must match the first address specified in the reg property of
the node."

We've tried to stick to this so far.

Thanks,
Mark.
