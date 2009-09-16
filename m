From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 16 Sep 2009 22:14:25 +0800
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <200909160926.02036.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
Message-ID: <f17812d70909160714j1f691361k2a71d57d847e6e05@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't remember we had such problems before. What kind of system
and libraries are you using?


On Wed, Sep 16, 2009 at 3:26 PM, Juergen Schindele <schindele@nentec.de> wrote:
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
> This is free software; see the source for copying conditions. ?There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> and here the C-code compiled with ?"arm-none-linux-gnueabi-gcc -o test test.c -lpthread"
>
> #include <errno.h>
> #include <error.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <pthread.h>
> #include <time.h>
>
> #define NUM_THREADS 10
> #define NUM_ITERS ? 50
> #define TIMEOUT_NS ?100000000L
>
> static void *thread (void *);
> static int argument[NUM_THREADS];
> static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
> static pthread_attr_t defaultattr;
>
> static void * print_thread (void *arg)
> {
> ? ?int i;
> ? ?int number = *((int*)arg);
>
> ? ?for (;;) {
> ? ? ? ?pthread_t self = pthread_self ();
> ? ? ? ?printf ("Thread %d is [%d]\n", number, self);
> ? ?}
> }
>
> int main (void)
> {
> ? ?pthread_t th;
> ? ?int i, retvalue;
>
> ? ?struct sched_param param;
> ? ?pthread_attr_init(&defaultattr);
>
> ? ?pthread_attr_setschedpolicy(&defaultattr, SCHED_RR);
>
> ? ?param.sched_priority = 10;
> ? ?if ((retvalue = pthread_attr_setschedparam(&defaultattr, &param))!=0) {
> ? ? ? ?printf ("ERROR\n");
> ? ? ? ?exit (0);
> ? ?}
>
> ? ?for (i = 0; i < NUM_THREADS; i++)
> ? ?{
> ? ? ? ?argument[i] = i;
> ? ? ? ?if (pthread_create (&th, &defaultattr, print_thread, &argument[i]) != 0)
> ? ? ? ? ? ?error (EXIT_FAILURE, 0, "cannot create thread");
> ? ? ? ?printf ("Thread [%d]\n", i);
> ? ?}
>
> ? ?while (1) {
> ? ? ? ?;
> ? ?}
>
> ? ?/* notreached */
> ? ?return 0;
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
> E-Mail: ?schindele at nentec.de
> WEB: ? ? www.nentec.de
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
