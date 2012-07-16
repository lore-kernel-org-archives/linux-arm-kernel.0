From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 10:51:58 +0000
Subject: [PATCH 1/3] ARM: use generic version of identical asm headers
In-Reply-To: <1342410836-6010-2-git-send-email-robherring2@gmail.com>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-2-git-send-email-robherring2@gmail.com>
Message-ID: <201207161051.58878.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Inspired by the AArgh64 claim that it should be separate from ARM and one
> reason was being able to use more asm-generic headers. Doing a diff of
> arch/arm/include/asm and include/asm-generic there are numerous asm
> headers which are functionally identical to their asm-generic counterparts.
> Delete the ARM version and use the generic ones.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Great stuff!

I had a similar series once but lost it when the kernel.org went down.
I've looked at all your patches and noticed two files that are changing
semantically with your patch. If we want to have the generic behavior,
it's probably best to do those as separate patches.


> -/*
> - * Translate a "termio" structure into a "termios". Ugh.
> - */
> -#define SET_LOW_TERMIOS_BITS(termios, termio, x) {		\
> -	unsigned short __tmp;					\
> -	get_user(__tmp,&(termio)->x);				\
> -	*(unsigned short *) &(termios)->x = __tmp;		\
> -}
> -
> -#define user_termio_to_kernel_termios(termios, termio) \
> -({ \
> -	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
> -	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
> -	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
> -	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
> -	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
> -})

This code is not endian-safe, which means it's currently broken
on big-endian machines. Using the asm-generic version fixes that
problem but increases the code sizes.

> -/*
> - * Translate a "termios" structure into a "termio". Ugh.
> - */
> -#define kernel_termios_to_user_termio(termio, termios) \
> -({ \
> -	put_user((termios)->c_iflag, &(termio)->c_iflag); \
> -	put_user((termios)->c_oflag, &(termio)->c_oflag); \
> -	put_user((termios)->c_cflag, &(termio)->c_cflag); \
> -	put_user((termios)->c_lflag, &(termio)->c_lflag); \
> -	put_user((termios)->c_line,  &(termio)->c_line); \
> -	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
> -})

This code is missing error handling, and again fixing this
will increase the code size.

I think it's a good idea to fix these two issues, but let's
use a separate patch for it.

> diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
> deleted file mode 100644
> index 44593a8..0000000
> --- a/arch/arm/include/asm/unaligned.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -#ifndef _ASM_ARM_UNALIGNED_H
> -#define _ASM_ARM_UNALIGNED_H
> -
> -#include <linux/unaligned/le_byteshift.h>
> -#include <linux/unaligned/be_byteshift.h>
> -#include <linux/unaligned/generic.h>
> -
> -/*
> - * Select endianness
> - */
> -#ifndef __ARMEB__
> -#define get_unaligned	__get_unaligned_le
> -#define put_unaligned	__put_unaligned_le
> -#else
> -#define get_unaligned	__get_unaligned_be
> -#define put_unaligned	__put_unaligned_be
> -#endif
> -
> -#endif /* _ASM_ARM_UNALIGNED_H */

The asm-generic version uses the "struct" version for native-endian
unaligned access and the "byteshift" version for the opposite endianess.
The current ARM version however uses the "byteshift" implementation for
both. I don't know what works better on ARM, but I'd say we should not
change it unless we understand the effects.

	Arnd
