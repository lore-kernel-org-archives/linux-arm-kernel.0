From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 20:41:13 +0000
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170310192656.GA13928@C02RW35GFVH8>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com>
 <20170310192656.GA13928@C02RW35GFVH8>
Message-ID: <20170310204112.GA21382@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 10, 2017 at 02:26:56PM -0500, Andy Gospodarek wrote:
> On Fri, Mar 10, 2017 at 05:52:30PM +0000, Will Deacon wrote:
> > On Thu, Mar 09, 2017 at 06:18:12PM -0500, Andy Gospodarek wrote:
> > > The previous fix to workaround compilation issues for samples/bpf on arm64 was
> > > to prevent inclusion of code in sysregs.h.  This is not sustainable at this
> > > point since other header files need access to sysregs.h for multiple
> > > defintions.  The fact that the bpf samples cannot be compiled on arm64 is
> > > fairly well documented on the iovisor-dev mailing and other places without a
> > > clear-cut solution other than waiting for the llvm fix.  This attempts to
> > > resolve that by dropping the fix to define _ASM_SYSREG_H on the clang command
> > > line, and replace it with one that is wrapped around the offending code.  I
> > > recognize this feels a bit fragile, but the current situation is not great
> > > either and it seems that we are more likely to see users if the current code
> > > actually compiles and runs.
> > 
> > Why does asm cause compilation to fail?
> 
> It isn't the ASM itself that causes the compilation to fail, it's the
> ASM macros included inside the new ifdef that are problematic.  Here is
> what is seen per object file:

> ./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
> '__smp_store_release'
>                 asm volatile ("stlr %1, %0"
> \
>                                     ^
> 1 warning generated.
> LLVM ERROR: Inline asm not supported by this streamer because we don't  <----  THIS LINE
> have an asm parser for this target

... so as far as I can see it's the presence of any inline assembly that
the tool cannot handle, as LLVM tells us.

So why isn't this a problem on other architectures? They're going to
have equivalent inline asm getting pulled in, and these samples
presumably compiled on at least on architecture in the past.

Does the Tool parse x86 asm without issue, say?

> One other solution would be to move these macros out to another file
> (like sysreg-macros.h or similar) and then continue to use a trick
> similar to what we are using not to exclude those macros.  It would need
> to be clear to ARCH maintainers that these macros would need to be there
> for the forseeable future.  

That's not going to fly. We can't factor out each individual piece of
asm without making the architecure ports significantly harder to
maintain.

As above, it's not clear to me why this issue doesn't affect other
architectures. It sounds like it may simply be a deficiency in the
version of LLVM being used, that could be solved by updating that.

Thanks,
Mark.
