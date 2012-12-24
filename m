From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 24 Dec 2012 16:34:28 +0100
Subject: [PATCH 1/2] ARM: pxa: palm27x: fix udc device initialization
In-Reply-To: <201212230424.16848.marex@denx.de> (Marek Vasut's message of
 "Sun, 23 Dec 2012 04:24:16 +0100")
References: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
 <1356200860-3241-2-git-send-email-mikedunn@newsguy.com>
 <201212230424.16848.marex@denx.de>
Message-ID: <87sj6vmpkr.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marex@denx.de> writes:

> Dear Mike Dunn,
>
>> This patch fixes some bad behaviour from the usb gadget during machine
>> initialization by changing the management of the D+ pull-up gpio from the
>> gpio-vbus driver to the pxa27x-udc driver.  Also, code that drives the
>> pull-up high is removed.  (The gpio-vbus driver can optionally manage the
>> D+ line pull-up, but the pxa27x-udc driver does this itself.)
>> 
>> Without this patch, the host senses the presence of the usb gadget during
>> machine initialization (when palm27x_udc_init() runs), at which point it
>> tries to enumerate the newly detected usb gadget.  But because the
>> pxa27x-udc driver has not been initialized yet, there's no gadget driver
>> to respond to the host, and enumeration fails.  Tested on my Palm Treo680.
> [...]
>
> I think it was the whole big idea to let gpio-vbus manage this kind of stuff. 
> But it's been a while, Ccing Haojian to review these.

Actually gpio-vbus was designed to :
 - detect and handle VBus
 - and handle following D+ pullup if peripheral controller *can't*

But pxa27x_udc is a peripheral controller which does handle D+ pullup, and
expects to handle it by himself (ie. is not fully compatible with a D+ pullup
handling by gpio-vbus, one not working case being Mike's one).

So Mike's patch makes sense IMHO. He could have left the VBUS handling to
gpio-vbus and D+ to pxa27x_udc, or let pxa27x_udc handle both, that's up to you.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
