From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 13 Nov 2015 22:20:26 +0200
Subject: [PATCH v2 0/8] arm: dts: lpc32xx: updates to LPC32xx SoC and
 boards
In-Reply-To: <563F6CC7.3050704@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
 <3973745.SoYxz6UFdV@wuerfel> <563F6CC7.3050704@mleia.com>
Message-ID: <5646460A.4080207@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 08.11.2015 17:39, Vladimir Zapolskiy wrote:
> Hi Arnd,
> 
> On 21.10.2015 17:45, Arnd Bergmann wrote:
>> On Sunday 18 October 2015 00:35:49 Vladimir Zapolskiy wrote:
>>> The change improves description of NXP LPC32xx hardware, among
>>> important changes it adds standard timers and external memory
>>> controller nodes, splits PWM device node into two,
>>>
>>> Changes from v1 to v2:
>>> - removed v1 2/5 "arm: dts: lpc32xx: fix improper usage of ranges property"
>>> - v1 4/5 "arm: dts: lpc32xx: remove unneeded cell settings from cpus"
>>>   is replaced by v2 3/8 "arm: dts: lpc32xx: add reg property to cpu device node"
>>> - new change, sets physical memory offset for EA3250 and PHY3250 v5/8
>>> - new change, added EMC device node v2 6/8
>>> - new change, added standard timer nodes v2 7/8
>>> - new change, grouped USB subdevices together v2 8/8
>>
>> Looks ok to me. Who should pick them up? I haven't seen pull requests from
>> Roland in a while. If he's still interested in the port, I think it would be
>> best if he could create a branch here.
>>
>> If not, we can pick them up directly this time into arm-soc, but then we
>> should find a new maintainer.
>>
>> 	Arnd 
> 
> please pick this series up for v4.3, if it is still possible.
> 
> Thank you.
> 

in connection to previous discussion started here [1] I want to ask your
opinion, does it make sense to support non-DT LPC32xx platforms (by the
way there is no such platforms in vanilla)?

In particular I'd like to remove legacy platform data support and
clean-up mach-lpc32xx, e.g. remove duplicated timer driver etc.

At the moment I've completed development and tested:
* common clock framework driver (no review comments from maintainers so
far),
* irqchip driver (SPARSE_IRQ is supported),
* as a dependency to IRQ changes I developed a wakeup controller driver,
* as a dependency to IRQ changes GPIO driver is rewritten -- at the
moment it strictly depends on hwirq plus its current version breaks
board boot in v4.4, see [2].

In general the platform is broken since commit 76ba59f8366 ("genirq: Add
irq_domain-aware core IRQ handler"), dated Aug 26 2014 (!), because the
platform is based on legacy irq domain and hwirq 0 is actively exploited
-- this is a cascaded irq to one of the sub-irq controllers.

All done work allows to remove thousands of LoCs and make LPC32xx boot
and work again at the price of discontinued legacy DTB to new kernel
compatibility (for example due to missed clocks properties etc.) and
removed platform_data hooks.

I can continue to improve LPC32xx platform, but I believe I need some
kind of approval from ARM maintainers to convince clk/irqchip/gpio
maintainers to accept my work. What would be your opinion on this subject?

[1] http://www.spinics.net/lists/arm-kernel/msg452447.html
[2] https://www.mail-archive.com/linux-gpio at vger.kernel.org/msg11028.html

--
With best wishes,
Vladimir
