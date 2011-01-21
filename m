From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 20 Jan 2011 20:12:45 -0800
Subject: Locking in the clk API
In-Reply-To: <AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111031552.GJ3760@linux-sh.org>
	<4D3862DB.5000708@fluff.org>	<20110120185617.GI6335@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
Message-ID: <4D3907BD.4040900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 06:06 PM, Dima Zavin wrote:
> On Thu, Jan 20, 2011 at 1:30 PM, Nicolas Pitre<nicolas.pitre@linaro.org>  wrote:
>> On Thu, 20 Jan 2011, Russell King - ARM Linux wrote:
>>
>>> On Thu, Jan 20, 2011 at 04:29:15PM +0000, Ben Dooks wrote:
>>>> I really don't like the fact that people are doing these things in
>>>> atomic contexts, and I think we should apply some pressure to move
>>>> the atomic caller cases to use systems where they can sleep such as
>>>> using threaded-irq handlers (they work very nicely)
>>>
>>> How do you ensure that printk is always called from a non-atomic
>>> context?
>>
>> Is this a good example?  I don't think that power sensitive systems such
>> as a cellphone should keep printk() enabled in the final product.  The
>> output from printk() over a serial port is a debugging convenience, and
>> trying to aggressively turn on/off the serial clock around each call to
>> printk() is a bit silly.  Better simply turn the serial clock on
>> whenever its console facility is opened, and turn it off when the
>> console is closed, which should be good enough in that context.

[fixing top post]

 > Here's a better one.
 >
 > Many devices use serial display panels sitting on either MDDI or MIPI
 > links. The interface clocks need to be on, but they stay in low-power
 > mode while the display is on. The display controller however does not
 > need to be on since the serial panels typically have a local
 > framebuffer that does the idle panel refresh on it's own. When a new
 > frame comes in to be displayed, you need to clock on the display
 > controller, DMA the data to the panel, and when it's done turn the
 > controller off. The clk_enable may or may not happen at irq context,
 > depending on whether or not you are starting the DMA from a
 > vsync/tear-effect irq or simply from the screen_update() function. The
 > clk_disable will most certainly happen from the DMA_DONE irq.

Why do we need to turn on the clock in the IRQ? Why not defer it to a 
workqueue (or whatever is the method of the day to defer work from an 
IRQ)? The advantage of doing the clk_enable in the IRQ should be 
negligible compared to the time it takes to do the DMA.

In my opinion, the only major reason for needing atomic clk APIs was due 
to device_ops->suspend being atomic. Since that's not the case anymore, 
I really don't see a justification for atomic clocks. Sure, I might have 
missed some exceptions, but in that case we should make the atomic APIs 
an exception (add clk_enable_atomic) and not the norm.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
