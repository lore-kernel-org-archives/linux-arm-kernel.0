From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 02 May 2013 17:33:29 -0400
Subject: [Xen-devel] [PATCH 1/3] arm_arch_timer: introduce
 arch_timer_stolen_ticks
In-Reply-To: <1367482772.21869.26.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <51817CBE.4050003@codeaurora.org>
 <1367482772.21869.26.camel@zakaz.uk.xensource.com>
Message-ID: <5182DBA9.9080609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On 05/02/2013 04:19 AM, Ian Campbell wrote:
> On Wed, 2013-05-01 at 21:36 +0100, Christopher Covington wrote:
>> Hi Stefano,
>>
>> On 05/01/2013 03:27 PM, Stefano Stabellini wrote:
>>> Introduce a function, called arch_timer_stolen_ticks, called from the
>>> arch_timer interrupt handler to account for stolen ticks.
>>
>> [...]
>>
>>> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
>>> index 7ade91d..30db413 100644
>>> --- a/arch/arm/include/asm/arch_timer.h
>>> +++ b/arch/arm/include/asm/arch_timer.h
>>> @@ -13,6 +13,11 @@
>>>  int arch_timer_of_register(void);
>>>  int arch_timer_sched_clock_init(void);
>>>  
>>> +/* per-platform function to calculate stolen ticks (clock cycles stolen
>>> + * to the vcpu by the hypervisor).

[...]

>> Is the hypervisor adjusting the Virtual Offset Register?
> 
> The virtual offset register is useful when a VCPU is migrated to another
> system to account for the differences in physical time on the two hosts
> but isn't useful for accounting for stolen time while running on a
> single host.
> 
> e.g. if a VCPU sets a timer for NOW+5, but 3 are stolen in the middle it
> would not make sense (from the guests PoV) for NOW'==NOW+2 at the point
> where the timer goes off. Nor does it make sense to require that the
> guest actually be running for 5 before injecting the timer because that
> would mean real time elapsed time for the timer would be 5+3 in the case
> where 3 are stolen.

This is a bit of an aside, but I think that hiding time spent at higher
privilege levels can be a quite sensible approach to timekeeping in a
virtualized environment, but I understand that it's not the approach taken
with Xen, and as you pointed out above, adjusting the Virtual Offset Register
by itself isn't enough to implement that approach.

> So the virtual timer should appear to have been running even while time
> is being stolen and therefore stolen time needs to be accounted via some
> other means.

Something that's not currently obvious to me is that given that the stolen
cycle accounting should be done, what makes the architected timer interrupt
handler the ideal place to do it?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
