From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Apr 2017 16:44:16 +0100
Subject: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
In-Reply-To: <20170426123947.ogap6xgg7xc5wsd4@yury-N73SV>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
 <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
 <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
 <20170420190530.GA6873@worktop>
 <20170426123947.ogap6xgg7xc5wsd4@yury-N73SV>
Message-ID: <20170428154416.GW13675@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 03:39:47PM +0300, Yury Norov wrote:
> On Thu, Apr 20, 2017 at 09:05:30PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 20, 2017 at 09:23:18PM +0300, Yury Norov wrote:
> > > Is there some test to reproduce the locking failure for the case.
> > 
> > Possibly sysvsem stress before commit:
> > 
> >   27d7be1801a4 ("ipc/sem.c: avoid using spin_unlock_wait()")
> > 
> > Although a similar scheme is also used in nf_conntrack, see commit:
> > 
> >   b316ff783d17 ("locking/spinlock, netfilter: Fix nf_conntrack_lock() barriers")
> > 
> > > I
> > > ask because I run loctorture for many hours on my qemu (emulating
> > > cortex-a57), and I see no failures in the test reports. And Jan did it
> > > on ThunderX, and Adam on QDF2400 without any problems. So even if I
> > > rework those functions, how could I check them for correctness?
> > 
> > Running them doesn't prove them correct. Memory ordering bugs have been
> > in the kernel for many years without 'ever' triggering. This is stuff
> > you have to think about.
> > 
> > > Anyway, regarding the queued_spin_unlock_wait(), is my understanding
> > > correct that you assume adding smp_mb() before entering the for(;;)
> > > cycle, and using ldaxr/strxr instead of atomic_read()?
> > 
> > You'll have to ask Will, I always forget the arm64 details.
> 
> So, below is what I have. For queued_spin_unlock_wait() the generated
> code is looking like this:
> ffff0000080983a0 <queued_spin_unlock_wait>:
> ffff0000080983a0:       d5033bbf        dmb     ish
> ffff0000080983a4:       b9400007        ldr     w7, [x0]
> ffff0000080983a8:       350000c7        cbnz    w7, ffff0000080983c0 <queued_spin_unlock_wait+0x20>
> ffff0000080983ac:       1400000e        b       ffff0000080983e4 <queued_spin_unlock_wait+0x44>
> ffff0000080983b0:       d503203f        yield
> ffff0000080983b4:       d5033bbf        dmb     ish
> ffff0000080983b8:       b9400007        ldr     w7, [x0]
> ffff0000080983bc:       34000147        cbz     w7, ffff0000080983e4 <queued_spin_unlock_wait+0x44>
> ffff0000080983c0:       f2401cff        tst     x7, #0xff
> ffff0000080983c4:       54ffff60        b.eq    ffff0000080983b0 <queued_spin_unlock_wait+0x10>
> ffff0000080983c8:       14000003        b       ffff0000080983d4 <queued_spin_unlock_wait+0x34>
> ffff0000080983cc:       d503201f        nop
> ffff0000080983d0:       d503203f        yield
> ffff0000080983d4:       d5033bbf        dmb     ish
> ffff0000080983d8:       b9400007        ldr     w7, [x0]
> ffff0000080983dc:       f2401cff        tst     x7, #0xff
> ffff0000080983e0:       54ffff81        b.ne    ffff0000080983d0 <queued_spin_unlock_wait+0x30>
> ffff0000080983e4:       d50339bf        dmb     ishld
> ffff0000080983e8:       d65f03c0        ret
> ffff0000080983ec:       d503201f        nop
> 
> If I understand the documentation correctly, it's enough to check the lock
> properly. If not - please give me the clue. Will?

Sorry, but I haven't had time to page this back in recently, so I can't give
you an answer straight off the bat. I'll need to go back and revisit the
qspinlock parts and, in particular, use of WFE before I'm comfortable with
this. I also don't want this on by default for the arm64 kernel, and I'd
like to see numbers comparing with our ticket locks on silicon with and
without the large system extensions, for low (<=8), medium (8-32) and high
(>32) core counts.

I'm very nervous about switching our locking implementation over to
something that's largely been developed and tested for x86, which has a
stronger memory model.

Will
