From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 26 Sep 2014 10:04:45 +0800
Subject: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
In-Reply-To: <20140925071919.GH12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
 <20140925071919.GH12423@ulmo>
Message-ID: <5424C9BD.3040506@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/25 15:19, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
>> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
>> use irq chip_data to save the msi_chip pointer. They
>> already call irq_set_chip_data() in their own MSI irq map
>> functions. So irq_set_chip_data() in arch_setup_msi_irq()
>> is useless.
> 
> Again, I think this should be the other way around. If drivers do
> something that's already handled by the core, then the duplicate code
> should be dropped from the drivers.

Hi Thierry, this is different thing, because chip_data is specific to IRQ
controller, and in other platform, like in x86, chip_data is used to save irq_cfg.
So we can not call irq_set_chip_data() in core code.

x86 irq piece code

int arch_setup_hwirq(unsigned int irq, int node)
{
	struct irq_cfg *cfg;
	unsigned long flags;
	int ret;

	cfg = alloc_irq_cfg(irq, node);
	if (!cfg)
		return -ENOMEM;

	raw_spin_lock_irqsave(&vector_lock, flags);
	ret = __assign_irq_vector(irq, cfg, apic->target_cpus());
	raw_spin_unlock_irqrestore(&vector_lock, flags);

	if (!ret)
		irq_set_chip_data(irq, cfg);  ------------->Save irq_cfg
	else
		free_irq_cfg(irq, cfg);
	return ret;
}

Thanks!
Yijing.

> 
> Thierry
> 


-- 
Thanks!
Yijing
