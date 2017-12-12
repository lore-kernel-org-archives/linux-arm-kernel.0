From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 Dec 2017 21:40:07 +0100
Subject: [PATCH v7 3/8] KVM: arm/arm64: Don't cache the timer IRQ level
In-Reply-To: <1604e8d6-5f9a-f91d-c199-57f323c09374@redhat.com>
References: <20171207105418.22428-1-christoffer.dall@linaro.org>
 <20171207105418.22428-4-christoffer.dall@linaro.org>
 <24ae6f9e-8f83-6b95-a7a0-d900c37b4a7f@redhat.com>
 <1604e8d6-5f9a-f91d-c199-57f323c09374@redhat.com>
Message-ID: <20171212204007.GP910@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 09:40:10AM +0100, Auger Eric wrote:
> 
> 
> On 11/12/17 21:51, Auger Eric wrote:
> > Hi Christoffer,
> > On 07/12/17 11:54, Christoffer Dall wrote:
> >> The timer was modeled after a strict idea of modelling an interrupt line
> >> level in software, meaning that only transitions in the level needed to
> >> be reported to the VGIC.  This works well for the timer, because the
> >> arch timer code is in complete control of the device and can track the
> >> transitions of the line.
> >>
> >> However, as we are about to support using the HW bit in the VGIC not
> >> just for the timer, but also for VFIO which cannot track transitions of
> >> the interrupt line, we have to decide on an interface for level
> >> triggered mapped interrupts to the GIC, which both the timer and VFIO
> >> can use.
> >>
> >> VFIO only sees an asserting transition of the physical interrupt line,
> >> and tells the VGIC when that happens.  That means that part of the
> >> interrupt flow is offloaded to the hardware.
> >>
> >> To use the same interface for VFIO devices and the timer, we therefore
> >> have to change the timer (we cannot change VFIO because it doesn't know
> >> the details of the device it is assigning to a VM).
> >>
> >> Luckily, changing the timer is simple, we just need to stop 'caching'
> >> the line level, but instead let the VGIC know the state of the timer
> >> every time there is a potential change in the line level, and when the
> >> line level should be asserted from the timer ISR.  The VGIC can ignore
> >> extra notifications using its validate mechanism.
> > 
> > I was confused by the fact we say we stop caching the line level but
> > vtimer->irq.level still exists, is updated in the vtimer host ISR and
> > kvm_timer_update_state() and read in many places.
> > 
> > I feel difficult to figure out if each time we use the vtimer->irq.level
> > value it is safe to use it.
> > 
> > Also for the validate() to succeed we need the vgic irq->line_level to
> > to be 0. I understand this is properly handled for mapped level irqs in
> > next patch which does that on the populate_lr. However I currently fail
> > to understand why the timer level sensitive mapped IRQ does not require
> > the next patch to work.
> OK reading again "[PATCH v7 7/8] KVM: arm/arm64: Provide a
> get_input_level for the arch timer", I now understand it works because
> we had the
> kvm_timer_sync_hwstate toggling down the line on VM exit. After the
> changes of next patch this can be safely removed.

Yes, but also note that this patch in isolation doesn't break anything,
it just ensures that we notify the GIC of an asserted line more often.

> 
> Not related to this patch but I noticed
> Documentation/virtual/kvm/arm/vgic-mapped-irqs.txt now is outdated.

Good point, I have updated the docs and will include that in v8.

Thanks,
-Christoffer
