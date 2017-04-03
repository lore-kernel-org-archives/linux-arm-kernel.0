From: kamensky@cisco.com (Victor Kamensky)
Date: Sun,  2 Apr 2017 22:45:13 -0700
Subject: [PATCH] fix armv8 kernel generation of SIGSEGV upon unaligned access 
Message-ID: <1491198314-17025-1-git-send-email-kamensky@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Catalin,

I discovered that on latest ARMv8 kernel, starting with 4.5, unaligned
access by aarch32 ldm instruction (and similar others) produces SIGSEGV
to process, which seems to be wrong. On 4.4 kernel the same test
produced SIGBUS. The issue was tracked back to 52d7523 (arm64: mm: allow
the kernel to handle alignment faults on user accesses)

Following patch proposes the fix. And here are more details and
test case that illustrates the issue.

Please note I do not have an idea how to reproduce the issue mentioned
by 52d7523. I presume that __do_kernel_fault called by do_bad_area will
still take care of it.

Tested system: armv8 kernel and aarch32 rootfs
----------------------------------------------

Note it is ARMv8 kernel and aarch32 rootfs. I thought using unaligned
aarch32 ldm is good way to illustrate the issue. My understanding that
with aarch64 instructions only unaligned access to device memory will
produce unaligned exception, but which is much harder to reproduce.

root at arm-sdk-generic:~/align# uname -a
Linux arm-sdk-generic 4.4.58 #1 SMP PREEMPT Thu Mar 30 21:03:34 PDT 2017 aarch64 aarch64 aarch64 GNU/Linux
root at arm-sdk-generic:~/align# file /lib/systemd/systemd
/lib/systemd/systemd: ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32, BuildID[sha1]=5c8e03b21f46227d69ad8690ed80ba4ff54b61b3, stripped

Test Code: that produces unaligned access with ldm instructions
---------------------------------------------------------------

root at arm-sdk-generic:~/align# ls
Makefile  align.h  align1.c  main.c
root at arm-sdk-generic:~/align# cat main.c 
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include "align.h"

static void
sigbus_sa_sigaction(int sig, siginfo_t *context, void *uctx)
{
	printf("%s: got sigbus, sig = %d\n", __FUNCTION__, sig);
	_exit(1);
}

static void
sigsegv_sa_sigaction(int sig, siginfo_t *context, void *uctx)
{
	printf("%s: got sigsegv, should not be here, sig = %d\n", __FUNCTION__, sig);
	_exit(2);
}

void register_signals(void)
{
        struct sigaction sa, sa_old;
	sa.sa_sigaction = sigbus_sa_sigaction;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGBUS, &sa, &sa_old);
	
	sa.sa_sigaction = sigsegv_sa_sigaction;
	sigaction(SIGSEGV, &sa, &sa_old);

}

int main (void)
{
	char buf[]="0123456789012345";
	int result;
	register_signals();
	result = load_two((struct twoelem *) (buf + 1));
	printf("result = 0x%x\n", result);
	return 0;
}
root at arm-sdk-generic:~/align# cat align.h 
struct twoelem {
	int i;
	int j;
};

int load_two(struct twoelem *);
root at arm-sdk-generic:~/align# cat align1.c 
#include "align.h"

int load_two (struct twoelem *s) {
	return s->i + s->j;
}
root at arm-sdk-generic:~/align# cat Makefile 
all: align

CC=gcc
CFLAGS=-O2 -g

align: align1.o main.o
	$(CC) $(CFLAGS) -o $@ $^
clean:
	@rm -r align *.o
root at arm-sdk-generic:~/align# make
gcc -O2 -g   -c -o align1.o align1.c
gcc -O2 -g   -c -o main.o main.c
gcc -O2 -g -o align align1.o main.o
root at arm-sdk-generic:~/align# objdump --disassemble align1.o

align1.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <load_two>:
   0:	e8900005 	ldm	r0, {r0, r2}
   4:	e0820000 	add	r0, r2, r0
   8:	e12fff1e 	bx	lr
root at arm-sdk-generic:~/align# 

On 4.4 kernel SIGBUS received and unsolicted message from kernel produced
-------------------------------------------------------------------------

That is what we see on our 4.4 kernel: correct signal SIGBUS is invoked.
But kernel produces unsolicited message, "Unhandled fault: alignment fault",
for every signal: that is what I wanted to fix first.

root at arm-sdk-generic:~/align# uname -a
Linux arm-sdk-generic 4.4.58 #1 SMP PREEMPT Thu Mar 30 21:03:34 PDT 2017 aarch64 aarch64 aarch64 GNU/Linux
root at arm-sdk-generic:~/align# ./align 
Unhandled fault: alignment fault (0x92000021) at 0x00000000fff6b955
sigbus_sa_sigaction: got sigbus, sig = 7
root at arm-sdk-generic:~/align# 

On 4.11-rc4 kernel SIGSEGV received upon the same fault
-------------------------------------------------------

On latest kernel when I've tried the same test I discovered that
process now gets SIGSEGV instead of SIGBUS when unaligned ldm instruction
is executed. Tracked it down to 52d7523 (arm64: mm: allow the kernel
to handle alignment faults on user accesses), which got at kernel
starting with 4.5.

root at arm-sdk-generic:~/align# uname -a
Linux arm-sdk-generic 4.11.0-rc4 #1 SMP PREEMPT Thu Mar 30 20:19:56 PDT 2017 aarch64 aarch64 aarch64 GNU/Linux
root at arm-sdk-generic:~/align# ./align 
sigsegv_sa_sigaction: got sigsegv, should not be here, sig = 11
root at arm-sdk-generic:~/align# 

On 4.11-rc4 with my fix, back to SIGBUS
---------------------------------------

After my proposed fix, getting SIGBUS again.

root at arm-sdk-generic:~/align# uname -a
Linux arm-sdk-generic 4.11.0-rc4+ #2 SMP PREEMPT Thu Mar 30 23:53:36 PDT 2017 aarch64 aarch64 aarch64 GNU/Linux
root at arm-sdk-generic:~/align# ./align 
sigbus_sa_sigaction: got sigbus, sig = 7
root at arm-sdk-generic:~/align# 

Thanks,
Victor

Victor Kamensky (1):
  arm64: mm: unaligned access by user-land should be received as SIGBUS

 arch/arm64/mm/fault.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.9.3
