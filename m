From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 04 Feb 2014 00:36:54 +0100
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <20140203231603.GA11613@1wt.eu>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52EA2875.5020807@free-electrons.com> <52EA2A04.2070109@gmail.com>
 <20140203231603.GA11613@1wt.eu>
Message-ID: <52F02816.1050708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 12:16 AM, Willy Tarreau wrote:
> On Thu, Jan 30, 2014 at 11:31:32AM +0100, Sebastian Hesselbarth wrote:
>> On 01/30/14 11:24, Gregory CLEMENT wrote:
>>> On 25/01/2014 19:19, Sebastian Hesselbarth wrote:
>>>> This patch set fixes clk init order that went upside-down with
>>>> v3.14. I haven't really investigated what caused this, but I assume
>>>> it is related with DT node reordering by addresses.
>>>
>>> Can you explain what kind of issue do you observe?
>>
>> Sure. When probing CLK_OF_DECLAREed clock drivers, clock-gating driver
>> gets registered before core-clocks. It therefore cannot resolve it's
>> parent clock name for tclk and all clock gates will have no parent
>> clock.
>>
>> Usually, you'll see in some drivers (e.g. v643xx_eth) div_by_zero errors
>> poping up, when they calculate a frequency division factors based on
>> clock gate frequency, which should have been tclk but is 0 now.
>
> Well, to be honnest, I have no idea whether your patch is the right way
> to fix the problem or not, but what I can say is that it fixes such oopses
> that appear in 3.14-rc1 when booting on mirabox :
>
> Division by zero in kernel.

Willy,

you have hit exactly the reason for this patch.

[...]
> By the way, seeing how often a trick related to the DT is nedeed to solve an
> oops or a panic, I'm really scared that this whole DT mess is just becoming
> the exact copy of the ACPI mess (but 15 years later) and we'll experience the
> same horrible things :-( Sometimes I'm wondering whether there are not too
> many structural things put in there...

To be precise, it is not a DT-related trick at all. You would have the
same issues, if you'd register those "low-level" (i.e. early) drivers
without DT. It is more about missing init ordering, here.

There could be different ways to work this out, even elevating clock
devices to "normal" probed devices could be possible. I am sure, in the
long run, it will work out, but now this is a fix for v3.14-rc1.

@Jason, Andrew, Gregory, Thomas:
Now that v3.14 is out, anything against taking this in as fixes for rc1?

Sebastian
