From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Jul 2010 11:36:56 -0400 (EDT)
Subject: [PATCH 06/11] ARM: remove bit-rotten STANDALONE_DEBUG for
	decompressor
In-Reply-To: <1278339329-23739-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
	<1278339329-23739-6-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1007051136110.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jul 2010, Uwe Kleine-K?nig wrote:

> I tried to get this running to debug the regression introduced by
> e7db7b4 without success.  But this has several problems that make it
> hard to fix:
> 
>   - lib/decompress_inflate.c includes in-kernel headers that make
>     it difficult to compile for user space.
>   - the binary formats changed both in kernel and user space and
>     at least for the kernel side there isn't only a single
>     variant.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/boot/compressed/Makefile.debug |   23 -----------------------
>  arch/arm/boot/compressed/misc.c         |   20 --------------------
>  2 files changed, 0 insertions(+), 43 deletions(-)
>  delete mode 100644 arch/arm/boot/compressed/Makefile.debug
> 
> diff --git a/arch/arm/boot/compressed/Makefile.debug b/arch/arm/boot/compressed/Makefile.debug
> deleted file mode 100644
> index 491a037..0000000
> --- a/arch/arm/boot/compressed/Makefile.debug
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -#
> -# linux/arch/arm/boot/compressed/Makefile
> -#
> -# create a compressed vmlinux image from the original vmlinux
> -#
> -
> -COMPRESSED_EXTRA=../../lib/ll_char_wr.o
> -OBJECTS=misc-debug.o ll_char_wr.aout.o
> -
> -CFLAGS=-D__KERNEL__ -O2 -DSTDC_HEADERS -DSTANDALONE_DEBUG -Wall -I../../../../include -c
> -
> -test-gzip: piggy.aout.o $(OBJECTS)
> -	$(CC) -o $@ $(OBJECTS) piggy.aout.o
> -
> -misc-debug.o: misc.c
> -	$(CC) $(CFLAGS) -o $@ misc.c
> -
> -piggy.aout.o: piggy.o
> -	arm-linuxelf-objcopy --change-leading-char -I elf32-arm -O arm-aout32-linux piggy.o piggy.aout.o
> -
> -ll_char_wr.aout.o: $(COMPRESSED_EXTRA)
> -	arm-linuxelf-objcopy --change-leading-char -I elf32-arm -O arm-aout32-linux $(COMPRESSED_EXTRA) ll_char_wr.aout.o
> -
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index d2b2ef4..e653a6d 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -28,9 +28,6 @@ unsigned int __machine_arch_type;
>  
>  #include <asm/unaligned.h>
>  
> -#ifdef STANDALONE_DEBUG
> -#define putstr printf
> -#else
>  
>  static void putstr(const char *ptr);
>  extern void error(char *x);
> @@ -116,7 +113,6 @@ static void putstr(const char *ptr)
>  	flush();
>  }
>  
> -#endif
>  
>  void *memcpy(void *__dest, __const void *__src, size_t __n)
>  {
> @@ -186,7 +182,6 @@ asmlinkage void __div0(void)
>  
>  extern void do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
>  
> -#ifndef STANDALONE_DEBUG
>  
>  unsigned long
>  decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
> @@ -211,18 +206,3 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>  	putstr(" done, booting the kernel.\n");
>  	return output_ptr;
>  }
> -#else
> -
> -char output_buffer[1500*1024];
> -
> -int main()
> -{
> -	output_data = output_buffer;
> -
> -	putstr("Uncompressing Linux...");
> -	decompress(input_data, input_data_end - input_data,
> -			NULL, NULL, output_data, NULL, error);
> -	putstr("done.\n");
> -	return 0;
> -}
> -#endif
> -- 
> 1.7.1
> 
