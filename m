From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Oct 2011 18:04:25 -0500
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <4EA1B3D5.9070802@gmail.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111017082506.GC21648@n2100.arm.linux.org.uk>
	<20111017092342.GB2459@mudshark.cambridge.arm.com>
	<201110201657.51810.arnd@arndb.de>
	<20111021105941.GE30168@mudshark.cambridge.arm.com>
	<4EA18638.6020809@gmail.com>
	<20111021151511.GK30168@mudshark.cambridge.arm.com>
	<4EA1B3D5.9070802@gmail.com>
Message-ID: <4EA1FA79.2070901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2011 01:03 PM, Rob Herring wrote:
> On 10/21/2011 10:15 AM, Will Deacon wrote:
>> Hi Rob,
>>
>> On Fri, Oct 21, 2011 at 03:48:24PM +0100, Rob Herring wrote:
>>> On 10/21/2011 05:59 AM, Will Deacon wrote:
>>>> 2. The GIC is hosed on versatile express. Reverting e3f14d3 ("ARM: gic: add
>>>>    OF based initialization") and 2071a2a4 ("ARM: gic: add irq_domain support")
>>>>    allows me to boot again.

[snip]

>> [    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> [    0.000000] Preemptible hierarchical RCU implementation.
>> [    0.000000] NR_IRQS:128 nr_irqs:128 128
> 
> It is working for me. You're booting with sparse irq. ARM's support of
> sparse irq is essentially broken. It does not sparsely allocate
> irq_descs, but allocates all nr_irqs irq_descs.
> 
> The following patch fixes things and is more in line with other arch's
> implementations of arch_probe_nr_irqs. I need to fix mnp platforms
> still. Any platform that enables sparse irq needs to either set
> machine_desc->nr_irqs or properly call irq_alloc_descs.
> 
> Rob
> 
> From: Rob Herring <rob.herring@calxeda.com>
> Date: Tue, 13 Sep 2011 15:08:37 -0500
> Subject: [PATCH] ARM: fix sparse irq pre-allocations
> 
> Returning NR_IRQS in arch_probe_nr_irqs makes SPARSE_IRQ behave the same as
> !SPARSE_IRQ in that NR_IRQ irqdescs are allocated. There is some advantage
> that NR_IRQ is run-time vs. compile time, but sparse irq is crippled on
> ARM. With irqdomains, each interrupt controller should allocate the
> irqdescs that it needs.
> 
> If machine_desc->nr_irqs is set, then the irqdescs will be pre-allocated.
> If the default NR_IRQS is used then no irqdescs will be pre-allocated.
> 
> Perhaps 0-16 should be reserved for IPIs on SMP?
> 
> There are 3 users of SPARSE_IRQ: pxa, mnp, and shmobile. shmobile is the
> only platform that correctly allocates irqdescs. This commit will break
> mnp platforms which don't set nr_irqs.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/kernel/irq.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index de3dcab..b32f438 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -133,8 +133,11 @@ void __init init_IRQ(void)
>  #ifdef CONFIG_SPARSE_IRQ
>  int __init arch_probe_nr_irqs(void)
>  {
> -	nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
> -	return nr_irqs;
> +	if (machine_desc->nr_irqs) {
> +		nr_irqs = machine_desc->nr_irqs;
> +		return nr_irqs;
> +	}
> +	return 0;
>  }
>  #endif
> 

While I think this is the right fix, this will break platforms which
don't set nr_irqs or have a mixture of irq_chips with and without
explicit irq_desc allocations (and SPARSE_IRQ on). There is a more
simple fix I'm working on to set machine_desc->nr_irqs to NR_IRQ_LEGACY
on all machines with a gic.

Rob
