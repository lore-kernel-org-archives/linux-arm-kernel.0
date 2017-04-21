From: slash.tmp@free.fr (Mason)
Date: Fri, 21 Apr 2017 09:58:58 +0200
Subject: linux-next: build failure after merge of the arm tree
In-Reply-To: <20170421084033.5c987e13@canb.auug.org.au>
References: <20170421084033.5c987e13@canb.auug.org.au>
Message-ID: <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2017 00:40, Stephen Rothwell wrote:

> After merging the arm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from include/linux/bitops.h:36:0,
>                  from include/linux/bitmap.h:7,
>                  from drivers/dma/sun4i-dma.c:11:
> drivers/dma/sun4i-dma.c: In function 'find_and_use_pchan':
> include/linux/bitops.h:56:34: error:
> passing argument 1 of '_find_next_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   for ((bit) = find_next_zero_bit((addr), (size), (bit)); \
>                                   ^
> arch/arm/include/asm/bitops.h:200:61: note: in definition of macro 'find_next_zero_bit'
>  #define find_next_zero_bit(p,sz,off) _find_next_zero_bit_le(p,sz,off)
>                                                              ^
> drivers/dma/sun4i-dma.c:241:2: note: in expansion of macro 'for_each_clear_bit_from'
>   for_each_clear_bit_from(i, &priv->pchans_used, max) {
>   ^
> arch/arm/include/asm/bitops.h:163:12: note:
> expected 'const long unsigned int *' but argument is of type 'long unsigned int (*)[1]'
>  extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
>             ^
> [...]
> 
> Caused (or exposed) by commit
> 
>   c4f8ff16b46b ("ARM: 8669/1: bitops: Align prototypes to generic API")
> 
> I have used the arm tree from next-20170420 for today.

Weird that I didn't catch this when I ran make allyesconfig.
https://www.spinics.net/lists/arm-kernel/msg573736.html

Anyway, the fix is trivial.

The "pchans_used" field is an unsigned long array.
for_each_clear_bit_from() expects an unsigned long pointer,
not an array address.

I'll send a patch to the drivers/dma maintainers.

$ make C=2 drivers/dma/sun4i-dma.o
  CHECK   drivers/dma/sun4i-dma.c
  CC      drivers/dma/sun4i-dma.o

Regards.
