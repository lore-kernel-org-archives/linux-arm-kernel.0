From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 09 Mar 2015 23:29:53 +0300
Subject: [PATCH v2] MTD: cfi: reduce stack size
In-Reply-To: <2376719.UMjvd0rdnO@wuerfel>
References: <2376719.UMjvd0rdnO@wuerfel>
Message-ID: <54FE02C1.9090803@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/9/2015 10:34 PM, Arnd Bergmann wrote:

> The cfi_staa_write_buffers function uses a large amount of kernel stack
> whenever CONFIG_MTD_MAP_BANK_WIDTH_32 is set, and that results in a
> warning on ARM allmodconfig builds:

> drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_write_buffers':
> drivers/mtd/chips/cfi_cmdset_0020.c:651:1: warning: the frame size of 1208 bytes is larger than 1024 bytes [-Wframe-larger-than=]

> It turns out that this is largely a result of a suboptimal implementation
> of map_word_andequal(). Replacing this function with a straightforward
> one reduces the stack size in this function by exactly 200 bytes,
> shrinks the .text segment for this file from 27648 bytes to 26608 bytes,
> and makes the warning go away.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> index 5f487d776411..7b5841663d4f 100644
> --- a/include/linux/mtd/map.h
> +++ b/include/linux/mtd/map.h
> @@ -314,7 +314,15 @@ static inline map_word map_word_or(struct map_info *map, map_word val1, map_word
>   	return r;
>   }
>
> -#define map_word_andequal(m, a, b, z) map_word_equal(m, z, map_word_and(m, a, b))
> +static inline int map_word_andequal(struct map_info *map, map_word val1, map_word val2, map_word val3)
> +{
> +	int i;

    I think empty line is needed here.

> +	for (i=0; i < map_words(map); i++) {

    Could you please be consistent and surround all binary operators with 
spaces, like on the line below?

> +		if ((val1.x[i] & val2.x[i]) != val3.x[i])
> +			return 0;
> +	}
> +	return 1;
> +}
[...]

WBR, Sergei
