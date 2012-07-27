From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Fri, 27 Jul 2012 13:02:34 +0800
Subject: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing
 pen-down GPIO
In-Reply-To: <87ipdambgg.fsf@ti.com>
References: <1342048700-15040-1-git-send-email-khilman@ti.com>
 <500D494D.8020606@compulab.co.il> <500D4F2A.9090706@compulab.co.il>
 <87zk6mpbfa.fsf@ti.com> <5011B465.70605@windriver.com>
 <87ipdambgg.fsf@ti.com>
Message-ID: <501220EA.3020009@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?27? 05:58, Kevin Hilman ??:
> "zumeng.chen"<zchen@windriver.com>  writes:
>
>> On 2012?07?27? 03:30, Kevin Hilman wrote:
>>> + Zumeng Chen
>>>
>>> Igor Grinberg<grinberg@compulab.co.il>   writes:
>>>
>>>> Hi Kevin,
>>>>
>>>> I've just noticed that the patch has been modified by Arnd in a way
>>>> that of course will trigger GPIO use without being requested.
>>>> I'm sorry, I was not available by that time Arnd changed the patch.
>>> Your right, your original patch isn't the problem.  I found the root
>>> cause.
>>>
>>> The real problem is actually introduced by the merge of your patch from
>>> the arm-soc/cleanup branch, and this one from Zumeng Chen: commit
>>> 16aced80f6 (ARM: OMAP3530evm: set pendown_state and debounce time for
>>> ads7846) from the arm-soc/boards branch.
>>>
>>> However, looking closer at the one from Zumeng, that one is clearly not
>>> right.  It unconditionally adds a *board-specific* ->get_pendown_state
>>> function to the pdata that is common to *all* boards.  That's just wrong
>>> and has the side-effect of making ->get_pendown_state() wrong on every
>>> board except the OMAP3EVM.  Oops.
>>>
>>> So, IMO, in addition to $SUBJECT patch, in order to get the touchscreen
>>> GPIO working on non OMAP3EVM boards, we also need something like this as
>>> well.
>> Definitely, thanks Kevin.
>>> Igor, Zumeng, could you try this out on your boards anc confirm if it's
>>> working?  I currently don't have a board setup with a touchscreen in my
>>> board farm.
>> Acked
> Did you test this on your board?  If so, could you respond with a
> Tested-by tag?  Thanks.
Hi Kevin,

Your patch self has no problem, feel free to add
"Tested-by: Zumeng Chen <zumeng.chen@windriver.com>


But obviously, the current ads7846 doesn't work, I have found
one reason, another reason is about spi-dma update, I'm trying
to fix it.

Regards,
Zumeng
>
> Kevin
