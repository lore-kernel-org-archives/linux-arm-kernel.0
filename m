From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jul 2018 15:45:47 +0100
Subject: [PATCH] arm64: fix kernel panic on serror exception caused by
 user process
In-Reply-To: <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
References: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
 <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
 <20180717100628.s5emikyc6orira2q@lakrids.cambridge.arm.com>
 <CAM5rFu_trZpt20H2GAUq8GYTOuJMSmEknsQaEkPkDwFHPVDPeA@mail.gmail.com>
 <20180717114815.5a3rbcznfzvi2xh6@lakrids.cambridge.arm.com>
 <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
Message-ID: <20180717144547.GE17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 07:10:25PM +0530, Hari Vyas wrote:
> Okay. Don't think it is a question of trust. If access happens from
> kernel mode, I understand but If user mode initiated
> access(from devmem(which is just an example) or any other application)
> into outside or invalid region of system
> address brings complete kernel down, at least I will be surprised.
> If all other also think kernel panic okay in this case, then no
> further action is required from my side.

There are many, many ways that someone with privileged access can take
the system down.

It's _well_ known that accesses through /dev/mem (which gives _direct_
access to the hardware in the system) has the capability to take the
system down.

Your example may be through an exception, but another way could be to
find the clock controller and disable system clocks, or find the RAM
controller in physical memory and disable that.  Or the L2 cache in
older ARMs and tell it to invalidate all its contents, leading to
system data corruption and probably a kernel panic.

Other ways (on x86) that have been known for years include configuring
an 8250 serial port at an address or interrupt (this doesn't involve
/dev/mem, but merely the setserial program.)

Another, non-hardware way is the killall program used from a privileged
context.  On some flavours of Unix, it terminates programs that match
the argument.  On others, it terminates _all_ programs without warning,
effectively taking the system down.

There are 32-bit ARM SoCs that hard-lock if you try to access a device
and the clocks for that device are disabled - irrespective of whether
that is a kernel or user mode access.

Whoever has privileged system access (iow, the ability to directly
talk to hardware or configure drivers) has a responsibility to know
what to do and, more importantly, what not to do.  Poking around in
/dev/mem definitely comes under the heading of "don't do that unless
you know *exactly* what you are doing".

In normal circumstances, _nothing_ in userspace should have /dev/mem
open - indeed, the kernel build system provides an option to disable
this special device file via the CONFIG_DEVMEM.

It has to be said that /dev/mem should _never_ be exposed to non-
privileged users on the system - it's way too dangerous to do so,
since as soon as you do that, you have *no* system security what so
ever.  Your average user is then at liberty to manually read *and*
*write* the hardware *including* the kernel code _and_ page tables,
which means they can bypass *all* software protections and some
hardware ones as well.

TBH, I'd say that for people who don't know what they're doing, poking
about in /dev/mem is like pointing a gun at your foot while squeezing
the trigger.  It won't end well.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
