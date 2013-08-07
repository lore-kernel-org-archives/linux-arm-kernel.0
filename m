From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 08 Aug 2013 06:50:20 +1000
Subject: [PATCHv7 07/13] irqdomain: add function to find a MSI irq_domain
In-Reply-To: <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375908620.9300.3.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-07 at 11:32 +0200, Thomas Petazzoni wrote:
> Now that an irq_domain can be associated to a msi_chip structure, a
> given PCIe driver will want to find this irq_domain, based on the
> Device Tree node of the interrupt controller, as pointed by the
> 'msi-controller' DT property.

I still don't quite understand why you have to do all that.

> However, since on those platforms a single piece of hardware,
> represented by a single DT node can provide both a "normal" IRQ domain
> and a MSI-type IRQ domain, we need separate lookup functions to
> distinguish them.

At least on power we have cases where an mpic does both MSIs and LSIs,
we have the XICS that happily mixes both in a single large domain,
etc... and never needed any of that.

I don't quite understand what problem that stuff is trying to solve
really. Are you trying to avoid having an added MSI bitmap allocator for
the MSI side of the PIC and use the irq domain stuff both as your virq
and your hwirq allocator ?

> This patch makes irq_find_host() find only non-MSI-type IRQ domains,
> and introduces irq_find_msi_host() to find only MSI-type IRQ
> domains. It does so by factorizing the irq_find_host() logic into
> __irq_find_host().
