From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2012 16:30:23 +0100
Subject: [PATCH v2 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <50266C23.7040802@ti.com>
References: <1344681091-12652-1-git-send-email-marc.zyngier@arm.com>
 <1344681091-12652-2-git-send-email-marc.zyngier@arm.com>
 <50266C23.7040802@ti.com>
Message-ID: <50291D8F.8000103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/12 15:28, Cyril Chemparathy wrote:
> On 8/11/2012 6:31 AM, Marc Zyngier wrote:
>> At the moment, the arch_timer driver only uses the physical timer,
>> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
>> which is likely in a virtualized environment. Instead, the virtual
>> timer is always available.
>>
>> This patch enables the use of both the virtual timer, unless no
>> interrupt is provided in the DT for it, in which case is falls
>> back to the physical timer.
>>
> 
> I'm curious about the cost of the added pointer chasing introduced by 
> this patch.
> 
> The original code gets nicely inlined by the compiler, and this hides 
> all the switch-case register index stuff.  For instance:
> 
>   10797 c001288c <arch_timer_set_next_event>:
>   10798 c001288c:       ee1e3f32        mrc     15, 0, r3, cr14, cr2, {1}
>   10799 c0012890:       e3c33002        bic     r3, r3, #2
>   10800 c0012894:       ee0e0f12        mcr     15, 0, r0, cr14, cr2, {0}
>   10801 c0012898:       f57ff06f        isb     sy
>   10802 c001289c:       e3833001        orr     r3, r3, #1
>   10803 c00128a0:       ee0e3f32        mcr     15, 0, r3, cr14, cr2, {1}
>   10804 c00128a4:       f57ff06f        isb     sy
>   10805 c00128a8:       e3a00000        mov     r0, #0
>   10806 c00128ac:       e12fff1e        bx      lr
> 
> With the added pointer chasing, we unfortunately lose out on all the 
> work that the compiler used to do for us.  We now end up having to snake 
> our way through the following:

[...]

Yup, that doesn't look too good.

> I think we'd be better off separating between these (virt, phys, ...) 
> implementations at a higher level of operations (set_mode, 
> set_next_event, ...) rather than separating at a register operations 
> level as you have in this patch.

This approach leads to a lot of code duplication, unless we do some ugly
preprocessor hackery (see patch attached). I then get much better code
(smaller, faster), but I'm not sure we want to live with this...

	M.
-- 
Jazz is not dead. It just smells funny...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-arch_timers-enable-the-use-of-the-virtual-timer.patch
Type: text/x-diff
Size: 14514 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120813/b73ddd01/attachment-0001.bin>
