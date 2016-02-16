From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Feb 2016 17:12:52 +0100
Subject: [PATCH 2/2] ARM: mm: hide __start_rodata_section_aligned for
 non-debug builds
In-Reply-To: <1455638631-3326518-2-git-send-email-arnd@arndb.de>
References: <1455638631-3326518-1-git-send-email-arnd@arndb.de>
 <1455638631-3326518-2-git-send-email-arnd@arndb.de>
Message-ID: <CAKv+Gu8JcWg4BkxZFPqTotkfHFtP744XYdSx6XROJSM_8pmt2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2016 at 17:03, Arnd Bergmann <arnd@arndb.de> wrote:
> The __start_rodata_section_aligned is only referenced by the
> DEBUG_RODATA code, which is only used when the MMU is enabled,
> but the definition fails on !MMU builds:
>
> arch/arm/kernel/vmlinux.lds:702: undefined symbol `SECTION_SHIFT' referenced in expression
>
> This hides the symbol whenever DEBUG_RODATA is disabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 64ac2e74f0b2 ("ARM: 8502/1: mm: mark section-aligned portion of rodata NX")
> ---
>  arch/arm/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 2d7085ae1c2f..bb12933aee22 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -322,12 +322,14 @@ SECTIONS
>         STABS_DEBUG
>  }
>
> +#ifdef CONFIG_DEBUG_RODATA
>  /*
>   * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
>   * be the first section-aligned location after __start_rodata. Otherwise,
>   * it will be equal to __start_rodata.
>   */
>  __start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
> +#endif
>

Does

PROVIDE(__start_rodata_section_aligned = xxx);

do the trick as well? If it does, it's a bit cleaner.
