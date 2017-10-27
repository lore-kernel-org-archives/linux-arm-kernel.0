From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Oct 2017 10:41:21 +0100
Subject: [PATCH v2] arm64: prevent regressions in compressed kernel image
 size when upgrading to binutils 2.27
In-Reply-To: <20171026214356.26963-1-ndesaulniers@google.com>
References: <CAKwvOd=4=GOPUSYUzwkXHV2xhTzUnEpbw4c_PmFiqZBjbV80jA@mail.gmail.com>
 <20171026214356.26963-1-ndesaulniers@google.com>
Message-ID: <CAKv+Gu8wqH5fyievpcFi0P+JxEkA38cROzptN3zdCD0zCPcppg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 October 2017 at 22:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> Upon upgrading to binutils 2.27, we found that our lz4 compressed kernel
> images were significantly larger, resulting is 10ms boot time regressions.
>
> As noted by Rahul:
> "aarch64 binaries uses RELA relocations, where each relocation entry
> includes an addend value. This is similar to x86_64.  On x86_64, the
> addend values are also stored at the relocation offset for relative
> relocations. This is an optimization: in the case where code does not
> need to be relocated, the loader can simply skip processing relative
> relocations.  In binutils-2.25, both bfd and gold linkers did this for
> x86_64, but only the gold linker did this for aarch64.  The kernel build
> here is using the bfd linker, which stored zeroes at the relocation
> offsets for relative relocations.  Since a set of zeroes compresses
> better than a set of non-zero addend values, this behavior was resulting
> in much better lz4 compression.
>
> The bfd linker in binutils-2.27 is now storing the actual addend values
> at the relocation offsets. The behavior is now consistent with what it
> does for x86_64 and what gold linker does for both architectures.  The
> change happened in this upstream commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=1f56df9d0d5ad89806c24e71f296576d82344613
> Since a bunch of zeroes got replaced by non-zero addend values, we see
> the side effect of lz4 compressed image being a bit bigger.
>
> To get the old behavior from the bfd linker, "--no-apply-dynamic-relocs"
> flag can be used:
> $ LDFLAGS="--no-apply-dynamic-relocs" ./build/build.sh
> With this flag, the compressed image size is back to what it was with
> binutils-2.25.
>
> If the kernel is using ASLR, there aren't additional runtime costs to
> --no-apply-dynamic-relocs, as the relocations will need to be applied
> again anyway after the kernel is relocated to a random address.
>
> If the kernel is not using ASLR, then presumably the current default
> behavior of the linker is better. Since the static linker performed the
> dynamic relocs, and the kernel is not moved to a different address at
> load time, it can skip applying the relocations all over again."
>
> Some measurements:
>
> $ ld -v
> GNU ld (binutils-2.25-f3d35cf6) 2.25.51.20141117
>                     ^
> $ ls -l vmlinux
> -rwxr-x--- 1 ndesaulniers eng 300652760 Oct 26 11:57 vmlinux
> $ ls -l Image.lz4-dtb
> -rw-r----- 1 ndesaulniers eng 16932627 Oct 26 11:57 Image.lz4-dtb
>
> $ ld -v
> GNU ld (binutils-2.27-53dd00a1) 2.27.0.20170315
>                     ^
> pre patch:
> $ ls -l vmlinux
> -rwxr-x--- 1 ndesaulniers eng 300376208 Oct 26 11:43 vmlinux
> $ ls -l Image.lz4-dtb
> -rw-r----- 1 ndesaulniers eng 18159474 Oct 26 11:43 Image.lz4-dtb
>
> post patch:
> $ ls -l vmlinux
> -rwxr-x--- 1 ndesaulniers eng 300376208 Oct 26 12:06 vmlinux
> $ ls -l Image.lz4-dtb
> -rw-r----- 1 ndesaulniers eng 16932466 Oct 26 12:06 Image.lz4-dtb
>
> We've also verified gzip improves by 0.69 MB.
>
> Any compression scheme should be able to get better results from the
> longer runs of zeros, not just GZIP and LZ4.
>
> 10ms boot time savings isn't anything to get excited about, but users of
> arm64+compression+bfd-2.27 should not have to pay a boot time penalty for no
> runtime improvement.
>
> Reported-by: Gopinath Elanchezhian <gelanchezhian@google.com>
> Reported-by: Sindhuri Pentyala <spentyala@google.com>
> Reported-by: Wei Wang <wvw@google.com>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Suggested-by: Rahul Chaudhry <rahulchaudhry@google.com>
> Suggested-by: Siqi Lin <siqilin@google.com>
> Suggested-by: Stephen Hines <srhines@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes since v1:
> * dropped LZ4 only outer conditional, per Ard.
> * changed inner conditional for all RELOCATABLE, not just
>   RANDOMIZE_BASE, per Ard.
> * updated commit message with findings for gzip.
> * added Ard to suggested by line in commit message.
>
>  arch/arm64/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 939b310913cf..9f47d4276a21 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -18,6 +18,10 @@ ifneq ($(CONFIG_RELOCATABLE),)
>  LDFLAGS_vmlinux                += -pie -shared -Bsymbolic
>  endif
>
> +ifeq ($(CONFIG_RELOCATABLE), y)
> +LDFLAGS_vmlinux                += $(call ld-option, --no-apply-dynamic-relocs)
> +endif
> +
>  ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
>    ifeq ($(call ld-option, --fix-cortex-a53-843419),)
>  $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
> --
> 2.15.0.rc2.357.g7e34df9404-goog
>


If you fold it into the LDFLAGS_vmlinux assignment 3 lines up:

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
