From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Nov 2013 10:44:32 +0000
Subject: [PATCH 0/2] genirq: arm64: perf: support for percpu pmu interrupt
In-Reply-To: <527D8A17.9020208@codeaurora.org>
References: <1383739658-10036-1-git-send-email-vkale@apm.com>
 <527D8A17.9020208@codeaurora.org>
Message-ID: <20131111104432.GA28302@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 09, 2013 at 01:04:23AM +0000, Stephen Boyd wrote:
> On 11/06/13 04:07, Vinayak Kale wrote:
> > This patch series adds support to handle interrupt registration/deregistration
> > in arm64 pmu driver when pmu interrupt type is percpu.
> >
> > Patches in this patch series were previously sent out as separate patches [1].
> > This patch series incorporates comments/fixes suggested for original patches.
> >
> > [1] 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205888.html
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204414.html 
> >
> > Vinayak Kale (2):
> >   genirq: error reporting in request_percpu_irq() and
> >     request_threaded_irq()
> >   arm64: perf: add support for percpu pmu interrupt
> >
> >  arch/arm64/kernel/perf_event.c |  109 +++++++++++++++++++++++++++++-----------
> >  kernel/irq/manage.c            |   12 +++--
> >  2 files changed, 89 insertions(+), 32 deletions(-)
> >
> 
> What ever happened to the approach here[1]? It doesn't look very nice to
> have to request the irq first as a per-cpu interrupt and then try as a
> non-percpu interrupt when genirq already knows if its per-cpu or not.
> 
> [1] http://lkml.indiana.edu/hypermail/linux/kernel/1207.3/02955.html

Hmm, I'd completely forgotten about that approach. Whilst it certainly looks
cleaner from a user perspective, I always get scared when I see
'desc->status_use_accessors' since it tends to incur the wrath of tglx :)

That said, I guess that should be fine in irqdesc.h (basically adding a new
accessor). Chris went missing after sending those initial patches, so
perhaps Vinayak could look at resurrecting those?

Will
