From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Jul 2016 14:44:02 +0200 (CEST)
Subject: [PATCH v11 06/10] genirq/msi-doorbell: msi_doorbell_safe
In-Reply-To: <3f188661-1d68-199b-3fcc-4da432bae633@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-7-git-send-email-eric.auger@redhat.com>
 <alpine.DEB.2.11.1607201010350.3564@nanos>
 <3f188661-1d68-199b-3fcc-4da432bae633@redhat.com>
Message-ID: <alpine.DEB.2.11.1607221443090.3906@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jul 2016, Auger Eric wrote:
> On 20/07/2016 10:12, Thomas Gleixner wrote:
> > On Tue, 19 Jul 2016, Eric Auger wrote:
> >> +bool msi_doorbell_safe(void)
> >> +{
> >> +	struct irqchip_doorbell *db;
> >> +	bool irq_remapping = true;
> >> +
> >> +	mutex_lock(&irqchip_doorbell_mutex);
> >> +	list_for_each_entry(db, &irqchip_doorbell_list, next) {
> >> +		irq_remapping &= db->info.irq_remapping;
> > 
> > db->info.irq_remapping is set in msi_doorbell_register(). So you can keep book
> > about that there. No need to iterate here.
> Yes makes sense to store the info at registration time. Currently this
> function is not in any fast path but that's cleaner from a general
> perspective. I will need to do such iteration at un-registration though.

Two simple counter should be sufficient.

  nr_registered_bells;
  nr_remapped_bells;

....

Thanks,

	tglx
