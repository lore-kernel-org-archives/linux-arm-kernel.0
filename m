From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 10:08:02 +0000
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <20160208105322.78b20cba@free-electrons.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <56B86391.1030609@arm.com> <20160208105322.78b20cba@free-electrons.com>
Message-ID: <56B86902.3090700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 08/02/16 09:53, Thomas Petazzoni wrote:
> Hello Marc,
> 
> On Mon, 8 Feb 2016 09:44:49 +0000, Marc Zyngier wrote:
> 
>>> +static struct msi_domain_info alpine_msix_domain_info = {
>>> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>> +		  MSI_FLAG_PCI_MSIX,
>>
>> You can probably add MSI_FLAG_PCI_MSI, it should work as well (MULTI_MSI
>> obviously won't).
> 
> Why wouldn't MULTI_MSI work? The code is using
> bitmap_find_next_zero_area() in alpine_msix_allocate_sgi() precisely to
> find num_req consecutive bits set to 0, in order to allocate multiple
> MSIs at once. Am I missing something?

The clue is in the patch:

+	msg->address_lo = priv->addr_low + (data->hwirq << 3);

Multi-MSI imposes a single doorbell address, and consecutive message
identifiers. So while the allocator deals perfectly with the consecutive
IDs part, the fact that you have to encode the message in the address
(instead of putting it in the data field) makes it completely
incompatible with Multi-MSI.

It is a bit silly that brand new HW comes out with such limitations (but
Multi-MSI is such a pain anyway...).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
