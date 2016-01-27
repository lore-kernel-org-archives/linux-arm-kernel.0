From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jan 2016 19:02:37 +0100
Subject: [PATCH] arm64: use local label prefixes for __reg_num symbols
In-Reply-To: <1453917687-2494-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453917687-2494-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8BA9W8JBtMisV67aUVii=pgP=V6Lq=43wev_c0CAQMOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2016 at 19:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The __reg_num_xNN symbols that are used to implement the msr_s and
> mrs_s macros are recorded in the ELF metadata of each object file.
> This is not a problem in terms of code size, but it does clobber

s/clobber/clutter/


> the output of tools like readelf, i.e.,
>
>   $ readelf -a vmlinux |grep __reg_num_x | wc -l
>   50976
>
> So let's use symbols with the .L prefix, these are strictly local,
> and don't end up in the object files.
>
>   $ readelf -a vmlinux |grep __reg_num_x | wc -l
>   0
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/sysreg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 4aeebec3d882..7d771ac01289 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -196,16 +196,16 @@
>  #ifdef __ASSEMBLY__
>
>         .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
> -       .equ    __reg_num_x\num, \num
> +       .equ    .L__reg_num_x\num, \num
>         .endr
> -       .equ    __reg_num_xzr, 31
> +       .equ    .L__reg_num_xzr, 31
>
>         .macro  mrs_s, rt, sreg
> -       .inst   0xd5200000|(\sreg)|(__reg_num_\rt)
> +       .inst   0xd5200000|(\sreg)|(.L__reg_num_\rt)
>         .endm
>
>         .macro  msr_s, sreg, rt
> -       .inst   0xd5000000|(\sreg)|(__reg_num_\rt)
> +       .inst   0xd5000000|(\sreg)|(.L__reg_num_\rt)
>         .endm
>
>  #else
> @@ -214,16 +214,16 @@
>
>  asm(
>  "      .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
> -"      .equ    __reg_num_x\\num, \\num\n"
> +"      .equ    .L__reg_num_x\\num, \\num\n"
>  "      .endr\n"
> -"      .equ    __reg_num_xzr, 31\n"
> +"      .equ    .L__reg_num_xzr, 31\n"
>  "\n"
>  "      .macro  mrs_s, rt, sreg\n"
> -"      .inst   0xd5200000|(\\sreg)|(__reg_num_\\rt)\n"
> +"      .inst   0xd5200000|(\\sreg)|(.L__reg_num_\\rt)\n"
>  "      .endm\n"
>  "\n"
>  "      .macro  msr_s, sreg, rt\n"
> -"      .inst   0xd5000000|(\\sreg)|(__reg_num_\\rt)\n"
> +"      .inst   0xd5000000|(\\sreg)|(.L__reg_num_\\rt)\n"
>  "      .endm\n"
>  );
>
> --
> 2.5.0
>
