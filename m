From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 10:17:09 -0000
Subject: [Kgdb-bugreport] [PATCH] KGDB: add smp_mb() in synchronisation
	during exception handler exit
In-Reply-To: <4B96B771.9050903@wildturkeyranch.net>
References: <1268158831-6976-1-git-send-email-will.deacon@arm.com>
	<4B96B771.9050903@wildturkeyranch.net>
Message-ID: <001101cac03a$d84d4820$88e7d860$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi George,

> > diff --git a/kernel/kgdb.c b/kernel/kgdb.c
> > index 761fdd2..ee7694b 100644
> > --- a/kernel/kgdb.c
> > +++ b/kernel/kgdb.c
> > @@ -1537,6 +1537,7 @@ acquirelock:
> >   		 * Wait till all the CPUs have quit
> >   		 * from the debugger.
> >   		 */
> > +		smp_mb();
> >   		for_each_online_cpu(i) {
> >   			while (atomic_read(&cpu_in_kgdb[i]))
> >   				cpu_relax();
> >
> Doesn't this have the same issue if this cpu gets to the while prior to
> the other cpu doing its write.  I would think the "smp_mb()" should be
> in the while loop not prior to it.

I don't think so. The deadlock in question is caused because the aggressive
reading in the polling loop prevents the write-buffer from being able to drain.
For a dual-core system the setup can be simplified like this:

Initially: x = 1, y = 1;

CPU1                        CPU0
====                        ====
while (y == 1);             y = 0;
x = 0;                      while (x == 1); /* This loop prevents y from
                                               leaving the store buffer */

So the patch inserts a memory barrier on CPU0 between the two lines,
forcing the update to y to become visible before the reads to x occur.
CPU1 will then trundle along happily and update x. The absence of a further 
polling loop means that the update to x will become visible to CPU0 at some
future time.

Cheers,

Will
