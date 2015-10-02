From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 02 Oct 2015 12:55:05 +0300
Subject: [PATCH v2 01/15] KVM: arm/arm64: VGIC: don't track used LRs in the
 distributor
In-Reply-To: <1436538111-4294-2-git-send-email-andre.przywara@arm.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-2-git-send-email-andre.przywara@arm.com>
Message-ID: <00cb01d0fcf8$6a906000$3fb12000$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello! One more concern.

> Currently we track which IRQ has been mapped to which VGIC list
> register and also have to synchronize both. We used to do this
> to hold some extra state (for instance the active bit).
> It turns out that this extra state in the LRs is no longer needed and
> this extra tracking causes some pain later.

 Returning to the beginning, can you explain, what kind of pain exactly does it bring?
 For some reasons here i had to keep all this tracking mechanism, and modified your patchset. I see
no significant problems, except memory usage. I have to allocate vgic_irq_lr_map large enough to
hold indexes up to 16384, and indexes from dist->nr_irqs to 8192 appear to be not used.
 Since the map itself is actually used only for piggy-back optimization, it is possible to easily
get rid of it using for_each_set_bit(lr, vgic_cpu->lr_used, vgic->nr_lr) iteration instead. The rest
of mechanism will work as it is, there's no need to remove the state tracking bitmap and
optimization itself.
 I am currently testing this approach and preparing my alternative patch for upstreaming.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
