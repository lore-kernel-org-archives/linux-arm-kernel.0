From: schindele@nentec.de (Juergen Schindele)
Date: Thu, 24 Sep 2009 10:34:33 +0200
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <200909160926.02036.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
Message-ID: <200909241034.33483.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. September 2009 schrieb Juergen Schindele:
Hey all,
i've done some tests on different platforms

running OK on x86 openSuse 11.0
- SCHED_OTHER OK
- SCHED_RR OK


on pxa270 (xscale) platform
compiler gcc 4.2.0
with glibc 2.5 (NPTL) from CodeSourcery
Sourcery G++ Lite 2007q1-10
on Kernel 2.6.20
- SCHED_OTHER works fine
- SCHED_RR does not work at all

on the same pxa270 (xscale) platform
compiler gcc 4.3.3
and glibc 2.8 (NPTL)  from CodeSourcery
Sourcery G++ Lite 2009q1-203
Kernel 2.6.20
- SCHED_OTHER only one thread is running all the time
  other threads are blocked.
- SCHED_RR does not work at all

on ixp425 (xscale) platform
compiler 3.3.2
with glibc 2.2.5 (not NPTL)
from uclinux
kernel 2.6.16
- SCHED_OTHER
First no thread are running. 30 minutes after starting the test all threads
are started and running. It's unbeleivable !!.
-SCHED_RR does not work at all

Why is SCHED_RR only running on x86 platform ???
Where is the difference in handling between SCHED_RR ans SCHED_OTHER ?
Any comments or helps ????

> Hello all,
> we tried to implement a thread based software on our PXA270 based platform but
> we had trouble with pthreads. So i modyfied a tiny progam to test. This little progam creates
> 10 threads and each thread does print something (an index an a pointer to itself). 
> 
> On my PC with Suse 11.0 Linux (kernel 2.6.27) this works fine as supposed to.
> Each thread has his turn and print his own values.
> 
> But on our pxa270 platform the thread switch does not (or really rarely) happen
> and only one thread is printing always the same values. So i suppose thread
> switching is not working!
> 
> Any hints or experiences are welcome !!!
> 
> we use codesourcery compiler
> arm-none-linux-gnueabi-gcc (CodeSourcery Sourcery G++ Lite 2007q1-10) 4.2.0 20070413 (prerelease)
> Copyright (C) 2007 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> and here the C-code compiled with  "arm-none-linux-gnueabi-gcc -o test test.c -lpthread"
> 
> #include <errno.h>
> #include <error.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <pthread.h>
> #include <time.h>
> 
> #define NUM_THREADS 10
> #define NUM_ITERS   50
> #define TIMEOUT_NS  100000000L
> 
> static void *thread (void *);
> static int argument[NUM_THREADS];
> static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
> static pthread_attr_t defaultattr;
> 
> static void * print_thread (void *arg)
> {
>     int i;
>     int number = *((int*)arg);
> 
>     for (;;) {
>         pthread_t self = pthread_self ();
>         printf ("Thread %d is [%d]\n", number, self);
>     }
> }
> 
> int main (void)
> {
>     pthread_t th;
>     int i, retvalue;
> 
>     struct sched_param param;
>     pthread_attr_init(&defaultattr);
> 
>     pthread_attr_setschedpolicy(&defaultattr, SCHED_RR);
> 
>     param.sched_priority = 10;
>     if ((retvalue = pthread_attr_setschedparam(&defaultattr, &param))!=0) {
>         printf ("ERROR\n");
>         exit (0);
>     }
> 
>     for (i = 0; i < NUM_THREADS; i++)
>     {
>         argument[i] = i;
>         if (pthread_create (&th, &defaultattr, print_thread, &argument[i]) != 0)
>             error (EXIT_FAILURE, 0, "cannot create thread");
>         printf ("Thread [%d]\n", i);
>     }
> 
>     while (1) {
>         ;
>     }
> 
>     /* notreached */
>     return 0;
> }
> 
> --------------------------------------------------------------
> J?rgen Schindele  
> Software-Entwicklung
> 
> NENTEC Netzwerktechnologie GmbH
> Greschbachstr. 12
> 76229 Karlsruhe
> Deutschland
> Telefon: +49 721 94249-51
> Telefax: +49 721 94249-10
> E-Mail:  schindele at nentec.de
> WEB:     www.nentec.de
>  
> Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
> Sitz der Gesellschaft: Karlsruhe
> Handelsregister: Amtsgericht Mannheim HRB 107658
> --------------------------------------------------------------
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 



-- 
--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------
