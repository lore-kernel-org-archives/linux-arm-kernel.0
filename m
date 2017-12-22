From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 22 Dec 2017 09:09:40 +0300
Subject: [PATCH v2] IPI performance benchmark
In-Reply-To: <CANRm+Cx6Lm8r2Oej+-EX=Dz76bvu81rVKD-RU0=LRSNs3dw7mw@mail.gmail.com>
References: <20171219085010.4081-1-ynorov@caviumnetworks.com>
 <CANRm+Cx6Lm8r2Oej+-EX=Dz76bvu81rVKD-RU0=LRSNs3dw7mw@mail.gmail.com>
Message-ID: <20171222060940.f2gjsjelqacdyec3@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 02:44:25PM +0800, Wanpeng Li wrote:
> Hi Yury,
> 2017-12-19 16:50 GMT+08:00 Yury Norov <ynorov@caviumnetworks.com>:
> > This benchmark sends many IPIs in different modes and measures
> > time for IPI delivery (first column), and total time, ie including
> > time to acknowledge the receive by sender (second column).
> >
> > The scenarios are:
> > Dry-run:        do everything except actually sending IPI. Useful
> >                 to estimate system overhead.
> > Self-IPI:       Send IPI to self CPU.
> > Normal IPI:     Send IPI to some other CPU.
> > Broadcast IPI:  Send broadcast IPI to all online CPUs.
> > Broadcast lock: Send broadcast IPI to all online CPUs and force them
> >                 acquire/release spinlock.
> >
> > The raw output looks like this:
> > [  155.363374] Dry-run:                         0,            2999696 ns
> > [  155.429162] Self-IPI:                 30385328,           65589392 ns
> > [  156.060821] Normal IPI:              566914128,          631453008 ns
> > [  158.384427] Broadcast IPI:                   0,         2323368720 ns
> > [  160.831850] Broadcast lock:                  0,         2447000544 ns
> >
> > For virtualized guests, sending and reveiving IPIs causes guest exit.
> > I used this test to measure performance impact on KVM subsystem of
> > Christoffer Dall's series "Optimize KVM/ARM for VHE systems" [1].
> >
> > Test machine is ThunderX2, 112 online CPUs. Below the results normalized
> > to host dry-run time, broadcast lock results omitted. Smaller - better.
> 
> Could you test on a x86 box? I see a lot of calltraces on my haswell
> client host, there is no calltrace in the guest, however, I can still
> observe "Invalid parameters" warning when insmod this module. In
> addition, the x86 box fails to boot when ipi_benchmark is buildin.

EINVAL is returned intentionally to let user run test again without
annoying rmmod.
