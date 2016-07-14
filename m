From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Jul 2016 11:52:17 +0100
Subject: [PATCH v9 00/17] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <20160713015909.28793-1-andre.przywara@arm.com>
References: <20160713015909.28793-1-andre.przywara@arm.com>
Message-ID: <57876EE1.3020905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/16 02:58, Andre Przywara wrote:
> Hi,
> 
> this series allows those KVM guests that use an emulated GICv3 to use LPIs
> as well, though in the moment this is limited to emulated PCI devices.
> This is based on kvmarm/queue, which now only features the new VGIC
> implementation.
> 
> Another round of changes after another round of review: some bugs fixed,
> some reworks in various places. The register sanitisation has been changed
> to be more readable and to add some missing masking.
> The MMIO dispatching has been simplified (region type no longer in each
> register description). Also the its_lock is now taken already in the
> command dispatching function instead of each command handler, which
> removes quite some "goto out_unlock;" and return value variables.
> Also it turned out we can get rid of the special vgic_put_irq_locked()
> variant. The changelog below holds a more detailed list.
> 
> You can find all of this code (and the prerequisites) in the
> its-emul/v9 branch of my repository [1].
> This has been briefly tested on the model and on GICv3 hardware, with
> lockdep debugging enabled. If you have GICv3 capable hardware, please
> test it on your setup.
> Also of course any review comments are very welcome!

I'm done with that round. Couple of annoying bugs, and still a bunch of
loose ends to be tied. Timing wise, this is getting pretty tight for
4.8, so unless you address the comments very quickly, it will be a miss
again.

My plan is to cut the 4.8 branch at the end of this week, so you have
until then to repost something that I can stick into -next.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
