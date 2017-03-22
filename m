From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Mar 2017 09:27:13 +0000
Subject: [PATCH] arm64: kaslr: Add 2MB correction for aligning kernel image
In-Reply-To: <1490172943-826-1-git-send-email-sramana@codeaurora.org>
References: <1490172943-826-1-git-send-email-sramana@codeaurora.org>
Message-ID: <904FACBF-3DFE-4DDE-ACB5-7109A137D477@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 22 Mar 2017, at 08:55, Srinivas Ramana <sramana@codeaurora.org> wrote:
> 
> From: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> If kernel image extends across alignment boundary, existing
> code increases the KASLR offset by size of kernel image. The
> offset is masked after resizing. There are cases, where after
> masking, we may still have kernel image extending across
> boundary. This eventually results in only 2MB block getting
> mapped while creating the page tables. This results in data aborts
> while accessing unmapped regions during second relocation (with
> kaslr offset) in __primary_switch. To fix this problem, add a
> 2MB correction to offset along with the correction of kernel
> image size, before applying mask.
> 
> For example consider below case, where kernel image still crosses
> 1GB alignment boundary, after masking the offset, which is fixed
> by adding 2MB correction.
> 
> SWAPPER_TABLE_SHIFT = 30
> Swapper using section maps with section size 2MB.
> CONFIG_PGTABLE_LEVELS = 3
> VA_BITS = 39
> 
> _text  : 0xffffff8008080000
> _end   : 0xffffff800aa1b000
> offset : 0x1f35600000
> mask = ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1)
> 
> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7c
> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
> 
> offset after existing correction (before mask) = 0x1f37f9b000
> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7d
> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
> 
> offset (after mask) = 0x1f37e00000
> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7c
> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
> 
> new offset w/ 2MB correction (before mask) = 0x1f37819b00
> new offset w/ 2MB correction (after mask) = 0x1f38000000
> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7d
> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
> 
> Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
> ---
> arch/arm64/kernel/kaslr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 769f24ef628c..7b8af985e497 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -135,7 +135,7 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
>     */
>    if ((((u64)_text + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT) !=
>        (((u64)_end + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT))
> -        offset = (offset + (u64)(_end - _text)) & mask;
> +        offset = (offset + (u64)(_end - _text) + SZ_2M) & mask;
> 
>    if (IS_ENABLED(CONFIG_KASAN))
>        /*


Hi,

Thanks for spotting this!

Instead of adding 2 MB, could we round up _end  - _text to a SWAPPER_BLOCK_SIZE multiple instead?
