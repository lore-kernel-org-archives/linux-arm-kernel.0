From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 16:19:34 +0100
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <CAL85gmA5Ob+kp-+5seO-wcB8tx4jyiOeFMyCsZWFBLdX09nZDg@mail.gmail.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <6073715.cGydpIHKD1@wuerfel>
 <CAL85gmA5Ob+kp-+5seO-wcB8tx4jyiOeFMyCsZWFBLdX09nZDg@mail.gmail.com>
Message-ID: <201401131619.35030.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Feng Kan wrote:
> On Wed, Jan 8, 2014 at 2:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 08 January 2014 10:05:50 Mark Rutland wrote:
> >> > +
> >> > +Example:
> >> > +
> >> > +     reboot at 0 {
> >> > +             compatible = "apm,xgene-reboot";
> >> > +             reg = <0x0 0x17000014 0x0 0x4>;
> >> > +     };
> >>
> >> Given this seems to be a 64-bit address, the unit address should
> >> preferably be 0,17000014 rather than just 0.
> >
> > I also wonder about the size and location of the register.
> > Are you sure the device is just a single 4-byte register at offset
> > 0x14, rather than a complex device that happens to contain the
> > reset register?
> 
> FKAN: this is a single 4 byte register when clicked perform the system
> reset of the platform.

That is not what I was asking about.

The problem with your binding is that it doesn't seem to describe
the hardware structure at all, but rather try to invent devices
because of how it's convenient for how you write the Linux drivers.

This is never a good idea and it will become a problem once you
try to port a different operating system, or when the structure
of the Linux drivers changes. Remember that in Linux we can freely
reorganize our code as requirements change, but the bindings have
to remain stable to allow running new kernels with an older device
tree that may be shipped with the firmware.

(Side note: if you end up doing an ACPI driver for this after all,
the problem is even worse because it's basically impossible to update
the ACPI tables in field, while with DT you can at least override
them in the firmware if something goes really wrong.)

On most SoCs I've seen, the system reset registers are part of
some on-chip device, most likely one of
- A SoC-specific system control register set containing various
  global registers that may be of interest to other parts of the
  kernel.
- A watchdog timer device that will reset the system after a crash,
  or when explicit requested by the OS
- A dedicated reset controller that has registers for individually
  resetting a number of subsystems of the SoC, or all at once in
  case of system reboot.
- an interface to an external or integrated power management IC
  that controls voltages and/or clock frequencies provided to
  the SoC and other parts of the system.

In each of those cases, we already have a subsystem that is supposed
to handle the entire register set and provide a system reset method
as one of the things it does. Given that your register is at offset
0x14 from the start of a larger MMIO range, I strongly suspect
that the same is true here.

	Arnd
