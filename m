From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 3 Jan 2012 10:24:40 +0000
Subject: [PATCH v8 19/20] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
In-Reply-To: <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-5-git-send-email-govindraj.raja@ti.com>
 <B5906170F1614E41A8A28DE3B8D1214304B3E2@DBDE01.ent.ti.com>
 <CAAL8m4yXD-gpeXNVsCOYeDkYDWmVX8FUcpXKjx6k=AXSF4V9iA@mail.gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D1214304BAD3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

On Mon, Jan 02, 2012 at 16:00:37, Govindraj wrote:
> 
> currently runtime pm is available from omap-serial device and not from tty_dev.
> Setting tty_dev wakeup is to use irq_wakeup from suspend available
> from serail_core layer which I think we are not using for omap-uart
> and we use pad wakeup from suspend path.
> 
> Also omap-uart.x/power/wakeup is used to gate uart clocks using runtime
> PM api's in omap-serial driver.
> 

Thanks for clarifying. On AM335x, one of the UARTs is in a wakeup domain
and swakeup from this is used to come out of suspend.

I have basic suspend-resume working on it. Strangely this works irrespective
of the value of tty_dev wakeup entry. Do you know if this is expected on OMAP?

The other issue concerning runtime PM is that as soon as I set a non-zero to
the autosuspend_delay_ms I get some garbage characters and eventually the
console stops responding.

[root at arago /]# cat .../omap_uart.0/power/autosuspend_delay_ms
-1
[root at arago /]# echo 3000 > ?KW???+???+wU.???,z,??.??osuspend_delay??????...
[root at arago /]#	<- No response after some time

The comment in the code mentions delay is receiving characters if runtime PM
is enabled. Any idea what's going wrong@my end?

Regards,
Vaibhav B.
