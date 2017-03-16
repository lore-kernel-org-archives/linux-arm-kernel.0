From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 16 Mar 2017 10:42:04 +0000
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170315205404.GA43995@C02RW35GFVH8.dhcp.broadcom.net>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com>
 <20170310192656.GA13928@C02RW35GFVH8>
 <20170310204112.GA21382@leverpostej>
 <20170315183130.GB32819@C02RW35GFVH8.dhcp.broadcom.net>
 <20170315191741.GB29452@leverpostej>
 <20170315205404.GA43995@C02RW35GFVH8.dhcp.broadcom.net>
Message-ID: <20170316104204.GA31101@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 04:54:04PM -0400, Andy Gospodarek wrote:
> On Wed, Mar 15, 2017 at 07:17:41PM +0000, Mark Rutland wrote:
> > 
> > On Wed, Mar 15, 2017 at 02:31:30PM -0400, Andy Gospodarek wrote:
> > > On Fri, Mar 10, 2017 at 08:41:13PM +0000, Mark Rutland wrote:
> > > > On Fri, Mar 10, 2017 at 02:26:56PM -0500, Andy Gospodarek wrote:
> > > > > On Fri, Mar 10, 2017 at 05:52:30PM +0000, Will Deacon wrote:
 
> > > > > It isn't the ASM itself that causes the compilation to fail, it's the
> > > > > ASM macros included inside the new ifdef that are problematic.  Here is
> > > > > what is seen per object file:
> > > > 
> > > > > ./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
> > > > > '__smp_store_release'
> > > > >                 asm volatile ("stlr %1, %0"
> > > > > \
> > > > >                                     ^
> > > > > 1 warning generated.
> > > > > LLVM ERROR: Inline asm not supported by this streamer because we don't  <----  THIS LINE
> > > > > have an asm parser for this target
> > > > 
> > > > ... so as far as I can see it's the presence of any inline assembly that
> > > > the tool cannot handle, as LLVM tells us.

> > In the error message, LLVM explicitly states that it does not have a
> > parser for this target's assembly -- which would be a problem for *any*
> > inline assembly.
> > 
> > How does that specific error relate to the use of assembly macros within
> > sysreg.h?
> 
> This is the only error that is relevant:
> 
> LLVM ERROR: Inline asm not supported by this streamer because we don't have an asm parser for this target
> 
> Upon inspection it does not appear that this is explicitly related to
> assembly macros, just simple inline assembly. 

Indeed; as Will and I stated previously.

> Is this the only inline assembly outside a function that is not inside
> #ifdef __ASSEMBLY__ in the arm64 tree?

An __ASSEMBLY__ guard is irrelevant. We need the compiler to handle the
asm() statement, not the assembler (which cannot even parse it).

The kernel uses asm statements outside of functions elsewhere. For
example, take a look in <linux/export.h>. See that EXPORT_SYMBOL() uses
__CRC_SYMBOL(), which uses asm statements. The EXPORT_SYMBOL() is used
outside of functions, on all architectures, arm64 and x86 included.

I don't see why being inside a function matters. Given the error
message, the toolchain presumably can't parse inline assembly in any
context. We have static inline functions with assembly in headers, which
are presumably affected.

It sounds like the toolchain you are using is lacking in functionality
that is presumably present when targeting x86, or the error messages are
simply misleading. In either case, there's a toolchain issue to be
addressed, and not a kernel issue.

Thanks,
Mark.
