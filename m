From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 17:17:44 +0000
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170316210454.GA53792@C02RW35GFVH8.dhcp.broadcom.net>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com>
 <20170310192656.GA13928@C02RW35GFVH8>
 <20170310204112.GA21382@leverpostej>
 <20170315183130.GB32819@C02RW35GFVH8.dhcp.broadcom.net>
 <20170315191741.GB29452@leverpostej>
 <20170315205404.GA43995@C02RW35GFVH8.dhcp.broadcom.net>
 <20170316104204.GA31101@leverpostej>
 <20170316210454.GA53792@C02RW35GFVH8.dhcp.broadcom.net>
Message-ID: <20170317171744.GM5940@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 05:04:55PM -0400, Andy Gospodarek wrote:
> On Thu, Mar 16, 2017 at 10:42:04AM +0000, Mark Rutland wrote:
> > On Wed, Mar 15, 2017 at 04:54:04PM -0400, Andy Gospodarek wrote:
> > > On Wed, Mar 15, 2017 at 07:17:41PM +0000, Mark Rutland wrote:
> > > > On Wed, Mar 15, 2017 at 02:31:30PM -0400, Andy Gospodarek wrote:
> > > > > On Fri, Mar 10, 2017 at 08:41:13PM +0000, Mark Rutland wrote:

> > > > > > ... so as far as I can see it's the presence of any inline assembly that
> > > > > > the tool cannot handle, as LLVM tells us.

> > > LLVM ERROR: Inline asm not supported by this streamer because we
> > > don't have an asm parser for this target
> > > 
> > > Upon inspection it does not appear that this is explicitly related to
> > > assembly macros, just simple inline assembly. 

> You are correct that it appears llvm cannot process any inline asm for
> arm64.  Sadly (or luckily) the inability to process this is not a
> hard-requirement for llvm to properly compile code that includes these
> h-files -- as long as none of #defines/c-macros/inline functions are
> actually *called* in the code I'm trying to compile.

The Linux-internal arm64 headers are there to build the kernel using a
supported toolchain. From my PoV, if you want to use the Linux-internal
arm64 headers, you need to be compatible with the toolchain(s) that we
target. 

I would imagine the x86 developers would have a similar feeling, were
this issue to crop up on x86.

> Sorry I continue to harp on this, but I've been testing XDP on ARM64
> using some Broadcom SoCs and I'm seeing some really nice performance
> benefits to being able to process so many frames per second using a
> smaller footprint device.  I'd like to see the ARM64 XDP user community
> grow, but without the ability to easily compile the samples in the
> upstream kernel tree today I just don't see this user- or developer-base
> growing.  

Please talk to the LLVM community, and see what is necessary in order to
make it compatible with the toolchains we support.

> > It sounds like the toolchain you are using is lacking in functionality
> > that is presumably present when targeting x86, or the error messages are
> > simply misleading. In either case, there's a toolchain issue to be
> > addressed, and not a kernel issue.
> 
> While I generally agree isn't the entire reason this inline asm exists
> -- to fix a binutils issue?  :-)
> 
> commit 72c5839515260dce966cd24f54436e6583288e6c
> Author: Catalin Marinas <catalin.marinas@arm.com>
> Date:   Thu Jul 24 14:14:42 2014 +0100
> 
>     arm64: gicv3: Allow GICv3 compilation with older binutils

We introduced this code so as to *retain* compatibility with a toolchain
that we explicitly supported, but accidentally broke with the addition
of the GICv3 code.

We have clearly never supoprted a toolchain that cannot parse inline
asembly.

Thanks,
Mark.
