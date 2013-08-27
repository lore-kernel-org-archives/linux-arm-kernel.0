From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 Aug 2013 22:04:15 +0200
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827191337.GA2339@localhost>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost>
Message-ID: <521D063F.4040404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/13 21:13, Ezequiel Garcia wrote:
> On Tue, Aug 27, 2013 at 11:25:35AM -0400, Jason Cooper wrote:
>> On Tue, Aug 27, 2013 at 12:11:37PM -0300, Ezequiel Garcia wrote:
>>> On Tue, Aug 27, 2013 at 04:39:39PM +0200, Thomas Petazzoni wrote:
>>>> On Tue, 27 Aug 2013 11:34:25 -0300, Ezequiel Garcia wrote:
>>>>> With the introduction of the orion irqchip driver, now the BRIDGE_CAUSE
>>>>> bit is cleared by it. There's no longer a need to do it in the watchdog
>>>>> driver, so we can simply remove it.
>>>>>
>>>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>>>
>>>> Is this going to work with the platforms that use the orion_wdt driver
>>>> but are not using the orion irqchip driver? Take for example
>>>> mach-orion5x, it still uses the plat-orion/irq.c code and not the
>>>> irqchip orion driver, as far as I can see.
>>>>
>>>> The orion irqchip driver is DT only, so all of the Orion platforms that
>>>> have not been converted to DT are still using the old irq code.
>>>>
>>>> Any thoughts on the consequences of this in relation with your patch?
>>>>
>>>
>>> Argh, you're right, We've completely missed this.
>>>
>>> And it's a *very* important point because we need this patch
>>> to ultimately get rid of the mach/brideg-regs.h.
>>>
>>> Quite frankly I'm really out of ideas right now and unless someone
>>> comes up with a smart solution, I see no other way but to:
>>>
>>> 1. Implement an armada-wdt.c driver and stop trying to fix the world.
>>> 2. Add some ugly ifdefs to avoid the mach-specific header.
>>> 3. ?
>>
>> 3. add a handler to plat-orion/irq.c ?
>>
>
> Hm.. first of all: *why* do we need to clear this at all?
>
> Does anybody has a clear explanation for this?

In the current use of watchdog even for non-DT boards, you do not
have to clear the interrupt cause. It will ultimately lead to a
reset in any way. Maybe it is not a big deal to remove it now
even without non-DT replacement.

Sebastian
