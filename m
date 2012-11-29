From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Nov 2012 21:10:26 +0100
Subject: [PATCH 4/4] rtc: pxa: request rtc irqs when probe/remove the
 device
In-Reply-To: <1354155670-6267-4-git-send-email-chao.xie@marvell.com> (Chao
 Xie's message of "Wed, 28 Nov 2012 21:21:10 -0500")
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
 <1354155670-6267-4-git-send-email-chao.xie@marvell.com>
Message-ID: <87mwy0187h.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chao Xie <chao.xie@marvell.com> writes:

> The original pxa_rtc_open/pxa_rtc_release will be called
> when the /dev/rtc0 is opened or closed.
> In fact, these two functions will register/unregister the irqs.
> User application will use /dev/rtc0 to read the rtc time or set
> the alarm. The rtc should still run indepent of open/close the
> rtc device.
> So only register the irqs when probe the device,
> and disable clock and unregister the irqs when remove the device.
No, as Russell I think that's not correct.

This is not how RTC API should be used. And on top of RTC API considerations,
consider this : today, rtc-pxa and rtc-sa1100 _can_ coexist on a PXA platform,
and be used alternatively (I know, it's a bit borderline because of IO space,
but anyway it does work). How will that be possible with your patch ?

Cheers.

--
Robert
