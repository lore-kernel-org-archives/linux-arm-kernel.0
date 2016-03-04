From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 4 Mar 2016 13:21:59 -0800
Subject: [PATCH v2] mtd: avoid stack overflow in MTD CFI code
In-Reply-To: <1456748436-522413-1-git-send-email-arnd@arndb.de>
References: <1456748436-522413-1-git-send-email-arnd@arndb.de>
Message-ID: <20160304212159.GA55664@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 01:20:28PM +0100, Arnd Bergmann wrote:
> When map_word gets too large, we use a lot of kernel stack, and for
> MTD_MAP_BANK_WIDTH_32, this means we use more than the recommended
> 1024 bytes in a number of functions:
> 
> drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_write_buffers':
> drivers/mtd/chips/cfi_cmdset_0020.c:651:1: warning: the frame size of 1336 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_erase_varsize':
> drivers/mtd/chips/cfi_cmdset_0020.c:972:1: warning: the frame size of 1208 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/mtd/chips/cfi_cmdset_0001.c: In function 'do_write_buffer':
> drivers/mtd/chips/cfi_cmdset_0001.c:1835:1: warning: the frame size of 1240 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This can be avoided if all operations on the map word are done
> indirectly and the stack gets reused between the calls. We can
> mostly achieve this by selecting MTD_COMPLEX_MAPPINGS whenever
> MTD_MAP_BANK_WIDTH_32 is set, but for the case that no other
> bank width is enabled, we also need to use a non-constant
> map_bankwidth() to convince the compiler to use less stack.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: added 'if HAS_IOMEM' to avoid a Kconfig warning on user-mode-linux.
> 
> Originally sent out on Jan 1, sorry for taking my time to follow
> up with a new version.
> 
>  drivers/mtd/chips/Kconfig |  1 +
>  include/linux/mtd/map.h   | 19 +++++++------------
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
> index 741ec69e0b46..cd162cbc3746 100644
> --- a/drivers/mtd/chips/Kconfig
> +++ b/drivers/mtd/chips/Kconfig
> @@ -117,6 +117,7 @@ config MTD_MAP_BANK_WIDTH_16
>  
>  config MTD_MAP_BANK_WIDTH_32
>  	bool "Support 256-bit buswidth" if MTD_CFI_GEOMETRY
> +	select MTD_COMPLEX_MAPPINGS if HAS_IOMEM
>  	default n
>  	help
>  	  If you wish to support CFI devices on a physical bus which is
> diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> index 5e0eb7ccabd4..3aa56e3104bb 100644
> --- a/include/linux/mtd/map.h
> +++ b/include/linux/mtd/map.h
> @@ -122,18 +122,13 @@
>  #endif
>  
>  #ifdef CONFIG_MTD_MAP_BANK_WIDTH_32
> -# ifdef map_bankwidth
> -#  undef map_bankwidth
> -#  define map_bankwidth(map) ((map)->bankwidth)
> -#  undef map_bankwidth_is_large
> -#  define map_bankwidth_is_large(map) (map_bankwidth(map) > BITS_PER_LONG/8)
> -#  undef map_words
> -#  define map_words(map) map_calc_words(map)
> -# else
> -#  define map_bankwidth(map) 32
> -#  define map_bankwidth_is_large(map) (1)
> -#  define map_words(map) map_calc_words(map)
> -# endif
> +/* always use indirect access for 256-bit to preserve kernel stack */
> +# undef map_bankwidth
> +# define map_bankwidth(map) ((map)->bankwidth)
> +# undef map_bankwidth_is_large
> +# define map_bankwidth_is_large(map) (map_bankwidth(map) > BITS_PER_LONG/8)
> +# undef map_words
> +# define map_words(map) map_calc_words(map)
>  #define map_bankwidth_is_32(map) (map_bankwidth(map) == 32)
>  #undef MAX_MAP_BANKWIDTH
>  #define MAX_MAP_BANKWIDTH 32

Looking a little closer at this... why do we need the changes to
include/linux/mtd/map.h again? It should be fine to leave these
definitions as-is, right? They don't contribute to the large stack
usage, do they?

Maybe I'm just missing something obvious, so please do enlighten :)

Brian
