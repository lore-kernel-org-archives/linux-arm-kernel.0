From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 15:23:32 +0200
Subject: [PATCHv3 2/3] ARM: mm: add support for HW coherent systems in
 PL310
In-Reply-To: <1400145519-28530-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <6040564.qIx1dK4Lix@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 11:18:38 Thomas Petazzoni wrote:
> When a PL310 cache is used on a system that provides hardware
> coherency, the outer cache sync operation is useless, and can be
> skipped. Moreover, on some systems, it is harmful as it causes
> deadlocks between the Marvell coherency mechanism, the Marvell PCIe
> controller and the Cortex-A9.
> 
> To avoid this, this commit introduces a new Device Tree property
> 'dma-coherent' for the L2 cache controller node, valid only for the
> PL310 cache. It identifies the usage of the PL310 cache in an I/O
> coherent configuration. Internally, it makes the driver use a
> different set of l2x0_of_data, in which the ->sync operation is NULL.
> 
> Note that technically speaking, a fully coherent system wouldn't
> require any of the other .outer_cache operations. However, in
> practice, when booting secondary CPUs, these are not yet coherent, and
> therefore a set of cache maintenance operations are necessary at this
> point. This explains why we keep the other .outer_cache operations and
> only ->sync is disabled.
> 
> While in theory any write to a PL310 register could cause the
> deadlock, in practice, disabling ->sync is sufficient to workaround
> the deadlock, since the other cache maintenance operations are only
> used in very specific situations.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
