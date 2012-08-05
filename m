From: robherring2@gmail.com (Rob Herring)
Date: Sat,  4 Aug 2012 20:23:56 -0500
Subject: [PATCH v2 1/5] ARM: use generic version of identical asm headers
In-Reply-To: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
Message-ID: <1344129840-16447-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Inspired by the AArgh64 claim that it should be separate from ARM and one
reason was being able to use more asm-generic headers. Doing a diff of
arch/arm/include/asm and include/asm-generic there are numerous asm
headers which are functionally identical to their asm-generic counterparts.
Delete the ARM version and use the generic ones.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Reviewed-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/Kbuild     |   15 +++
 arch/arm/include/asm/current.h  |   15 ---
 arch/arm/include/asm/exec.h     |    6 --
 arch/arm/include/asm/ipcbuf.h   |    1 -
 arch/arm/include/asm/msgbuf.h   |   31 ------
 arch/arm/include/asm/param.h    |   31 ------
 arch/arm/include/asm/parport.h  |   18 ----
 arch/arm/include/asm/segment.h  |   11 ---
 arch/arm/include/asm/sembuf.h   |   25 -----
 arch/arm/include/asm/serial.h   |   19 ----
 arch/arm/include/asm/shmbuf.h   |   42 ---------
 arch/arm/include/asm/socket.h   |   72 --------------
 arch/arm/include/asm/sockios.h  |   13 ---
 arch/arm/include/asm/termbits.h |  198 ---------------------------------------
 arch/arm/include/asm/timex.h    |    6 +-
 arch/arm/include/asm/types.h    |   16 ----
 16 files changed, 17 insertions(+), 502 deletions(-)
 delete mode 100644 arch/arm/include/asm/current.h
 delete mode 100644 arch/arm/include/asm/exec.h
 delete mode 100644 arch/arm/include/asm/ipcbuf.h
 delete mode 100644 arch/arm/include/asm/msgbuf.h
 delete mode 100644 arch/arm/include/asm/param.h
 delete mode 100644 arch/arm/include/asm/parport.h
 delete mode 100644 arch/arm/include/asm/segment.h
 delete mode 100644 arch/arm/include/asm/sembuf.h
 delete mode 100644 arch/arm/include/asm/serial.h
 delete mode 100644 arch/arm/include/asm/shmbuf.h
 delete mode 100644 arch/arm/include/asm/socket.h
 delete mode 100644 arch/arm/include/asm/sockios.h
 delete mode 100644 arch/arm/include/asm/termbits.h
 delete mode 100644 arch/arm/include/asm/types.h

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 960abce..6cc8a13 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -5,16 +5,31 @@ header-y += hwcap.h
 generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += cputime.h
+generic-y += current.h
 generic-y += emergency-restart.h
 generic-y += errno.h
+generic-y += exec.h
 generic-y += ioctl.h
+generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += local.h
 generic-y += local64.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += parport.h
 generic-y += percpu.h
 generic-y += poll.h
 generic-y += resource.h
 generic-y += sections.h
+generic-y += segment.h
+generic-y += sembuf.h
+generic-y += serial.h
+generic-y += shmbuf.h
 generic-y += siginfo.h
 generic-y += sizes.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += termbits.h
