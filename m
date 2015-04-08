From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 08 Apr 2015 12:16:58 +0100
Subject: [PATCH 0/6] arm64 kexec kernel patches V8
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <55250E2A.80106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/15 20:35, Geoff Levand wrote:
> Hi All,
>
> This series adds the core support for kexec re-boots on arm64.  This v8 of the
> series is mainly just a rebase to Linux-4.0-rc3, and a few very minor changes
> requested for v7.
>
> To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
>
> I have tested with the ARM VE fast model, the ARM Base model and the ARM
> Foundation model with various kernel config options for both the first and
> second stage kernels.  Kexec on EFI systems works correctly.  With the ACPI
> kernel patches from [3] applied, kexec on ACPI systems seeems to work correctly.
> More ACPI + kexec testing is needed.
>
> Patch 1 here moves the macros from proc-macros.S to asm/assembler.h so that the
> dcache_line_size macro it defines can be uesd by kexec's relocate kernel
> routine.
>
> Patches 2-4 rework the arm64 hcall mechanism to give the arm64 soft_restart()
> routine the ability to switch exception levels from EL1 to EL2 for kernels that
> were entered in EL2.
>
> Patches 5-6 add the actual kexec support.
>
> Please consider all patches for inclusion.
>
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
Btw, I get the following build failure for kexec-tools master branch, 
with Linaro tool chain (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro 
GCC 4.9-2014.09 )

  $ ./configure --host=aarch64-linux-gnu
  [...]
  $ make -j4
kexec/arch/arm64/kexec-arm64.c: In function ?machine_verify_elf_rel?:
kexec/arch/arm64/kexec-arm64.c:970:29: error: ?EM_AARCH64? undeclared 
(first use in this function)
   return (ehdr->e_machine == EM_AARCH64);
                              ^
kexec/arch/arm64/kexec-arm64.c:970:29: note: each undeclared identifier 
is reported only once for each function it appears in
kexec/arch/arm64/kexec-arm64.c:971:1: warning: control reaches end of 
non-void function [-Wreturn-type]
  }
  ^
make: *** [kexec/arch/arm64/kexec-arm64.o] Error 1
make: *** Waiting for unfinished jobs....
----

You may need to add the definition of EM_AARCH64 to include/elf.h and
include that instead of linux/elf.h, like the other archs.


Cheers
Suzuki
