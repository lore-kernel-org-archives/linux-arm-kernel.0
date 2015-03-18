From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 18 Mar 2015 12:16:22 +0100
Subject: [PATCH 1/5] USB: ehci-atmel: rework clk handling
In-Reply-To: <Pine.LNX.4.44L0.1503171459310.1061-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1503171459310.1061-100000@iolanthe.rowland.org>
Message-ID: <55095E86.1060201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/03/2015 20:01, Alan Stern a ?crit :
> On Tue, 17 Mar 2015, Boris Brezillon wrote:
> 
>> The EHCI IP only needs the UTMI/UPLL (uclk) and the peripheral (iclk)
>> clocks to work properly. Remove the useless system clock (fclk).
>>
>> Avoid calling set_rate on the fixed rate UTMI/IPLL clock and remove
>> useless IS_ENABLED(CONFIG_COMMON_CLK) tests (all at91 platforms have been
>> moved to the CCF).
>>
>> This patch also fixes a bug introduced by 3440ef1 (ARM: at91/dt: fix USB
>> high-speed clock to select UTMI), which was leaving the usb clock
>> uninitialized and preventing the OHCI driver from setting the usb clock
>> rate to 48MHz.
>> This bug was caused by several things:
>> 1/ usb clock drivers set the CLK_SET_RATE_GATE flag, which means the rate
>>    cannot be changed once the clock is prepared
>> 2/ The EHCI driver was retrieving and preparing/enabling the uhpck
>>    clock which was in turn preparing its parent clock (the usb clock),
>>    thus preventing any rate change because of 1/
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
and:
Fixes: 3440ef169100 ("ARM: at91/dt: fix USB high-speed clock to select UTMI")

Alan, Greg,

Can you please take this patch (only this patch 1/5 of the series) as a fix 
for the 4.0-rc? It would solve the issue that we see on at91sam9x5/at91sam9n12.
I'll take care of the rest of the series for 4.1.

If you want me to take it of to re-send the patch, tell me.

Thanks, bye,
-- 
Nicolas Ferre
