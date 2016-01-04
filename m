From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 17:34:06 +0100
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <568A9803.6050108@gmail.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <15026471.7nGZ0rWlIf@wuerfel> <568A9803.6050108@gmail.com>
Message-ID: <6384244.Uhpjfgly6O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 00:04:19 Rongrong Zou wrote:
> ? 2016/1/4 19:13, Arnd Bergmann ??:
> > On Sunday 03 January 2016 20:24:14 Rongrong Zou wrote:
> >> ? 2015/12/31 23:00, Rongrong Zou ??:
> >> */
> >>      compatible = "low-pin-count";
> >>      device_type = "isa";
> >>      #address-cells = <2>;
> >>      #size-cells = <1>;
> >>      reg = <0x0 0xa01b0000 0x0 0x10000>;
> >>      ranges = <0x1 0x0 0x0 0x0 0x1000>;
> >> /*
> >> *  ranges is required, then i can get the IORESOURCE_IO <0xe4,4> from "reg = <0x1, 0x000000e4, 4>".
> >> *
> >> */
> >>      ipmi_0:ipmi at 000000e4{
> >>              device_type = "ipmi";
> >>              compatible = "ipmi-bt";
> >>              reg = <0x1 0x000000e4 0x4>;
> >> };
> >>
> >
> > This looks wrong: the property above says that the I/O port range is
> > translated to MMIO address 0x00000000 to 0x00010000, which is not
> > true on your hardware. I think this needs to be changed in the code
> > so the ranges property is not required for I/O ports.
> 
> Ranges property can set empty, but this means 1:1 translation. the I/O 
> port range is translated to MMIO address 0x00000001 00000000 to 
> 0x00000001 00000004, it looks wrong else. I wonder if anyone get legacy 
> I/O port resource from dts.

As I said, nothing should really require the ranges property here, unless
you have a valid IORESOURCE_MEM translation. The code that requires
the ranges to be present is wrong.

> For ipmi driver, I can get I/O port resource by DMI rather than dts.

No, the ipmi driver uses the resource that belongs to the platform
device already, you can't rely on DMI data to be present there.

	Arnd
