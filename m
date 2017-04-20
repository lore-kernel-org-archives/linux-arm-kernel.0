From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 20 Apr 2017 21:05:30 +0200
Subject: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
In-Reply-To: <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
 <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
 <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
Message-ID: <20170420190530.GA6873@worktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 09:23:18PM +0300, Yury Norov wrote:
> Is there some test to reproduce the locking failure for the case.

Possibly sysvsem stress before commit:

  27d7be1801a4 ("ipc/sem.c: avoid using spin_unlock_wait()")

Although a similar scheme is also used in nf_conntrack, see commit:

  b316ff783d17 ("locking/spinlock, netfilter: Fix nf_conntrack_lock() barriers")

> I
> ask because I run loctorture for many hours on my qemu (emulating
> cortex-a57), and I see no failures in the test reports. And Jan did it
> on ThunderX, and Adam on QDF2400 without any problems. So even if I
> rework those functions, how could I check them for correctness?

Running them doesn't prove them correct. Memory ordering bugs have been
in the kernel for many years without 'ever' triggering. This is stuff
you have to think about.

> Anyway, regarding the queued_spin_unlock_wait(), is my understanding
> correct that you assume adding smp_mb() before entering the for(;;)
> cycle, and using ldaxr/strxr instead of atomic_read()?

You'll have to ask Will, I always forget the arm64 details.
