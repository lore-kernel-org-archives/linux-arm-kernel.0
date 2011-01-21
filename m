From: dmitriyz@google.com (Dima Zavin)
Date: Fri, 21 Jan 2011 13:03:22 -0800
Subject: Locking in the clk API
In-Reply-To: <4D3907BD.4040900@codeaurora.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
	<4D3907BD.4040900@codeaurora.org>
Message-ID: <AANLkTik53zyXytvuAd5zK0_zExfQT3FmOgTr8BexmGeT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 8:12 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 01/20/2011 06:06 PM, Dima Zavin wrote:
>> Here's a better one.
>>
>> Many devices use serial display panels sitting on either MDDI or MIPI
>> links. The interface clocks need to be on, but they stay in low-power
>> mode while the display is on. The display controller however does not
>> need to be on since the serial panels typically have a local
>> framebuffer that does the idle panel refresh on it's own. When a new
>> frame comes in to be displayed, you need to clock on the display
>> controller, DMA the data to the panel, and when it's done turn the
>> controller off. The clk_enable may or may not happen at irq context,
>> depending on whether or not you are starting the DMA from a
>> vsync/tear-effect irq or simply from the screen_update() function. The
>> clk_disable will most certainly happen from the DMA_DONE irq.
>
> Why do we need to turn on the clock in the IRQ? Why not defer it to a
> workqueue (or whatever is the method of the day to defer work from an IRQ)?
> The advantage of doing the clk_enable in the IRQ should be negligible
> compared to the time it takes to do the DMA.

Because in an interactive system running at 60fps, you only have 16ms
budget per frame. During the blanking interval when you receive the
IRQ you need to immediately start the DMA. If you defer to a workqueue
and schedule you are practically guaranteeing to never run at 60fps
(more like 30 if you are consistently late, which you would with that
kind of timing and even a mildly busy system).

--Dima
