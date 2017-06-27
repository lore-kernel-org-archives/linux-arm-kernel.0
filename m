From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 27 Jun 2017 18:15:31 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
In-Reply-To: <20170626181232.GK4902@n2100.armlinux.org.uk>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
 <20170626101304.GG4902@n2100.armlinux.org.uk>
 <20170626133255.GH8543@e103592.cambridge.arm.com>
 <20170626144001.GH4902@n2100.armlinux.org.uk>
 <20170626163634.GI8543@e103592.cambridge.arm.com>
 <20170626181232.GK4902@n2100.armlinux.org.uk>
Message-ID: <20170627171529.GK8543@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 07:12:32PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 26, 2017 at 05:36:39PM +0100, Dave Martin wrote:
> > On Mon, Jun 26, 2017 at 03:40:01PM +0100, Russell King - ARM Linux wrote:
> > > I'd hope that the kernel implementation is not used as an example - it
> > > most certainly is not an example, as it does no parsing of the data
> > > structures.  As the kernel is responsible for creating the layout, it
> > > expects the exact same layout coming back in, and any deviation from
> > > that results in the task being forcefully exited.
> > 
> > Unfortunately, things that are not intended as examples do still get
> > used.  We can argue that's the userspace folks' fault, but it still
> > creates de facto ABI...
> 
> Given that the contents of the structure depend on kernel configuration
> symbols, it's impossible for userspace to use it unless they also have
> some kind of static configuration as well.

Agreed

> > > Basically, the layout that the kernel creates is entirely dependent on
> > > the kernel configuration, and any scheme that replicates what the kernel
> > > is doing in the restore paths is doomed to failure.  (However, that's
> > > not to say userspace isn't, but if it is, userspace breaks if the kernel
> > > configuration is changed.  I don't regard that as a kernel-induced
> > > userspace regression though - it's a bit like expecting EABI userspace
> > > to work with OABI-only supporting kernel.)
> 
> The kernel gained the tagged-list approach in 2006, and didn't start
> preserving the VFP state until 2010.
> 
> > I'm actually a little confused by, say,
> > 
> > https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/arm/setcontext.S;h=db6aebfbd4d360e3b7ba525cf2e483f8e3ddfc0d;hb=HEAD
> > 
> > Assuming I'm looking in the right place here, glibc effectively uses its
> > own private format for uc_regspace -- maybe there is kernel history
> > here I'm not aware of, or maybe it's not even trying to be compatible.
> 
> It looks to me like glibc is expecting:
> 
> - If the HWCAP includes VFP
>    - 64 bytes of d8-d15 registers
>    - fpscr
> - If the HWCAP includes iWMMXT
>    - 48 bytes of iWMMXT state
> 
> The kernel has never used that (partial!) format - note that it seems
> to omit d0-d7 from the context.
> 
> Given that setcontext()'s man page says:
> 
>        The  function setcontext() restores the user context pointed at by ucp.
>        A successful call does  not  return.   The  context  should  have  been
>        obtained  by  a  call  of getcontext(), or makecontext(3), or passed as
>        third argument to a signal handler.
> 
> it seems that for this to work in the signal handler case, there would
> have to be some kind of translation from the kernel format to glibc's
> format when calling into the signal handler - maybe there is... but
> what you point out is definitely incompatible with the kernel today,
> and has always been incompatible.
> 
> If there's no translation going on, then this has never worked, and so
> there's no possibility of a regression!

Yes.  Sadly, there's no indication of whether the incompatibility is
intentional or not.

> > Also, libunwind does not appear to attempt to parse uc_regspace:
> > 
> > git.savannah.gnu.org/gitweb/?p=libunwind.git;a=blob;f=src/arm/Gstep.c;h=37e6c12f115173ebbc9ebcf511c53fd7c0a7d9a1;hb=HEAD
> 
> Yea, it's just looking at the integer register set.
> 
> > I've not fully understood the gdb code, but there is a comment in
> > arm-linux-tdep.c that suggests that uc_regspace is not processed (nor do
> > I see any other mention of uc_regspace or things like VFP_MAGIC:
> > 
> > https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/arm-linux-tdep.c;h=95c52608adbb1ff92a9ddb203835d5a1102339bd;hb=HEAD
> > 
> > /* The VFP or iWMMXt registers may be saved on the stack, but there's
> > 	no reliable way to restore them (yet).  */
> 
> It sounds like no one implemented the userspace side of this then!
> 
> > Do you know of any userspace parser of uc_regspace?
> > 
> > All I have so far is this, from the reporter of the bug:
> > 
> > https://github.com/DynamoRIO/dynamorio/commit/0b75c635033d01ab04f955f5affe14a3ced9ab56
> 
> Hmm, well, it seems like they're the first to test this feature, which
> is pretty sad.

Hmm indeed

> > Should we enforce the same on sigreturn, or be more tolerant?
> 
> I've been thinking about that, and haven't come to a decision.  There
> is the matter that more complex parsing is harder to be correct (think
> about out of bounds 'size' values, although that can be mitigated by
> ensuring that size is numerically correct for the magic ID - but then
> what if we have a wrong ID, or the size is incorrect for the magic ID?)
> 
> > There is some merit to this, since the effect cannot be achieved 100%
> > safely in any other way.  However, it may require the caller to
> > manufacture a sigframe from scratch.  If so, it may be natural to
> > omit the IWMMXT block (and indeed the VFP block, if the caller
> > doesn't care what's in the VFP registers at the destination).
> 
> As you can see, the kernel hasn't really catered for manufactured
> sigframes - it expects to see the same sigframe that it wrote out.
> Whether that's reasonable or not, I'm not sure, but no one's
> complained about it yet!
> 
> > The DynamoRIO example above takes a signal to generate a "template"
> > sigframe, which is then modified to produce the desired result.
> > Putting aside the issue of whether this is an abuse of sigreturn
> > or not (and the question of why they are doing it at all), this
> > seems a reasonable approach -- which they also apparently use for
> > x86.  So their sigframe will contain the dummy iWMMXt block, but
> > it will have a valid tag if we patch the kernel to write one.
> 
> Bear in mind that parsing the data in uc_regspace is going to be
> hardware specific, it's hard to do it in a generic way.  Debuggers
> necessarily have to know the intricate hardware details of the
> system its running on, so it's reasonable for them to poke about
> in that area.  I'm not so sure about generic applications though.
> 
> Anyway, I don't have time this evening to continue this reply... so
> I'll send it anyway. :)

There's certainly a limit to the portability that userspace can expect
here.  Returning from a signal is portable; poking about inside
mcontext_t is not, though we should aim for least surprise.


For the RFC v2 I just posted, I've aimed for a halfway house where
the code is kept a simple as possible without mandating the
iWMMXt dummy block to be present on non-iWMMXt hardware.

If present, the block must have the same location and size as
the iwmmxt_sigframe would have.  This should avoid the possibility
of any runtime overrun when attempting to skip blocks.

Cheers
---Dave
