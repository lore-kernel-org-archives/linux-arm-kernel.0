From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 19:12:12 +0100
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <53AEE9B6.7000609@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk> <53AEE9B6.7000609@mentor.com>
Message-ID: <20140628181212.GJ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 11:13:42AM -0500, Nathan Lynch wrote:
> On 06/28/2014 10:26 AM, Russell King - ARM Linux wrote:
> > On Sun, Jun 22, 2014 at 10:11:56PM -0500, Nathan Lynch wrote:
> >> Place vdso-related user-space code in arch/arm/kernel/vdso/.
> >>
> >> It is almost completely written in C with some assembly helpers to
> >> load the data page address, sample the counter, and fall back to
> >> system calls when necessary.
> >>
> >> If CONFIG_ARM_ARCH_TIMER is not enabled, the vdso cannot service
> >> high-resolution clocks and falls back to syscalls.  Low-resolution
> >> clocks e.g. CLOCK_REALTIME_COARSE can be serviced regardless.
> > 
> > Okay, how is this used by userspace?
> 
> Primarily it's intended to be transparent to userspace applications;
> glibc -- with a patch -- detects the VDSO at startup and binds the
> appropriate routines to the VDSO's.
> 
> However, even an unpatched glibc makes the VDSO symbols available for
> lookup via dlsym, which has been convenient for testing.

It's a shame that the vDSO provided symbols aren't automatically
picked up in place of the glibc versions, because it means probably
many years before the vDSO seriously gets used.

I know that I'm probably many years away from it, even if Ubuntu
adopt it for something recent - I'm rather stuck with 12.04 due to
the move towards requiring 3D GPU acceleration in later versions.
It seems that the choices on ARM now are to either have a crippled
distro through lack of open GPU support, or stick with an old distro
that doesn't require GPUs.

> > hence references to gettimeofday automatically get resolved to the
> > vdso version without needing C library updates.
> 
> Hmm, I'm not sure.  I had wondered why x86-64's vdso has the aliases
> (clock_gettime --> __vdso_clock_gettime).  Most other architectures'
> VDSOs don't.

Yes, and providing them seems to have no useful benefit either, because
they aren't picked up automatically by the linker.

> > Or... do we need a glibc update to make use of this?
> 
> That is the idea, yes.  You don't have to rebuild applications but glibc
> needs to be updated to dispatch its gettimeofday and clock_gettime to
> the VDSO.

Yea, many people aren't going to rebuild glibc just because of this,
me included.  If only there was a way for automatic vdso support.

So, I'm going to have to rely on you to say "yes it works" and to
keep an eye on it in the future in case something breaks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
