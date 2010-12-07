From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 11:04:01 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <AANLkTikh-a++NQj+cUJOf9B3tjr_=CvAqJmjhLGA0Xt7@mail.gmail.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101203165105.GD30898@n2100.arm.linux.org.uk>
	<AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
	<4CFBAC6D.5060507@codesourcery.com>
	<AANLkTi=woxGqfpd12tr32FymOx77UnVehvEFQt5GnRzG@mail.gmail.com>
	<4CFD87A6.8030104@codesourcery.com>
	<AANLkTikh-a++NQj+cUJOf9B3tjr_=CvAqJmjhLGA0Xt7@mail.gmail.com>
Message-ID: <20101207110401.GA20451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 10:45:42AM +0000, Dave Martin wrote:
> Yes-- though I didn't elaborate on it.  You need a packager that can
> understand, say, that a binary built for ARMv5 EABI can interoperate
> with ARMv7 binaries etc.
> Again, I've heard it suggested that RPM can handle this, but I haven't
> looked at it in detail myself.

That is indeed the case - as on x86, it used to be common to build the
majority of the distribution for i386, and glibc and a few other bits
for a range of ix86 CPUs.

rpm and yum know that i386 is compatible with i486, which is compatible
with i586 etc, so it will install an i386 package on i686 if no i486,
i586 or i686 package is available.

It does the same for ARM with ARMv3, ARMv4 etc.

> The dynamic hwcaps approach doesn't really solve that problem:

Has anyone investigated whether it is possible to power down things like
Neon etc meanwhile leaving the rest of the CPU running?  I've not seen
anything in the ARM documentation to suggest that's the case.

Even in MPCore based systems, the interface between the SCU and individual
processors by default doesn't have the necessary clamps built in to allow
individual CPUs to be powered off, and I'm not aware of any designs which
decided to enable this feature (as there's a performance penalty).  So I'd
be really surprised if there was any support for powering down Neon
separately from the host CPU.

If that's the case, it's entirely pointless discussing what userspace can
or can't do - if you have Neon available and can't power it down, and it's
faster for doing something, you might as well use it so you can put the
main CPU into WFI mode or get on with some other useful work.
