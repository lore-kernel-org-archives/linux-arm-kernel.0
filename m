From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 21 Dec 2017 22:02:52 +0300
Subject: [PATCH v2] IPI performance benchmark
In-Reply-To: <CANRm+Cx6Lm8r2Oej+-EX=Dz76bvu81rVKD-RU0=LRSNs3dw7mw@mail.gmail.com>
References: <20171219085010.4081-1-ynorov@caviumnetworks.com>
 <CANRm+Cx6Lm8r2Oej+-EX=Dz76bvu81rVKD-RU0=LRSNs3dw7mw@mail.gmail.com>
Message-ID: <20171221190232.76xijcqtjwb7u323@yury-thinkpad>
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

I tried to boot kernel with builtin test both on real hardware and
qemu+kvm - no calltraces or other problems. Kernel is 4.14, config for
host is attached.

CPU is Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz

Kernel is 4.14, config for host is attached, but it's default Ubuntu
config. Results and qemu command are below. Could you share more details
about your configuration?

Yury

qemu-system-x86_64 -hda debian_squeeze_amd64_standard.qcow2	\
	-smp 1 -curses --nographic --enable-kvm

Host, 4 cores:
[    0.237279] Dry-run:                         0,             170292 ns
[    0.643269] Self-IPI:                458516336,          922256372 ns
[    0.902545] Self-IPI:                508518362,          972130665 ns
[    0.646500] Broadcast IPI:                   0,           97301545 ns
[    0.649712] Broadcast lock:                  0,          102364755 ns

KVM, single core:
[    0.237279] Dry-run:                         0,             124500 ns
[    0.643269] Self-IPI:                202518310,          405444790 ns
[    0.643694] Normal IPI FAILED: -2
[    0.646500] Broadcast IPI:                   0,            2524370 ns
[    0.649712] Broadcast lock:                  0,            2642270 ns

KVM, 4 cores:
[    0.492676] Dry-run:                         0,             126380 ns
[    0.902545] Self-IPI:                204085450,          409863800 ns
[    2.179676] Normal IPI:             1058014940,         1276742820 ns
[    3.396132] Broadcast IPI:                   0,         1215934730 ns
[    4.610719] Broadcast lock:                  0,         1213945500 ns
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/gzip
Size: 38449 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171221/0d9308cd/attachment-0001.gz>
