From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 16:53:34 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117161941.GG29595@e104818-lin.cambridge.arm.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <20141117152624.GF20652@localhost>
 <20141117154739.GT4042@n2100.arm.linux.org.uk>
 <20141117161941.GG29595@e104818-lin.cambridge.arm.com>
Message-ID: <20141117165334.GW4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 04:19:42PM +0000, Catalin Marinas wrote:
> This indeed works and it is likely the way you designed it with the
> _arm32_ kernel in mind (but not before accusing the arm64 maintainers of
> making a bad decision with the "aarch64" AT_PLATFORM string for compat
> apps ;)).

Seeing as I'm the ARM32 maintainer, and you are the ARM64 maintainer, then
of course I designed it with the ARM32 kernel in mind, with a reference
into the ARM64 situation to the best of my knowledge, which suggested
that compat tasks got the "aarch64" string.  As you have pointed out,
they don't, they get a "v8l" string, which means...

> In your code sequence, the "aarch64" check should be removed, unless you
> aim it at portable code between 32 and 64-bit but I would rather use an
> #ifdef __aarch64__ in such case. On AArch64 (nothing to do with ARMv8,
> v9 etc.), we should move away from thinking in terms of architecture
> version numbers but just features.

... that it can indeed be removed.  To repeat, the check for "aarch64"
was only there because I thought that ARM64 kernels used that for
everything.

> Similarly for AArch32, I think we should switch our focus from version
> numbers (well, only from v7/v8) to features (exposed by the hardware to
> the kernel via CPUID). An example is how we got LPAE on ARMv7 without a
> change in the architecture version number. We even expose this to user
> space via hwcap because that's how we know we have atomic LDRD/STRD.

For this case, I disagree.  There is no value (in fact, there is lots of
harm) to adding a hwcap bit for this.

If we added such a hwcap bit, it would mean that userspace would have
to implement the check that I suggested, plus a check for the hwcap bit,
plus maybe a kernel version check to decide which test to use.

That is needlessly complicated.  Okay, you could decide that if the
hwcap bit is set, then that indicates that DMB should be used, but you
still have to then check the architecture version if it isn't set to
be compatible with old kernels.

So, it's all round simpler just to do the architecture version check -
and we know for certain that ARMv4, ARMv5, and ARMv6 do not have dmb.
We know that ARMv7 and ARMv8 both have dmb, and it is likely (especially
if you exert pressure on the architecture people) that dmb will remain
implemented.  We also know that ARMv6 implements the mcr instruction.
So, in this case, we know everything we need to know just by looking
at the architecture version.

Of course, we can't predict the future with any accuracy, but hoping
that dmb won't be deprecated and obsoleted is a reasonable hope, and
if it does, we would need to modify the code to add the new method in
any case.

What the code is *intentionally* safe from is the architecture number
incrementing.

So, I really don't see the point in exposing the presence of DMB via
a hwcap bit - if we wanted to do that, it's something that we should
have done at the very start, but we didn't.  Now, it's pointless to
do so.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
