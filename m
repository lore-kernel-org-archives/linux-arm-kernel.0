From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jul 2014 16:00:08 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <5534788.ziUvZhb6y0@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com> <5534788.ziUvZhb6y0@wuerfel>
Message-ID: <20140703150008.GX32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 04:28:38PM +0200, Arnd Bergmann wrote:
> On Thursday 03 July 2014 11:41:35 Catalin Marinas wrote:
> > 
> > In my view, we don't break user space. It's rather a choice of how much
> > legacy we support on ARMv8 hardware with an arm64 kernel. We don't even
> > provide HWCAP_SWP for compat (not that anyone bothers checking that).
> > It's a similar reason we choose not to support/emulate NWFPE or OABI
> > even though there are existing binaries out there. If we choose to
> > support SWP in the arm64 kernel, then we won't be able to break user
> > space and have to carry it for a long time (unless you figure out a way
> > to remove such features from the kernel because HWCAP certainly doesn't
> > work, nor printk).
> > 
> > The ARM feature deprecation/removal cycle allows for two architecture
> > revisions before being entirely removed. SWP has been deprecated in
> > ARMv6, made optional in ARMv7 (with the possibility of disabling it if
> > still available) and removed in ARMv8. The Thumb-1/2 instruction sets
> > never had the SWP instruction. Even when SWP was available in certain
> > ARMv7 implementations, it was no longer guaranteed to be atomic.
> 
> The problem really is that the ARM architecture deprecation method is
> not compatible with the one we use in the kernel. I don't think there
> is a good answer to that.
> 
> Note that other architectures have a different way of handling this
> by never removing instructions. Obviously knowing that does not help
> deal with the problem on ARM.

Actually, there's not much difference.

Let's take a look at what x86 does.  As the instruction set there
develops, they too "retire" old instructions.  Rather than deprecating
them and then removing them entirely, instructions which were once
fast become slower because the core is no longer optimised to execute
that instruction.

This encourages those who wish to have high performance to move to the
new solution - but most importantly, existing software continues to
work.

We can have that on ARM, but only for userspace.  The difference is
that the kernel has to do the backwards compatibility rather than the
(nonexistent) CPU microcode - and we do have that capability for SWP.

We may not find it desirable to do it for ARMv8, but _if_ we wish to
allow users to migrate... if we wish to allow the existing set of
userspace programs (some of which may be statically linked to their
C library) to continue to work, there's only one option here.

While I can understand ARM Ltd not wanting to pollute their nice clean
ARM64 kernel with ARM32 "legacy junk", the fact of the matter is that
even the CPU is already polluted with the legacy ARM32 stuff - it
supports ARM32 binaries.

As ARM Ltd is moving towards server type systems, they should really
start demonstrating that they understand this point, otherwise people
are going to run away from ARM.  ISA compatibility - and a standardised
platform is what has made x86 become the universal platform that it
has.

The problem here is the embedded thinking, which is "we can make any
change, we just need to update and rebuild all the software which runs
on the CPU."  That really doesn't work when people want to provide a
single binary which works everywhere.

Going back to x86, you can still install DOS on PCs, and it still
works...

Now, for SWP in userspace, the only thing that we need SWP to do is
to provide the atomicity that userspace locking demands.  We already
have that for ARMv7, and the file is 280 lines.  That isn't much to
ask for.

However, we /do/ need the CP15 barrier instructions as well.  We,
as kernel developers, have omitted to provide a way to tell userspace
whether the CP15 barrier instructions are available, *and* whether
the new barrier instructions are there too.  So, like it or not, it
is /our/ failing as kernel developers that userspace is running into
these issues, and it is /our/ responsibility to make sure that
userspace does not break, irrespective of what path is chosed by
the raw CPU support.

Yes, we can talk about what they should be doing.  For SWP, they
/should/ be checking the HWCAPs for HWCAP_SWP, and not using it if
it isn't there.  Not everyone will do that, and while you can argue
that's a bug, to the end user it's a program which crashes and is
unusable.  That's a pretty poor user experience.

All these ABI changes concern me greatly.  The OABI to EABI change
concerned me.  The change to alignment behaviour of LDR/STR concerned
me.  SWP concerns me.  Each time we just say "well, people can just
rebuild their programs".  This trivialising of ABI change really has
to stop.

I think I can accurately judge what Linus' reaction would be on this
point, and it would involve a long email stating his disgust with the
ARM architecture as a whole and why he can't take the ARM architecture
seriously.  Of course, we could Cc him to find out... but the result
will not be pleasant.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
