From: feng.wu@intel.com (Wu, Feng)
Date: Tue, 7 Jul 2015 11:18:09 +0000
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <559BB463.6090406@redhat.com>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025F342B@SHSMSX104.ccr.corp.intel.com>
 <559BB167.1030603@redhat.com>
 <E959C4978C3B6342920538CF579893F0025F34FC@SHSMSX104.ccr.corp.intel.com>
 <559BB463.6090406@redhat.com>
Message-ID: <E959C4978C3B6342920538CF579893F0025F3568@SHSMSX104.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini at redhat.com]
> Sent: Tuesday, July 07, 2015 7:14 PM
> To: Wu, Feng; Eric Auger; eric.auger at st.com;
> linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org; christoffer.dall at linaro.org; marc.zyngier at arm.com;
> alex.williamson at redhat.com; avi.kivity at gmail.com; mtosatti at redhat.com;
> joro at 8bytes.org; b.reynal at virtualopensystems.com
> Cc: linux-kernel at vger.kernel.org; patches at linaro.org
> Subject: Re: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
> control
> 
> 
> 
> On 07/07/2015 13:13, Wu, Feng wrote:
> >> > You can use container_of to add it to your own struct, e.g.
> >> >
> >> > 	struct irq_bypass_consumer cons;
> >> > 	struct irq_bypass_producer *prod;
> > Do you mean this:
> >
> > struct kvm_kernel_irqfd {
> >
> > 	......
> >
> > 	struct irq_bypass_consumer cons;
> > 	struct irq_bypass_producer *prod;
> > };
> 
> Yes.

Then I still need assign prod and de-assign prod in irq_bypass_register_consumer/irq_bypass_unregister_consumer,
Right? Would you please share why this is better. My original though is as below:

diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
index 8f62235..11930c1 100644
--- a/include/linux/irqbypass.h
+++ b/include/linux/irqbypass.h
@@ -20,6 +20,7 @@ struct irq_bypass_producer {
 struct irq_bypass_consumer {
        struct list_head node;
        void *token;
+       struct irq_bypass_producer *producer;
        void (*stop)(struct irq_bypass_consumer *);
        void (*resume)(struct irq_bypass_consumer *);
        void (*add_producer)(struct irq_bypass_consumer *,
diff --git a/kernel/irq/bypass.c b/kernel/irq/bypass.c
index efadbe5..be2da25 100644
--- a/kernel/irq/bypass.c
+++ b/kernel/irq/bypass.c
@@ -122,6 +122,7 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)

        list_for_each_entry(producer, &producers, node) {
                if (producer->token == consumer->token) {
+                       consumer->producer = producer;
                        connect(producer, consumer);
                        break;
                }
@@ -140,6 +141,7 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)

        list_for_each_entry(producer, &producers, node) {
                if (producer->token == consumer->token) {
+                       consumer->producer = NULL;
                        disconnect(producer, consumer);
                        break;
                }

Thanks,
Feng

> 
> Paolo
