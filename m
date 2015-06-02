From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Jun 2015 14:04:57 +0100
Subject: [PATCH 3/4]: Change arm-gic-its to support the Mbigen interrupt
In-Reply-To: <556D94C1.6060300@huawei.com>
References: <55692C32.2050209@huawei.com> <556C2226.70502@arm.com>
 <556D94C1.6060300@huawei.com>
Message-ID: <556DA9F9.5080902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/15 12:34, majun (F) wrote:
> Hi Marc: Thanks for your review.
> 
> Accroding to my initial scheme, mbigen and pci devices uses the same
> parent domain--MSI domain.
> 
> But accroding to your opinion, it seems use the ITS domain as parent
> domain of Mbigne is a better way. Am i right ?

Let's face it, your MBIGEN is not a PCI device at all. It is something
else entirely, and you're just adding complexity to a subsystem that
really doesn't need it.

So why would you hack the PCI domain implementation at all? The kernel
now has the right level of abstraction, where you can provide interrupts
to different implementations of MSIs.

Even better, you can base your MBIGEN domain on the core code that lives
in kernel/irq/msi.c, just like PCI does (drivers/pci/msi.c). You will
end up with something like:

PCI/MSI --> ITS --> GIC
MBIGEN  _/

where both domains can coexist happily, and still share a common code
base. This shouldn't require any hack either. The only possible snag is
to be able to obtain a pointer to the ITS domain (there is currently no
provision for that), but that should be easily solved.

My point here is that if you need to do touch the core code, you need to
be able to justify it. So far, I haven't seen anything in your HW that
would require the kind of redesign you've posted.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
