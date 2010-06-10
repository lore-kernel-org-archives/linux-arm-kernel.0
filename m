From: herman_swartz@yahoo.com (Herman Swartz)
Date: Thu, 10 Jun 2010 14:13:57 -0700 (PDT)
Subject: Fw: Context Switching is Broken
In-Reply-To: <4C114200.6030307@fifthhorseman.net>
References: <121634.13810.qm@web51801.mail.re2.yahoo.com>
	<4C110181.6000109@fifthhorseman.net>
	<4C110600.4050808@telefonica.net>
	<4C114200.6030307@fifthhorseman.net>
Message-ID: <468524.82182.qm@web51805.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





----- Forwarded Message ----
From: Herman Swartz <herman_swartz@yahoo.com>
To: debian-arm at lists.debian.org
Sent: Thu, June 10, 2010 5:12:35 PM
Subject: Re: Context Switching is Broken

Hi,

I was having trouble getting to the list so did not immediately put in details until now.

------------- From dmesg to show my cpu.

[??? 0.000000] Initializing cgroup subsys cpuset
[??? 0.000000] Initializing cgroup subsys cpu
[??? 0.000000] Linux version 2.6.32-trunk-kirkwood (Debian 2.6.32-5) (ben at decadent.org.uk) (gcc version 4.3.4 (Debian 4.3.4-6) ) #1 Mon Jan 11 10:57:12 UTC 2010
[??? 0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
[??? 0.000000] CPU: VIVT data cache, VIVT instruction cache
[??? 0.000000] Machine: Marvell SheevaPlug Reference Board
[??? 0.000000] Memory policy: ECC disabled, Data cache writeback
[??? 0.000000] On node 0 totalpages: 131072
[??? 0.000000] free_area_init_node: node 0, pgdat c03d0904, node_mem_map c0dbc000
[??? 0.000000]?? Normal zone: 1024 pages used for memmap
[??? 0.000000]?? Normal zone: 0 pages reserved
[??? 0.000000]?? Normal zone: 130048 pages, LIFO batch:31
[??? 0.000000] Built 1 zonelists in Zone order, mobility grouping on.? Total pages: 130048

---------- Tail end of make output

/home/gpetrov/jnos2/ksubr.c:31: warning: warning: getcontext is not implemented and will always fail
net.a(kernel.o): In function `pwait':
/home/gpetrov/jnos2/kernel.c:346: warning: warning: setcontext is not implemented and will always fail
net.a(ksubr.o): In function `psetup':
/home/gpetrov/jnos2/ksubr.c:166: warning: warning: makecontext is not implemented and will always fail
net.a(kernel.o): In function `pwait':
/home/gpetrov/jnos2/kernel.c:348: warning: warning: swapcontext is not implemented and will always fail

----------- directories where library files are located

debian:/home/gpetrov/Ctest# find / -name "ucontext.h"
/usr/include/asm-generic/ucontext.h
/usr/include/ucontext.h
/usr/include/sys/ucontext.h
debian:/home/gpetrov/Ctest#

------- from one of the ucontext.h library files above...

debian:/usr/include# ls ucontext.h
ucontext.h
debian:/usr/include# less ucontext.h
/* Get user context and store it in variable pointed to by UCP.? */
extern int getcontext (ucontext_t *__ucp) __THROW;
/* Set user context from information of variable pointed to by UCP.? */
extern int setcontext (__const ucontext_t *__ucp) __THROW;
/* Save current context in context variable pointed to by OUCP and set
?? context from variable pointed to by UCP.? */
extern int swapcontext (ucontext_t *__restrict __oucp,
??????????????????????? __const ucontext_t *__restrict __ucp) __THROW;
/* Manipulate user context UCP to continue with calling functions FUNC
?? and the ARGC-1 parameters following ARGC when the context is used
?? the next time in `setcontext' or `swapcontext'.
?? We cannot say anything about the parameters FUNC takes; `void'
?? is as good as any other choice.? */
extern void makecontext (ucontext_t *__ucp, void (*__func) (void),
???????????????????????? int __argc, ...) __THROW;
__END_DECLS
#endif /* ucontext.h */


Does the CPU support context switching, from looking around I think it does since there is an addon for improving context switching performance of this model of ARM processor.

JNOS application developer believes there is no support for context switching. Seems to be a kernel issue to me but maybe the make is not finding the library files??

What do you think?

Thanks
Herman



----- Original Message ----
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To: Xan <dxpublica@telefonica.net>
Cc: debian-arm at lists.debian.org; Herman Swartz <herman_swartz@yahoo.com>
Sent: Thu, June 10, 2010 3:50:24 PM
Subject: Re: Context Switching is Broken

On 06/10/2010 11:34 AM, Xan wrote:
> Maybe you refer to texexec. Try "man texexec". Does it work?

I also do not have a texexec manual page.? Is this related to ARM on debian?

Could you try being more explicit about exactly what you're doing, what
you expect to happen, and what is actually happening?

??? --dkg


      
