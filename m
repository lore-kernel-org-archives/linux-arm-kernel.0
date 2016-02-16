From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 16 Feb 2016 17:06:00 +0000
Subject: [PATCH 5/5] arm64: marvell: add Device Tree files for Armada 7K/8K
In-Reply-To: <20160216173155.4f832646@free-electrons.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <56C19B18.8090005@arm.com> <20160216173155.4f832646@free-electrons.com>
Message-ID: <56C356F8.8080105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 16:31, Thomas Petazzoni wrote:
> Marc,
> 
> Thanks for the review!
> 
> On Mon, 15 Feb 2016 09:32:08 +0000, Marc Zyngier wrote:
> 
>>> +				interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>> +				reg = <0x210000 0x1000>,
>>> +				      <0x220000 0x1000>,
>>
>> Assuming we do have a GIC400 here (which is extremely likely), the GICC
>> block should be at least 8kB to reflect the fact that this is a GICv2.
> 
> According to the datasheet I have, the GICD, GICC, GICV and GICH blocks
> are all 0x10000 in size. Not sure the entire 0x10000 is actually used,
> but th memory map is pretty clear.

No, that's just a way to make sure that you can give the GICV block to a
guest while using 64k pages.

Talking about GICV: are you sure it is 0x10000 and not 0x20000? SBSA
recommends to have the first 4kB GICV page aliased over 64kB, and the
second 4kB page over the second 64kB block. That is to ensure that a
hypervisor can trap access to GICV_DIR register independently of the
rest of the virtual CPU interface.

But hey, almost everybody got it wrong so far, so I wouldn't be
surprised if that was broken on this platform as well...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
