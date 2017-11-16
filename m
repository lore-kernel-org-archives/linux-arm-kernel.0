From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 16 Nov 2017 23:53:00 +0300
Subject: [PATCH v2 00/18] Add support for clang LTO
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171116205300.5p3vjjqouw3prr3t@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:10PM -0800, Sami Tolvanen wrote:
> This series adds build system support for compiling the kernel with clang
> Link Time Optimization (LTO), using GNU gold with the LLVMgold plug-in
> for linking. Some background for clang's LTO support is available here:
> 
>   https://llvm.org/docs/LinkTimeOptimization.html
> 
> With -flto, clang produces LLVM bitcode instead of object files, and
> the compilation to native code happens at link time. In addition, clang
> cannot use an external assembler for inline assembly when LTO is enabled,
> which causes further compatibility issues.
> 
> The patches in this series remove intermediate linking steps when LTO is
> used, postpone processing done on object files until after the LTO link
> step, add workarounds for GNU gold incompatibilities, and address inline
> assembly incompatibilities for arm64.
> 
> These changes allow arm64 defconfig to be compiled with LTO, but other
> architectures are not enabled until compatibility issues have been
> addressed. In particular, x86 inline assembly doesn't currently compile
> with clang's integrated assembler due to this LLVM bug:
> 
>   https://bugs.llvm.org/show_bug.cgi?id=24487
> 
> Due to recent bug fixes in the toolchain, it's recommended to use clang
> 5.0 or later, and GNU gold from binutils 2.27 or later, although older
> versions may also work depending on your kernel configuration.

So, you don't guarantee that kernel will work with old compiler and
toolchain? If so, I would suggest you to add the patch that checks
their versions and disables LTO if needed.

Yury
