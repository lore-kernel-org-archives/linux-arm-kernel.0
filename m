From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Jul 2014 12:25:19 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140705111406.GA23692@arm.com>
References: <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com> <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703174318.GE28175@arm.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
 <20140705111406.GA23692@arm.com>
Message-ID: <20140705112519.GO21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 05, 2014 at 12:14:07PM +0100, Catalin Marinas wrote:
> The timeline I propose would be:
> 
> 1. Architecture feature deprecation (still present, no way to disable)
>    - In Linux we need to find ways and push for alternatives to be
>      adopted by user space (like we did with kuser helpers)
> 2. Architecture feature disabling (still present but needs to be enabled
>    explicitly via SCTLR bit)
>    - Linux disables the feature by default and provides emulation
>      (enabled by default), clear warnings
>    - In certain cases, there may be justification to enable the hardware
>      feature but certainly not in defconfig nor distro Image builds.
>      Otherwise they can't complain that users are still using such
>      feature at point 3 below
> 3. Architecture feature removed
>    - Default Linux behaviour changes to SIGILL
>    - Emulation could be still available in the kernel but maybe under
>      a CONFIG_EXPERT option
> 4. Eventually remove kernel emulation support entirely (or don't carry
>    it over to a new port, though I don't foresee any arm128 ;))
> 
> With SWP, we are currently at 3/4 with the counter arguments that 2
> wasn't entirely clear to users, so the transition needs to be
> carried over for ARMv8 (but I'm against 2 for arm64, 3 is as far as I
> would go).

That's reasonable - the patches I sent out turn off hardware SWP
where possible when SMP is enabled, switching it to emulation mode.
Plus we disable HWCAP_SWP where the exclusives are available,
whether or not the hardware has support for SWP.  This includes
ARMv6* (which needs careful review.)

However, don't forget that even when we disable HWCAP_SWP, that's of
limited use to userspace because we have soo many kernels which don't.

We still don't log SWP usage - they're still at debug level (which
means compiled out in standard kernel builds), neither do we log the
location of SWPs in the user binary (like we do with alignment faults.)
Both of these still need addressing.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
