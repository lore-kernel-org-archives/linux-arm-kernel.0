From: dalias@libc.org (Rich Felker)
Date: Sun, 16 Nov 2014 11:50:17 -0500
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141116163355.GK4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
Message-ID: <20141116165017.GT22465@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 04:33:56PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 16, 2014 at 12:56:56AM -0500, Rich Felker wrote:
> > Aside from that, the only case among the above that's "right" already
> > is v7+. Hard-coding the mcr-based barrier on v6 is wrong because it's
> 
> I don't think it's wrong at all.  The instruction isn't going away from
> ARMv7, because ARMv7 deprecates it, but it _still_ has to be implemented
> by a CPU conforming to ARMv7.  As ARMv7 is going to be the last 32-bit
> ARM architecture, we aren't going to see the MCR instruction disappearing
> on 32-bit CPUs.
> 
> On ARMv8, it may have been removed, but we have already decided that the
> kernel _must_ provide emulation for this op-code, because otherwise we
> are breaking existing userspace, which is just not permissible.  However,
> you are absolutely right that running on ARMv8 should use the new
> instruction where possible.

Thanks for the clarification on the current and intended future
compatibility status!

Emulation by the kernel would be something like 100x slower though,
no? While it's better than not working at all, I think that would be a
good argument for never using mcr explicitly unless either it's known
to be supported in hardware or there's no alternative (because kuser
helper is missing).

> > However neither is really very easy because it seems impossible to
> > detect whether the mcr-based barrier or the dmb-based barrier should
> > be used -- there's no hwcap flag to indicate support for the latter.
> > This also complicates what to do in builds for v6.
> 
> It is entirely possible to detect whether you should use mcr or dmb, and
> you've said how to do that all the way through this message.  The mcr
> instruction is present on ARMv6, and present but deprecated on ARMv7.
> dmb is only present on ARMv7.  So, if you know the CPU architecture, you
> know whether you should be using nothing, mcr, or dmb.
> 
> There's two ways to get that - firstly, the uname syscall, which gives
> a string in the form "armv..." which gives the CPU architecture.  The

Isn't it clear from the "Windows 10" fiasco that strcmp on a version
string is NOT an acceptable way to determine version/capabilities?

> second way is the ELF AT_PLATFORM entry.  AT_PLATFORM has well defined
> format, and is already used to select between different library versions
> (so is already a user API, and is subject to user API rules).  See:
> 
> $ grep string.*elf_name arch/arm/mm/proc*.S
> 
> for a list of the prefixes - the last character is always the endian-ness.
> >From that, you can see that the format is "v" (for version), then the CPU
> architecture number, followed (optionally) by any suffixes.  Parse that
> wisely, and you have the CPU architecture version, and the CPU architecture
> version defines whether the MCR or DMB variant should be used.

That seems much more acceptable to use.

> See http://lwn.net/Articles/519085/ for a way to get at the ELF aux info
> with recent glibc.  I'm sure other C libraries will be getting their own
> implementation of that for compatibility with glibc.

Yes, we have access to the aux vector, so this should work in
principle.

Rich
