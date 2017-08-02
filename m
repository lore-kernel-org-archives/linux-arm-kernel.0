From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Aug 2017 15:33:33 +0100
Subject: [PATCH] arm64: defconfig: enable fine-grained task level IRQ
 time accounting
In-Reply-To: <87y3r29ks0.fsf@free-electrons.com>
References: <1501532531-4499-1-git-send-email-mw@semihalf.com>
 <87y3r29ks0.fsf@free-electrons.com>
Message-ID: <20170802143332.7mbfg3lwqocmca7x@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 03:11:43PM +0200, Gregory CLEMENT wrote:
>  On lun., juil. 31 2017, Marcin Wojtas <mw@semihalf.com> wrote:
> > Tests showed, that under certain conditions, the summary number of jiffies
> > spent on softirq/idle, which are counted by system statistics can be even
> > below 10% of expected value, resulting in false load presentation.
> >
> > The issue was observed on the quad-core Marvell Armada 8k SoC, whose two
> > 10G ports were bound into L2 bridge. Load was controlled by bidirectional
> > UDP traffic, produced by a packet generator. Under such condition,
> > the dominant load is softirq. With 100% single CPU occupation or without
> > any activity (all CPUs 100% idle), total number of jiffies is 10000 (2500
> > per each core) in 10s interval. Also with other kind of load this was
> > true.
> >
> > However below a saturation threshold it was observed, that with CPU which
> > was occupied almost by softirqs only, the statistic were awkward. See
> > the mpstat output:
> >
> > CPU %usr %nice %sys %iowait %irq %soft %steal %guest %gnice %idle
> > all 0.00  0.00 0.13    0.00 0.00  0.55   0.00   0.00   0.00 99.32
> >   0 0.00  0.00 0.00    0.00 0.00 23.08   0.00   0.00   0.00 76.92
> >   1 0.00  0.00 0.40    0.00 0.00  0.00   0.00   0.00   0.00 99.60
> >   2 0.00  0.00 0.00    0.00 0.00  0.00   0.00   0.00   0.00 100.00
> >   3 0.00  0.00 0.00    0.00 0.00  0.00   0.00   0.00   0.00 100.00
> >
> > Above would mean basically no total load, debug CPU0 occupied in 25%.
> > Raw statistics, printed every 10s from /proc/stat unveiled a root
> > cause - summary idle/softirq jiffies on loaded CPU were below 200,
> > i.e. over 90% samples lost. All problems were gone after enabling
> > fine granulity IRQ time accounting.
> >
> > This patch fixes possible wrong statistics processing by enabling
> > CONFIG_IRQ_TIME_ACCOUNTING for arm64 platfroms, which is by
> > default done on other architectures, e.g. x86 and arm. Tests
> > showed no noticeable performance penalty, nor stability impact.
> 
> Who should take this patch?
> 
> I think that all the defconfig under arm64 are merged through the
> arm-soc subsystem, but this one is not really specific to a
> SoC. However, as it was experimented on an mvebu SoC, if you agree I
> can take it.

It's fine by me to go via arm-soc.

-- 
Catalin
