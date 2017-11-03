From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 17:51:56 +0000
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 03, 2017 at 10:11:44AM -0700, Sami Tolvanen wrote:
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
> 5.0 or later, and GNU gold from binutils 2.27 or later

Which tree are you testing with?

I had a go building the arm64 for/next/core branch defconfig using clang
5.0.0 from llvm.org, with the Linaro 17.05 toolchain's binutils
(2.27.0.20161019), and I hit what appears to be a compiler bug quite
quickly.

I had to create an aarch64-linux-gnu-clang wrapper, too. I'm not sure if
there's build system help to avoid needing that?

----
[mark at lakrids:~/src/linux]% uselinaro 17.05 usellvm 5.0.0 make CROSS_COMPILE=aarch64-linux-gnu- CC=clang  ARCH=arm64 
Segmentation fault
arch/arm64/Makefile:27: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum
arch/arm64/Makefile:48: Detected assembler with broken .inst; disassembly will be unreliable
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     scripts/mod/devicetable-offsets.h
  CHK     include/generated/compile.h
  CC      arch/arm64/crypto/aes-ce-cipher.o
fatal error: error in backend: Do not know how to split the result of this operator!

clang-5.0: error: clang frontend command failed with exit code 70 (use -v to see invocation)
clang version 5.0.0 (tags/RELEASE_500/final)
Target: aarch64--linux-gnu
Thread model: posix
InstalledDir: /mnt/data/opt/toolchain/llvm/5.0.0/bin
clang-5.0: note: diagnostic msg: PLEASE submit a bug report to http://llvm.org/bugs/ and include the crash backtrace, preprocessed source, and associated run script.
clang-5.0: note: diagnostic msg: 
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang-5.0: note: diagnostic msg: /tmp/aes-ce-cipher-7850ed.c
clang-5.0: note: diagnostic msg: /tmp/aes-ce-cipher-7850ed.sh
clang-5.0: note: diagnostic msg: 

********************
scripts/Makefile.build:313: recipe for target 'arch/arm64/crypto/aes-ce-cipher.o' failed
make[1]: *** [arch/arm64/crypto/aes-ce-cipher.o] Error 70
Makefile:1019: recipe for target 'arch/arm64/crypto' failed
make: *** [arch/arm64/crypto] Error 2
----

Thanks,
Mark.
