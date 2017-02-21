From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Feb 2017 09:43:51 +0000
Subject: [PATCH v4 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <58ABE735.2010708@gmail.com>
References: <1487530263-42643-1-git-send-email-anurup.m@huawei.com>
 <20170220110942.GF9003@leverpostej> <58ABE735.2010708@gmail.com>
Message-ID: <83d988a5-b6f4-c466-0e97-2b736854e294@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/17 07:07, Anurup M wrote:
> Adding Marc.
> 
> On Monday 20 February 2017 04:39 PM, Mark Rutland wrote:
>> On Sun, Feb 19, 2017 at 01:51:03PM -0500, Anurup M wrote:
>>> The L3 cache PMU use N-N SPI interrupt which has no support
>>> in kernel mainline.
>> Could you elaborate on what you mean by this?
>>
>> I don't understand what is meant here. How exactly are the interrupts
>> wired up in HW, and what exactly is not supported by Linux?
> 
> In HW the L3C overflow IRQ is wired as SPI which use N-N model.
> But according to ARM GIC V2 specification, the peripheral(hardware) 
> interrupts should use 1-N model.
> N-N model is used by SGIs. In GIC V3 spec I could not find any 
> description of N-N model.
> So I think the N-N model for SPI will not be supported.
> 
> Hi Marc,
>      Does ARM GIC support N-N module for SPI? Please share your comments.

There is no support for this kind of broadcast IRQs in any published
version of the GIC architecture. The semantics of such interrupts are
just crazy, and I'm really glad we don't support them.

What we could support is 1-of-N, but that's
(1) inefficient,
(2) impossible to virtualize correctly,
(3) only possible with GICv2.

So what you're getting is interrupts targeted at a single CPU, and
that's it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
