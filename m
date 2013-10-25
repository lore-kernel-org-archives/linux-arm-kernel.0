From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Oct 2013 14:33:26 +0300
Subject: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
In-Reply-To: <526A542D.8060801@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
 <526A526D.3010108@ti.com> <526A542D.8060801@ti.com>
Message-ID: <526A5706.5010803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/13 14:21, Nishanth Menon wrote:

>> The problem here is that the gpios don't really belong to anyone in the
>> kernel, as we don't have a driver for the switch.
>>
>> Or did you mean that we'd still have the code in dss-common.c, but just
>> get the gpio numbers from the .dts instead? That makes sense, although
>> I'd want to get rid of that code altogether.
>>
>> Should we have support in the gpio-controller to define default values
>> for gpios? I don't think we can rely on the boot loader to set things
>> correctly.
>>
> 
> I am unfortunately, not in a position to know how you plan to
> architect dss_common or the various panels associated with it. if you

The dss-common.c is just a hack, needed during the transition to DT.
It's supposed to go away as soon as we have proper DT support for DSS.

In this case it has just been a convenient place to set the gpios at
boot time. The gpios are not touched after that.

> model these as panels and a generic driver which controls the panel
> could request and control pins and gpios as needed I suppose.
> 
> gpio controller cannot drive default pull direction, that is the job
> of the driver using the gpio.

I agree. But what to do when there is no driver that uses the gpio, but
the gpio still affects the drivers? That's more or less the situation here.

The SDP board has an LCD and a PicoDLP projector, and the board
designers have shared resources between those, meaning only one can be
used at a time.

Having the GPIO pulled down means that LCD2 won't have backlight
(although the gpio doesn't actually enable the backlight, it just
handles the routing if I'm not mistaken) , but PicoDLP will have
something (parallel video datalines, if I recall right).

I can't add that GPIO to either the LCD driver or the PicoDLP driver, as
it's not a property of either of them.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/319ae9e2/attachment.sig>
