From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Thu, 20 Nov 2014 20:08:14 -0600
Subject: [PATCH] irqdomain: Fix NULL pointer dererence in
 irq_domain_free_irqs_parent
In-Reply-To: <alpine.DEB.2.11.1411210219370.6439@nanos>
References: <1416531745-24661-1-git-send-email-suravee.suthikulpanit@amd.com>
 <alpine.DEB.2.11.1411210219370.6439@nanos>
Message-ID: <546E9E8E.5000303@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2014 07:32 PM, Thomas Gleixner wrote:
> On Thu, 20 Nov 2014, suravee.suthikulpanit at amd.com wrote:
>> This patch checks if the parent domain is NULL before recursively freeing
>> irqs in the parent domains.
>
> Which is nonsense, because if the thing has not been allocated in the
> first place, then it cannot explode in the free path magically, except
> there is a missing check in the allocation path error handling.
>
> And that's obviously not the case simply because this originates from:
>> [<fffffe0000449278>] pci_disable_msix+0x40/0x50
>

Thomas,

In this case, I have the following irq domain hierarchy:

[GIC] -- [GICv2m] -- [MSI]

which recursively calling the freeing function:

In GIC domain, it currently defines the struct irq_domain_ops.free() with :
   --> irq_domain_free_irqs_top()
     |--> irq_domain_free_irqs_common()
       |--> irq_domain_free_irq_parent()
         |--> irq_domain_free_irqs_recursive()

and there is no check before passing the NULL domain->parent into the 
irq_domain_free_irqs_recursive(), which causes the error.

Since the GIC is the top most domain, it does not have parent domain.
So, I'm not sure what is missing from the allocation path error 
handling, as you mentioned.

Thanks,

Suravee
