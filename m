From: andy@greyhouse.net (Andy Gospodarek)
Date: Wed, 15 Mar 2017 16:54:04 -0400
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170315191741.GB29452@leverpostej>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com>
 <20170310192656.GA13928@C02RW35GFVH8>
 <20170310204112.GA21382@leverpostej>
 <20170315183130.GB32819@C02RW35GFVH8.dhcp.broadcom.net>
 <20170315191741.GB29452@leverpostej>
Message-ID: <20170315205404.GA43995@C02RW35GFVH8.dhcp.broadcom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 07:17:41PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 15, 2017 at 02:31:30PM -0400, Andy Gospodarek wrote:
> > On Fri, Mar 10, 2017 at 08:41:13PM +0000, Mark Rutland wrote:
> > > On Fri, Mar 10, 2017 at 02:26:56PM -0500, Andy Gospodarek wrote:
> > > > On Fri, Mar 10, 2017 at 05:52:30PM +0000, Will Deacon wrote:
> > > > > On Thu, Mar 09, 2017 at 06:18:12PM -0500, Andy Gospodarek wrote:
> 
> > > > > Why does asm cause compilation to fail?
> > > > 
> > > > It isn't the ASM itself that causes the compilation to fail, it's the
> > > > ASM macros included inside the new ifdef that are problematic.  Here is
> > > > what is seen per object file:
> > > 
> > > > ./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
> > > > '__smp_store_release'
> > > >                 asm volatile ("stlr %1, %0"
> > > > \
> > > >                                     ^
> > > > 1 warning generated.
> > > > LLVM ERROR: Inline asm not supported by this streamer because we don't  <----  THIS LINE
> > > > have an asm parser for this target
> > > 
> > > ... so as far as I can see it's the presence of any inline assembly that
> > > the tool cannot handle, as LLVM tells us.
> 
> > > So why isn't this a problem on other architectures? They're going to
> > > have equivalent inline asm getting pulled in, and these samples
> > > presumably compiled on at least on architecture in the past.
> 
> > As far as I can tell (hoping my regex is proper), x86 doesn't have any
> > inline assembly that introduces macros like this in any h-files.
> 
> Just to be clear, is the error quoted above at all relevant here?
> 
> The error is for an asm statement which does not use assembly macros, in
> a different file.
> 
> In the error message, LLVM explicitly states that it does not have a
> parser for this target's assembly -- which would be a problem for *any*
> inline assembly.
> 
> How does that specific error relate to the use of assembly macros within
> sysreg.h?

This is the only error that is relevant:

LLVM ERROR: Inline asm not supported by this streamer because we don't have an asm parser for this target

Upon inspection it does not appear that this is explicitly related to
assembly macros, just simple inline assembly.  I recall reading a thread
on either the llvm or iovisor mailing-list that pointed at the macro
being the issue, but even if I remove the macro the compile fails until
I put the assembly into a function.

> ... has the wrong error been quoted above?

The other lines related to errors in barrier.h can be ignored this is
not a new issue or one that is a major concern to me.  As I said before
I probably mistakenly added to much detail to the commit message as it
clearly caused confusion.

> ... does LLVM dump a misleading error message after seeing an assembly
> macro (which it presumably can't handle)?

It does seem a bit misleading -- or at a minimum it seems vague.

Is this the only inline assembly outside a function that is not inside
#ifdef __ASSEMBLY__ in the arm64 tree?

Thanks for keeping the thread alive, Mark. (Seriously)
