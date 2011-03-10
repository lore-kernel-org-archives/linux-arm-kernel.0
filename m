From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2011 15:38:26 +0100
Subject: [PATCH V6 02/17] ST SPEAr13xx: Added PCIe host controller base
	driver support.
In-Reply-To: <AANLkTik4dtJwzgwb-h1WSHjJMFthyc0-pqSCninafuA7@mail.gmail.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
	<201103011610.24283.arnd@arndb.de>
	<AANLkTik4dtJwzgwb-h1WSHjJMFthyc0-pqSCninafuA7@mail.gmail.com>
Message-ID: <201103101538.26428.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2011, shiraz hashim wrote:
> >> diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
> >> index fd8c2dc..c3fb454 100644
> >> --- a/arch/arm/mach-spear13xx/include/mach/hardware.h
> >> +++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
> >> @@ -28,4 +28,11 @@
> >>  /* typesafe io address */
> >>  #define __io_address(n)              __io(IO_ADDRESS(n))
> >
> > I could not find the definition for __io() here, but I suspect this is
> > wrong. If __io_address() is what you use for accessing the direct-mapped
> > MMIO registers, it cannot also be what you use to access the PCIe PIO
> > ports, so most likely one of the two is broken. Can you explain?
> 
> This is not used in PCIe and infact is not part of this PCIe patch.
> This is used at few places in the architecture code.

Let me rephrase my point:

The __io() macro is used for accessing PIO registers in PCIe drivers,
it needs to be defined to convert I/O port numbers between PCIBIOS_MIN_IO
and IO_SPACE_LIMIT to the virtual address that is mapped to the I/O
space registers on your PCIe bus.

__io_address() is used in spear13xx to map from physical addresses
in the SOC to virtual addresses that are part of the linear mapping
set up through iotable_init().

These two are not the same, so I believe that either __io_address()
or __io() is broken.

	Arnd
