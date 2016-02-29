From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Feb 2016 13:39:48 +0100
Subject: [PATCH v2 2/2] arm64: mm: treat memstart_addr as a signed quantity
In-Reply-To: <1456505834-8638-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456505834-8638-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu93DcrAa65xGRF6rRtuq-Hjitk-B6RxV_9ztT=nKjQ_Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2016 at 17:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Commit c031a4213c11 ("arm64: kaslr: randomize the linear region")
> implements randomization of the linear region, by subtracting a random
> multiple of PUD_SIZE from memstart_addr. This causes the virtual mapping
> of system RAM to move upwards in the linear region, and at the same time
> causes memstart_addr to assume a value which may be negative if the offset
> of system RAM in the physical space is smaller than its offset relative to
> PAGE_OFFSET in the virtual space.
>
> Since memstart_addr is effectively an offset now, redefine its type as s64
> so that expressions involving shifting or division preserve its sign.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


FYI this results in a warning, please fold

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 67ce440cb702..9cfe94b41b54 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -181,7 +181,7 @@ void __init arm64_memblock_init(void)
  * linear mapping. Take care not to clip the kernel which may be
  * high in memory.
  */
- memblock_remove(max(memstart_addr + linear_region_size, __pa(_end)),
+ memblock_remove(max_t(u64, memstart_addr + linear_region_size, __pa(_end)),
  ULLONG_MAX);
  if (memblock_end_of_DRAM() > linear_region_size)
  memblock_remove(0, memblock_end_of_DRAM() - linear_region_size);


> ---
>  arch/arm64/include/asm/memory.h | 2 +-
>  arch/arm64/mm/init.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 5f8667a99e41..12f8a00fb3f1 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -135,7 +135,7 @@
>  #include <linux/bitops.h>
>  #include <linux/mmdebug.h>
>
> -extern phys_addr_t             memstart_addr;
> +extern s64                     memstart_addr;
>  /* PHYS_OFFSET - the physical address of the start of memory. */
>  #define PHYS_OFFSET            ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 4ea7efc28e65..a2977d33e0dc 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -54,7 +54,7 @@
>   * executes, which assigns it its actual value. So use a default value
>   * that cannot be mistaken for a real physical address.
>   */
> -phys_addr_t memstart_addr __read_mostly = ~0ULL;
> +s64 memstart_addr __read_mostly = -1;
>  phys_addr_t arm64_dma_phys_limit __read_mostly;
>
>  #ifdef CONFIG_BLK_DEV_INITRD
> --
> 2.5.0
>
