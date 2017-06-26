From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jun 2017 15:40:01 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
In-Reply-To: <20170626133255.GH8543@e103592.cambridge.arm.com>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
 <20170626101304.GG4902@n2100.armlinux.org.uk>
 <20170626133255.GH8543@e103592.cambridge.arm.com>
Message-ID: <20170626144001.GH4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 02:32:56PM +0100, Dave Martin wrote:
> On Mon, Jun 26, 2017 at 11:13:04AM +0100, Russell King - ARM Linux wrote:
> > Hmm, I would actually suggest that we poke in a correct size for the
> > missing iWMMXt record, and an invalid magic number as the "simple"
> > solution for this - that doesn't make any layout changes to the
> > data structures, and is probably the safest solution for backporting.
> 
> This avoids altering the sigframe layout at all in this case, which
> feels less dirsuptive, but overall I'm not sure it's lower-risk.
> 
> I'm concerned that there are a some userspace sigframe parsers out there
> that work only by accident, especially given that the kernel sigreturn
> implementation is the primary example and that doesn't need to be fully
> robust (since the kernel lays out the sigframe itself during signal
> delivery).

I'd hope that the kernel implementation is not used as an example - it
most certainly is not an example, as it does no parsing of the data
structures.  As the kernel is responsible for creating the layout, it
expects the exact same layout coming back in, and any deviation from
that results in the task being forcefully exited.

Userspace doesn't have the luxury of prior knowledge of the layout -
it doesn't know how the kernel is configured.  It can't assume (eg)
that VFP will be at 0xa0 bytes in if IWMMXT but not CRUNCH is enabled.

Basically, the layout that the kernel creates is entirely dependent on
the kernel configuration, and any scheme that replicates what the kernel
is doing in the restore paths is doomed to failure.  (However, that's
not to say userspace isn't, but if it is, userspace breaks if the kernel
configuration is changed.  I don't regard that as a kernel-induced
userspace regression though - it's a bit like expecting EABI userspace
to work with OABI-only supporting kernel.)

Now, the possibilities for userspace to parse the "broken" kernel layout
for VFP information are:

1. To use a fixed offset from the start (which means it breaks if the
   kernel is reconfigured.)

2. userspace checks several fixed offsets for the VFP identifier (at 0,
   0xa0, 0xc0 or 0x160).  That's risky if the other state happens to
   contain a word that looks like the VFP identifier.

If userspace is using the proper method that the original code intended,
userspace would hit uninitialised memory for the iWMMXT block identifier
and size (they'd see stale data on the stack) and if they interpret the
"size" field to try and skip over it, they could end up anywhere in
memory space.

Fixing it using your approach would mean that the VFP block ends up at
a variable location depending on whether the iWMMXT state was saved -
which certainly breaks (1) in a way that does not depend on kernel
configuration.  (2) survives as they'd find the identifier whatever
happens.

My proposal solves all three cases, because userspace ends up with a
correct size for what is an unknown block of code, and doesn't involve
moving anything around.  It shouldn't break the "correct" parsing that
userspace should be doing either, because it should skip over the
unknown block.  The only case that it would break is if the identifier
were to somehow match, and I think the chances of that are very slim.
So I believe (without evidence to the contary) that this would be the
lowest risk.

> > Going forward, I think something along the lines of your proposal is
> > okay.
> 
> I'm happy to do either, or propose one approach for stable and the other
> for mainline, but it's hard to know which is least likely to break
> userspace, or exactly what the ABI is.

The intended ABI is a tagged list, where the list headers are made up
of an identifier and a size (where the size gives the offset from the
start of this block to the next - iow, from the address of the
identifer.)  The aux_sigframe structure is there as a convenience to
the kernel (which is why it's not in uapi/).

The interface was created by Daniel Jacobowitz from Codesourcery, and I
believe Daniel was working on the userspace side at the same time, so I
would hope that the userspace side does proper parsing - except for one
issue - when Daniel was working on it, we weren't saving VFP state
across signal handlers.

The issue that you've found looks to have been there since the original
design back in 2006.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