+generic-y += timex.h
+generic-y += types.h
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
deleted file mode 100644
index 75d21e2..0000000
--- a/arch/arm/include/asm/current.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef _ASMARM_CURRENT_H
-#define _ASMARM_CURRENT_H
-
-#include <linux/thread_info.h>
-
-static inline struct task_struct *get_current(void) __attribute_const__;
-
-static inline struct task_struct *get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current (get_current())
-
-#endif /* _ASMARM_CURRENT_H */
diff --git a/arch/arm/include/asm/exec.h b/arch/arm/include/asm/exec.h
deleted file mode 100644
index 7c4fbef..0000000
--- a/arch/arm/include/asm/exec.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_ARM_EXEC_H
-#define __ASM_ARM_EXEC_H
-
-#define arch_align_stack(x) (x)
-
-#endif /* __ASM_ARM_EXEC_H */
diff --git a/arch/arm/include/asm/ipcbuf.h b/arch/arm/include/asm/ipcbuf.h
deleted file mode 100644
index 84c7e51..0000000
--- a/arch/arm/include/asm/ipcbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/arm/include/asm/msgbuf.h b/arch/arm/include/asm/msgbuf.h
deleted file mode 100644
index 33b35b9..0000000
--- a/arch/arm/include/asm/msgbuf.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef _ASMARM_MSGBUF_H
-#define _ASMARM_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for arm architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned long	__unused1;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned long	__unused2;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long	__unused3;
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-#endif /* _ASMARM_MSGBUF_H */
diff --git a/arch/arm/include/asm/param.h b/arch/arm/include/asm/param.h
deleted file mode 100644
index 8b24bf94..0000000
--- a/arch/arm/include/asm/param.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *  arch/arm/include/asm/param.h
- *
- *  Copyright (C) 1995-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_PARAM_H
-#define __ASM_PARAM_H
-
-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* User interfaces are in "ticks" */
-# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
-#else
-# define HZ		100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP         (-1)
-#endif
-
-/* max length of hostname */
-#define MAXHOSTNAMELEN  64
-
-#endif
-
diff --git a/arch/arm/include/asm/parport.h b/arch/arm/include/asm/parport.h
deleted file mode 100644
index 26e94b0..0000000
--- a/arch/arm/include/asm/parport.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/include/asm/parport.h: ARM-specific parport initialisation
- *
- *  Copyright (C) 1999, 2000  Tim Waugh <tim@cyberelk.demon.co.uk>
- *
- * This file should only be included by drivers/parport/parport_pc.c.
- */
-
-#ifndef __ASMARM_PARPORT_H
-#define __ASMARM_PARPORT_H
-
-static int __devinit parport_pc_find_isa_ports (int autoirq, int autodma);
-static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
-{
-	return parport_pc_find_isa_ports (autoirq, autodma);
-}
-
-#endif /* !(_ASMARM_PARPORT_H) */
diff --git a/arch/arm/include/asm/segment.h b/arch/arm/include/asm/segment.h
deleted file mode 100644
index 9e24c21..0000000
--- a/arch/arm/include/asm/segment.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __ASM_ARM_SEGMENT_H
-#define __ASM_ARM_SEGMENT_H
-
-#define __KERNEL_CS   0x0
-#define __KERNEL_DS   0x0
-
-#define __USER_CS     0x1
-#define __USER_DS     0x1
-
-#endif /* __ASM_ARM_SEGMENT_H */
-
diff --git a/arch/arm/include/asm/sembuf.h b/arch/arm/include/asm/sembuf.h
deleted file mode 100644
index 1c02839..0000000
--- a/arch/arm/include/asm/sembuf.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef _ASMARM_SEMBUF_H
-#define _ASMARM_SEMBUF_H
-
-/* 
- * The semid64_ds structure for arm architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused1;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	__unused2;
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _ASMARM_SEMBUF_H */
diff --git a/arch/arm/include/asm/serial.h b/arch/arm/include/asm/serial.h
deleted file mode 100644
index ebb0490..0000000
--- a/arch/arm/include/asm/serial.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  arch/arm/include/asm/serial.h
- *
- *  Copyright (C) 1996 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Changelog:
- *   15-10-1996	RMK	Created
- */
-
-#ifndef __ASM_SERIAL_H
-#define __ASM_SERIAL_H
-
-#define BASE_BAUD	(1843200 / 16)
-
-#endif
diff --git a/arch/arm/include/asm/shmbuf.h b/arch/arm/include/asm/shmbuf.h
deleted file mode 100644
index 2e5c67b..0000000
--- a/arch/arm/include/asm/shmbuf.h
+++ /dev/null
@@ -1,42 +0,0 @@
-#ifndef _ASMARM_SHMBUF_H
-#define _ASMARM_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for arm architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _ASMARM_SHMBUF_H */
diff --git a/arch/arm/include/asm/socket.h b/arch/arm/include/asm/socket.h
deleted file mode 100644
index 6433cad..0000000
--- a/arch/arm/include/asm/socket.h
+++ /dev/null
@@ -1,72 +0,0 @@
-#ifndef _ASMARM_SOCKET_H
-#define _ASMARM_SOCKET_H
-
-#include <asm/sockios.h>
-
-/* For setsockopt(2) */
-#define SOL_SOCKET	1
-
-#define SO_DEBUG	1
-#define SO_REUSEADDR	2
-#define SO_TYPE		3
-#define SO_ERROR	4
-#define SO_DONTROUTE	5
-#define SO_BROADCAST	6
-#define SO_SNDBUF	7
-#define SO_RCVBUF	8
-#define SO_SNDBUFFORCE	32
-#define SO_RCVBUFFORCE	33
-#define SO_KEEPALIVE	9
-#define SO_OOBINLINE	10
-#define SO_NO_CHECK	11
-#define SO_PRIORITY	12
-#define SO_LINGER	13
-#define SO_BSDCOMPAT	14
-/* To add :#define SO_REUSEPORT 15 */
-#define SO_PASSCRED	16
-#define SO_PEERCRED	17
-#define SO_RCVLOWAT	18
-#define SO_SNDLOWAT	19
-#define SO_RCVTIMEO	20
-#define SO_SNDTIMEO	21
-
-/* Security levels - as per NRL IPv6 - don't actually do anything */
-#define SO_SECURITY_AUTHENTICATION		22
-#define SO_SECURITY_ENCRYPTION_TRANSPORT	23
-#define SO_SECURITY_ENCRYPTION_NETWORK		24
-
-#define SO_BINDTODEVICE 25
-
-/* Socket filtering */
-#define SO_ATTACH_FILTER        26
-#define SO_DETACH_FILTER        27
-
-#define SO_PEERNAME             28
-#define SO_TIMESTAMP		29
-#define SCM_TIMESTAMP		SO_TIMESTAMP
-
-#define SO_ACCEPTCONN		30
-
-#define SO_PEERSEC		31
-#define SO_PASSSEC		34
-#define SO_TIMESTAMPNS		35
-#define SCM_TIMESTAMPNS		SO_TIMESTAMPNS
-
-#define SO_MARK			36
-
-#define SO_TIMESTAMPING		37
-#define SCM_TIMESTAMPING	SO_TIMESTAMPING
-
-#define SO_PROTOCOL		38
-#define SO_DOMAIN		39
-
-#define SO_RXQ_OVFL             40
-
-#define SO_WIFI_STATUS		41
-#define SCM_WIFI_STATUS		SO_WIFI_STATUS
-#define SO_PEEK_OFF		42
-
-/* Instruct lower device to use last 4-bytes of skb data as FCS */
-#define SO_NOFCS		43
-
-#endif /* _ASM_SOCKET_H */
diff --git a/arch/arm/include/asm/sockios.h b/arch/arm/include/asm/sockios.h
deleted file mode 100644
index a2588a2..0000000
--- a/arch/arm/include/asm/sockios.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ARCH_ARM_SOCKIOS_H
-#define __ARCH_ARM_SOCKIOS_H
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif
diff --git a/arch/arm/include/asm/termbits.h b/arch/arm/include/asm/termbits.h
deleted file mode 100644
index 704135d..0000000
--- a/arch/arm/include/asm/termbits.h
+++ /dev/null
@@ -1,198 +0,0 @@
-#ifndef __ASM_ARM_TERMBITS_H
-#define __ASM_ARM_TERMBITS_H
-
-typedef unsigned char	cc_t;
-typedef unsigned int	speed_t;
-typedef unsigned int	tcflag_t;
-
-#define NCCS 19
-struct termios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-};
-
-struct termios2 {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-
-/* c_cc characters */
-#define VINTR 0
-#define VQUIT 1
-#define VERASE 2
-#define VKILL 3
-#define VEOF 4
-#define VTIME 5
-#define VMIN 6
-#define VSWTC 7
-#define VSTART 8
-#define VSTOP 9
-#define VSUSP 10
-#define VEOL 11
-#define VREPRINT 12
-#define VDISCARD 13
-#define VWERASE 14
-#define VLNEXT 15
-#define VEOL2 16
-
-/* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IUCLC	0001000
-#define IXON	0002000
-#define IXANY	0004000
-#define IXOFF	0010000
-#define IMAXBEL	0020000
-#define IUTF8	0040000
-
-/* c_oflag bits */
-#define OPOST	0000001
-#define OLCUC	0000002
-#define ONLCR	0000004
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-#define OFILL	0000100
-#define OFDEL	0000200
-#define NLDLY	0000400
-#define   NL0	0000000
-#define   NL1	0000400
-#define CRDLY	0003000
-#define   CR0	0000000
-#define   CR1	0001000
-#define   CR2	0002000
-#define   CR3	0003000
-#define TABDLY	0014000
-#define   TAB0	0000000
-#define   TAB1	0004000
-#define   TAB2	0010000
-#define   TAB3	0014000
-#define   XTABS	0014000
-#define BSDLY	0020000
-#define   BS0	0000000
-#define   BS1	0020000
-#define VTDLY	0040000
-#define   VT0	0000000
-#define   VT1	0040000
-#define FFDLY	0100000
-#define   FF0	0000000
-#define   FF1	0100000
-
-/* c_cflag bit meaning */
-#define CBAUD	0010017
-#define  B0	0000000		/* hang up */
-#define  B50	0000001
-#define  B75	0000002
-#define  B110	0000003
-#define  B134	0000004
-#define  B150	0000005
-#define  B200	0000006
-#define  B300	0000007
-#define  B600	0000010
-#define  B1200	0000011
-#define  B1800	0000012
-#define  B2400	0000013
-#define  B4800	0000014
-#define  B9600	0000015
-#define  B19200	0000016
-#define  B38400	0000017
-#define EXTA B19200
-#define EXTB B38400
-#define CSIZE	0000060
-#define   CS5	0000000
-#define   CS6	0000020
-#define   CS7	0000040
-#define   CS8	0000060
-#define CSTOPB	0000100
-#define CREAD	0000200
-#define PARENB	0000400
-#define PARODD	0001000
-#define HUPCL	0002000
-#define CLOCAL	0004000
-#define CBAUDEX 0010000
-#define    BOTHER 0010000
-#define    B57600 0010001
-#define   B115200 0010002
-#define   B230400 0010003
-#define   B460800 0010004
-#define   B500000 0010005
-#define   B576000 0010006
-#define   B921600 0010007
-#define  B1000000 0010010
-#define  B1152000 0010011
-#define  B1500000 0010012
-#define  B2000000 0010013
-#define  B2500000 0010014
-#define  B3000000 0010015
-#define  B3500000 0010016
-#define  B4000000 0010017
-#define CIBAUD	  002003600000		/* input baud rate */
-#define CMSPAR    010000000000		/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000		/* flow control */
-
-#define IBSHIFT	   16
-
-/* c_lflag bits */
-#define ISIG	0000001
-#define ICANON	0000002
-#define XCASE	0000004
-#define ECHO	0000010
-#define ECHOE	0000020
-#define ECHOK	0000040
-#define ECHONL	0000100
-#define NOFLSH	0000200
-#define TOSTOP	0000400
-#define ECHOCTL	0001000
-#define ECHOPRT	0002000
-#define ECHOKE	0004000
-#define FLUSHO	0010000
-#define PENDIN	0040000
-#define IEXTEN	0100000
-#define EXTPROC	0200000
-
-/* tcflow() and TCXONC use these */
-#define	TCOOFF		0
-#define	TCOON		1
-#define	TCIOFF		2
-#define	TCION		3
-
-/* tcflush() and TCFLSH use these */
-#define	TCIFLUSH	0
-#define	TCOFLUSH	1
-#define	TCIOFLUSH	2
-
-/* tcsetattr uses these */
-#define	TCSANOW		0
-#define	TCSADRAIN	1
-#define	TCSAFLUSH	2
-
-#endif	/* __ASM_ARM_TERMBITS_H */
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index ce11944..5e71172 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -15,12 +15,10 @@
 #include <asm/arch_timer.h>
 #include <mach/timex.h>
 
-typedef unsigned long cycles_t;
-
 #ifdef ARCH_HAS_READ_CURRENT_TIMER
 #define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
-#else
-#define get_cycles()	(0)
 #endif
 
+#include <asm-generic/timex.h>
+
 #endif
diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
deleted file mode 100644
index 28beab9..0000000
--- a/arch/arm/include/asm/types.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef __ASM_ARM_TYPES_H
-#define __ASM_ARM_TYPES_H
-
-#include <asm-generic/int-ll64.h>
-
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-#ifdef __KERNEL__
-
-#define BITS_PER_LONG 32
-
-#endif /* __KERNEL__ */
-
-#endif
-
-- 
1.7.9.5
