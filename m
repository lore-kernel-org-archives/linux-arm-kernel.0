From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:09:13 +0000
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
Message-ID: <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:51:56PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Fri, Nov 03, 2017 at 10:11:44AM -0700, Sami Tolvanen wrote:
> > This series adds build system support for compiling the kernel with clang
> > Link Time Optimization (LTO), using GNU gold with the LLVMgold plug-in
> > for linking. Some background for clang's LTO support is available here:
> > 
> >   https://llvm.org/docs/LinkTimeOptimization.html
> > 
> > With -flto, clang produces LLVM bitcode instead of object files, and
> > the compilation to native code happens at link time. In addition, clang
> > cannot use an external assembler for inline assembly when LTO is enabled,
> > which causes further compatibility issues.
> > 
> > The patches in this series remove intermediate linking steps when LTO is
> > used, postpone processing done on object files until after the LTO link
> > step, add workarounds for GNU gold incompatibilities, and address inline
> > assembly incompatibilities for arm64.
> > 
> > These changes allow arm64 defconfig to be compiled with LTO, but other
> > architectures are not enabled until compatibility issues have been
> > addressed. In particular, x86 inline assembly doesn't currently compile
> > with clang's integrated assembler due to this LLVM bug:
> > 
> >   https://bugs.llvm.org/show_bug.cgi?id=24487
> > 
> > Due to recent bug fixes in the toolchain, it's recommended to use clang
> > 5.0 or later, and GNU gold from binutils 2.27 or later
> 
> Which tree are you testing with?
> 
> I had a go building the arm64 for/next/core branch defconfig using clang
> 5.0.0 from llvm.org, with the Linaro 17.05 toolchain's binutils
> (2.27.0.20161019), and I hit what appears to be a compiler bug quite
> quickly.

So as per my reply to patch 7, it looks like this series addresses this
case.

What's the minimum set of patches necessary to work with clang (ignoring
LTO)?

Thanks,
Mark.
