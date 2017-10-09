From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 9 Oct 2017 15:49:21 +0300
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <20171009095935.GC5127@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <20171008213052.ojyxpr56d2ypscjy@yury-thinkpad>
 <20171009095935.GC5127@arm.com>
Message-ID: <20171009124921.wtbzvqagges44brq@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 10:59:36AM +0100, Will Deacon wrote:
> Hi Yury,
> 
> On Mon, Oct 09, 2017 at 12:30:52AM +0300, Yury Norov wrote:
> > On Fri, Oct 06, 2017 at 02:34:37PM +0100, Will Deacon wrote:
> > > This is version two of the patches I posted yesterday:
> > > 
> > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html
> > > 
> > > I'd normally leave it longer before posting again, but Peter had a good
> > > suggestion to rework the layout of the lock word, so I wanted to post a
> > > version that follows that approach.
> > > 
> > > I've updated my branch if you're after the full patch stack:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock
> > > 
> > > As before, all comments (particularly related to testing and performance)
> > > welcome!
> > > 
> > I tested your patches with locktorture and found measurable performance
> > regression. I also respin the patch of Jan Glauber [1], and I also
> > tried Jan's patch with patch 5 from this series. Numbers differ a lot
> > from my previous measurements, but since that I changed working
> > station and use qemu with the support of parallel threads.
> >                         Spinlock        Read-RW lock    Write-RW lock
> > Vanilla:                129804626       12340895        14716138
> > This series:            113718002       10982159        13068934
> > Jan patch:              117977108       11363462        13615449
> > Jan patch + #5:         121483176       11696728        13618967
> > 
> > The bottomline of discussion [1] was that queued locks are more
> > effective when SoC has many CPUs. And 4 is not many. My measurement
> > was made on the 4-CPU machine, and it seems it confirms that. Does
> > it make sense to make queued locks default for many-CPU machines only?
> 
> Just to confirm, you're running this under qemu on an x86 host, using full
> AArch64 system emulation? If so, I really don't think we should base the
> merits of qrwlocks on arm64 around this type of configuration. Given that
> you work for a silicon vendor, could you try running on real arm64 hardware
> instead, please?

I don't have the hardware access at the moment. I'll run the test when
I'll get it.

> My measurements on 6-core and 8-core systems look a lot
> better with qrwlock than what we currently have in mainline, and they
> also fix a real starvation issue reported by Jeremy [1].
> 
> I'd also add that lock fairness comes at a cost, so I'd expect a small drop
> in total throughput for some workloads. I encourage you to try passing
> different arguments to locktorture to see this in action. For example, on
> an 8-core machine:
> 
> # insmod ./locktorture.ko nwriters_stress=2 nreaders_stress=8 torture_type="rw_lock_irq" stat_interval=2
> 
> -rc3:
> 
>   Writes:  Total: 6612  Max/Min: 0/0   Fail: 0
>   Reads :  Total: 1265230  Max/Min: 0/0   Fail: 0
>   Writes:  Total: 6709  Max/Min: 0/0   Fail: 0
>   Reads :  Total: 1916418  Max/Min: 0/0   Fail: 0
>   Writes:  Total: 6725  Max/Min: 0/0   Fail: 0
>   Reads :  Total: 5103727  Max/Min: 0/0   Fail: 0
> 
> notice how the writers are really struggling here (you only have to tweak a
> bit more and you get RCU stalls, lose interrupts etc).
> 
> With the qrwlock:
> 
>   Writes:  Total: 47962  Max/Min: 0/0   Fail: 0
>   Reads :  Total: 277903  Max/Min: 0/0   Fail: 0
>   Writes:  Total: 100151  Max/Min: 0/0   Fail: 0
>   Reads :  Total: 525781  Max/Min: 0/0   Fail: 0
>   Writes:  Total: 155284  Max/Min: 0/0   Fail: 0
>   Reads :  Total: 767703  Max/Min: 0/0   Fail: 0
> 
> which is an awful lot better for maximum latency and fairness, despite the
> much lower reader count.
> 
> > There were 2 preparing patches in the series: 
> > [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock
> > and
> > [PATCH 2/3] asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h
> > 
> > 1st patch is not needed anymore because Babu Moger submitted similar patch that
> > is already in mainline: 9ab6055f95903 ("kernel/locking: Fix compile error with
> > qrwlock.c"). Could you revisit second patch?
> 
> Sorry, not sure what you're asking me to do here.

It removes unneeded #include <linux/atomic.h> in
include/asm-generic/qspinlock_types.h. Could you or someone else take
it upstream?
 
> Will
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534299.html
