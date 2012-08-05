From: robherring2@gmail.com (Rob Herring)
Date: Sat,  4 Aug 2012 20:23:59 -0500
Subject: [PATCH v2 4/5] ARM: use generic termios.h
In-Reply-To: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
Message-ID: <1344129840-16447-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

As pointed out by Arnd Bergmann, this fixes a couple of issues but will
increase code size:

The original macro user_termio_to_kernel_termios was not endian safe. It
used an unsigned short ptr to access the low bits in a 32-bit word.

Both user_termio_to_kernel_termios and kernel_termios_to_user_termio are
missing error checking on put_user/get_user and copy_to/from_user.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Reviewed-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/Kbuild    |    1 +
 arch/arm/include/asm/termios.h |   92 ----------------------------------------
 2 files changed, 1 insertion(+), 92 deletions(-)
 delete mode 100644 arch/arm/include/asm/termios.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index a86cabf..8a7196c 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -31,6 +31,7 @@ generic-y += sizes.h
 generic-y += socket.h
 generic-y += sockios.h
 generic-y += termbits.h
+generic-y += termios.h
 generic-y += timex.h
 generic-y += types.h
 generic-y += unaligned.h
diff --git a/arch/arm/include/asm/termios.h b/arch/arm/include/asm/termios.h
deleted file mode 100644
index 293e3f1..0000000
--- a/arch/arm/include/asm/termios.h
+++ /dev/null
@@ -1,92 +0,0 @@
-#ifndef __ASM_ARM_TERMIOS_H
-#define __ASM_ARM_TERMIOS_H
-
-#include <asm/termbits.h>
-#include <asm/ioctls.h>
-
-struct winsize {
-	unsigned short ws_row;
-	unsigned short ws_col;
-	unsigned short ws_xpixel;
-	unsigned short ws_ypixel;
-};
-
-#define NCC 8
-struct termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[NCC];	/* control characters */
-};
-
-#ifdef __KERNEL__
-/*	intr=^C		quit=^|		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-#endif
-
-/* modem lines */
-#define TIOCM_LE	0x001
-#define TIOCM_DTR	0x002
-#define TIOCM_RTS	0x004
-#define TIOCM_ST	0x008
-#define TIOCM_SR	0x010
-#define TIOCM_CTS	0x020
-#define TIOCM_CAR	0x040
-#define TIOCM_RNG	0x080
-#define TIOCM_DSR	0x100
-#define TIOCM_CD	TIOCM_CAR
-#define TIOCM_RI	TIOCM_RNG
-#define TIOCM_OUT1	0x2000
-#define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP	0x8000
-
-/* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-
-#ifdef __KERNEL__
-
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) {		\
-	unsigned short __tmp;					\
-	get_user(__tmp,&(termio)->x);				\
-	*(unsigned short *) &(termios)->x = __tmp;		\
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
-
-#endif	/* __KERNEL__ */
-
-#endif	/* __ASM_ARM_TERMIOS_H */
-- 
1.7.9.5
