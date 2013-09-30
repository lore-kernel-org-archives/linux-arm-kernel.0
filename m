From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 30 Sep 2013 12:27:09 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <52446841.2030301@codethink.co.uk>
References: <1379988800.1974.68@driftwood> <52446841.2030301@codethink.co.uk>
Message-ID: <20130930112704.GA3209@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 06:00:49PM +0100, Ben Dooks wrote:
> On 24/09/13 03:13, Rob Landley wrote:
> >On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
> >>During 3.12-rc, Will Deacon introduced code into arch/arm that
> >>requires binutils 2.22.
> >
> >Um, my toolchain is using the last gplv2 snapshot of binutils out of
> >git, which is just past 2.17 and can build armv7 (but not armv8).
> >
> >Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some
> >thought to have gone into that? Possibly a mention of it?
> >
> >>diff --git a/Documentation/Changes b/Documentation/Changes
> >>index b175808..0f8deaf 100644
> >>--- a/Documentation/Changes
> >>+++ b/Documentation/Changes
> >>@@ -23,7 +23,7 @@ you probably needn't concern yourself with
> >>isdn4k-utils.
> >>
> >>o Gnu C 3.2 # gcc --version
> >>o Gnu make 3.80 # make --version
> >>-o binutils 2.12 # ld -v
> >>+o binutils 2.22 # ld -v
> 
> Out of interest, can I now change my fixes for v3.12 big-endian
> series to use .instr instead of .word?

There seems to be a consensus in this thread that demanding newer
binutils for this feature is reasonable, at least for v7, since
older versions may not completely implement v7 anyway.

But I don't see a conclusion on whether it is reasonable to make that
demand for configurations (< v7) where these new features are irrelevant.

I also don't see a clear justification about what version should be
demanded (I only see 2.22 suggested, yet DSB NSH, ISH and friends
actually require only 2.21, if I'm reading the source right).


If such a decision is made globally for all configurations, and if the
chosen version is >= 2.20, then I have no problem with switching to
.inst.  In that case it would make sense to port opcodes.h to use .inst,
or otherwise to port all users of the __inst_*() macros in the kernel to
use .inst directly.

Using .inst conditionally, based on a build-time check would also be
possible -- that's a nice-to-have, which I hadn't attempted for now.
That would at least make those instructions disassemble correctly.


Note that some of the opcodes.h macros do more than .inst does, even
with newer binutils.

Part of the point of the way opcodes.h was written was to encourage
people to think about ARM versus thumb, instead of spraying .long
all over the kernel and watching it break.  .inst may encourage the
same fail, IMHO, unless wrapped by something like the opcodes.h interface
that helps the coder to be explicit about their intentions.

Cheers
---Dave
