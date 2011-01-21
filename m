From: dmitriyz@google.com (Dima Zavin)
Date: Thu, 20 Jan 2011 18:06:12 -0800
Subject: Locking in the clk API
In-Reply-To: <alpine.LFD.2.00.1101201623480.8580@xanadu.home>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
Message-ID: <AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a better one.

Many devices use serial display panels sitting on either MDDI or MIPI
links. The interface clocks need to be on, but they stay in low-power
mode while the display is on. The display controller however does not
need to be on since the serial panels typically have a local
framebuffer that does the idle panel refresh on it's own. When a new
frame comes in to be displayed, you need to clock on the display
controller, DMA the data to the panel, and when it's done turn the
controller off. The clk_enable may or may not happen at irq context,
depending on whether or not you are starting the DMA from a
vsync/tear-effect irq or simply from the screen_update() function. The
clk_disable will most certainly happen from the DMA_DONE irq.

--Dima

On Thu, Jan 20, 2011 at 1:30 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 20 Jan 2011, Russell King - ARM Linux wrote:
>
>> On Thu, Jan 20, 2011 at 04:29:15PM +0000, Ben Dooks wrote:
>> > I really don't like the fact that people are doing these things in
>> > atomic contexts, and I think we should apply some pressure to move
>> > the atomic caller cases to use systems where they can sleep such as
>> > using threaded-irq handlers (they work very nicely)
>>
>> How do you ensure that printk is always called from a non-atomic
>> context?
>
> Is this a good example? ?I don't think that power sensitive systems such
> as a cellphone should keep printk() enabled in the final product. ?The
> output from printk() over a serial port is a debugging convenience, and
> trying to aggressively turn on/off the serial clock around each call to
> printk() is a bit silly. ?Better simply turn the serial clock on
> whenever its console facility is opened, and turn it off when the
> console is closed, which should be good enough in that context.
>
>
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
