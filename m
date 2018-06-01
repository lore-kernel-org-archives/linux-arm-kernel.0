From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 1 Jun 2018 13:56:59 +0100
Subject: [PATCH v2]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69F3004A@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69F1300F@G01JPEXMBKW03>
 <86d0xhaucm.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F3004A@G01JPEXMBKW03>
Message-ID: <31bede40-dbc5-0a88-d12c-5fc79ea02391@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On 01/06/18 13:44, Zhang, Lei wrote:
> Hi Marc
> 
> I have reviewed your patch.	 
> I think the approach is same between your patch and mine.
> Your patch is simpler and more beautiful, and match our bus's requirement.
> 
> I have only one question.
> According your patch, if there are no enough lpis, amount of lpis required
> will be divide by 2. it means someone want 16 lpis, maybe they can only get 8?
> I don?t' understand why we need it.

That's the way the MSI allocation works in the kernel.

A driver asks a number of MSIs (let's imagine, for example, one MSI per
CPU in the system), but the underlying HW can only provide a smaller number.

Instead of failing and just returning an error, we reduce the allocation
in order to provide the driver with something. If that's not enough,
well, the driver itself will have the opportunity to give up.

See pci_alloc_irq_vectors_affinity(), which takes a min and a max number
of vectors, for example.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
