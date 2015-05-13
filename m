From: tj@kernel.org (Tejun Heo)
Date: Wed, 13 May 2015 10:39:06 -0400
Subject: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
In-Reply-To: <20150512114647.GN10428@rric.localhost>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
 <20150504160652.GB1971@htj.duckdns.org>
 <20150511171810.GB29499@rric.localhost>
 <20150512114647.GN10428@rric.localhost>
Message-ID: <20150513143906.GV11388@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 12, 2015 at 01:46:47PM +0200, Robert Richter wrote:
> I don't think this is worth the effort as all internal and external
> drivers need to be changed basically from:
> 
>  ahci_host_activate(host, irq, &ahci_sht);
> 
> to:
> 
>  host->irq = irq;
>  ahci_host_activate(host, &ahci_sht);
>
> This looks not very useful to do. Since irq is used only a single
> time, there is no reason to store it in the host's data structure. It

Doesn't really matter tho.

> also makes the interface more error prone since host->irq might not be
> setup. Apart from that there is an abi change.

But large part of @host needs to be initialized before activation.  I
don't think moving irq to that pool changes much if anything.

> I agree that we will need the implemention of host->ports[i]->irq for
> the case there irqs are no longer in sequential order as this might be
> the case for per-port msi-x interrupts. But this is not the focus of
> my implementation and as long there is no hardware for this available,
> it wouldn't make sense to implement this at all.

Why are we doing msix at all?  I don't get it.

> So how to proceed? I could send you patches that implement host->irq
> for a single per-host interrupt, and also one that reworks multi-port
> interrupts to use host->ports[i]->irq. But I don't see any benefit
> here. That said, I would better keep my patch here as it is. That do
> you think?

Let's start with why we're doing this in the first place.

Thanks.

-- 
tejun
