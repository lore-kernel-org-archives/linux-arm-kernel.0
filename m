From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 26 Jan 2011 20:34:20 -0800
Subject: Locking in the clk API
In-Reply-To: <20110121094042.GD13235@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111091607.GI12552@n2100.arm.linux.org.uk>	<201101111744.59712.jeremy.kerr@canonical.com>	<20110111103929.GN24920@pengutronix.de>	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>	<4D386ABF.9060908@fluff.org>	<20110120190822.GK6335@n2100.arm.linux.org.uk>	<4D3932B4.8010904@codeaurora.org>
	<20110121094042.GD13235@n2100.arm.linux.org.uk>
Message-ID: <4D40F5CC.6080809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2011 01:40 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 11:16:04PM -0800, Saravana Kannan wrote:
>> This suggestion looked promising till I realized that clk_set_rate()
>> will still be atomic. clk_set_rate() will need to enable/disable the
>> PLLs depending on which PLLs the rates are derived from. So, the locking
>> in clk_prepare/unprepare() still has to be atomic since the "slow stuff"
>> is shared with clk_set_rate().
>
> Who calls clk_set_rate() from an atomic context?  Do we know whether
> anyone does?

As promised I looked into this in the upstream kernel and with the 
internal teams.

In the upstream (torvalds/master) kernel, I found at least one example 
of calling clk_set_rate() from atomic context (spinlock in this case):
cpm_uart/cpm_uart_core.c

I'm not too familiar with serial/tty, does anyone know if the 
.set_termios needs to be atmoic? If not, we could just change 
cpm_uart/cpm_uart_core.c to use mutex instead of spinlock.

In our internal tree (which we upstream), we have UART HS driver that 
needs to do the same stuff as cpm_uart_core.c. The problem is 
essentially the UART baud rate range being too high to be controllable 
by just the dividers in the UART core. So, the clock rate has to be 
changed in the .set_termios function.

Another concern (not present in MSM) for upstream kernel is that some 
arch/mach might use the clock driver to control the CPU frequency and 
might want to drop it to a low freq in the final stages of an idle 
suspend. In that case, the call would be from atomic context. Similar 
issue during normal suspend.

Except UART, looks like internal teams don't care much for atomic 
clk_set_rate(). So, if .set_termios can use mutex, MSM is good to go for 
prepare/unprepare.

Russell,

If UART does not need clk_set_rate() to be atomic, would you be 
comfortable marking clk_set_rate() as sleepable in the clk.h comments?

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
