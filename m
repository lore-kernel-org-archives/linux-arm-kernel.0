From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 10 May 2016 13:06:56 +0300
Subject: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
In-Reply-To: <20160510090547.GQ30822@pengutronix.de>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5731A02A.2070309@ti.com> <20160510090547.GQ30822@pengutronix.de>
Message-ID: <5731B2C0.3040404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/05/16 12:05, Uwe Kleine-K?nig wrote:
> Hello Tomi,
> 
> On Tue, May 10, 2016 at 11:47:38AM +0300, Tomi Valkeinen wrote:
>> On 04/05/16 12:43, Uwe Kleine-K?nig wrote:
>>> this is v2 of the series which addresses the review comments I got vor
>>> (implicit) v1.
>>>
>>> For patch 2 the question is still open if this is the right fix, but
>>> without this the display doesn't stay on. Patches 1 and 3 should be
>>> applicable independant of patch 2.
>>
>> I picked patches 1 and 3, they look fine.
> 
> Thanks.
> 
>> I still think patch 2 is just broken, it doesn't make sense to me.
> 
> What do you think should happen during startup? Something should call
> the set_power callback to enable the device? Or should that only happen
> when something writes to /dev/fb0?

I think the panel should be enabled at startup, as with fbdev there's no
specific enable call. So I don't have a problem with enabling the panel
at startup, but just that the regulator enables/disables don't seem to
match.

>> If the regulator is enabled in probe, then it's always on, and
>> imxfb_lcd_set_power() should be removed as it never has any effect. But
>> that doesn't sound correct, as presumably the imxfb_lcd_set_power() has
>> worked at some point.
> 
> I think it worked back when unused regulators were not disabled during
> boot.

Is imxfb_lcd_set_power() ever called, or just not at startup? If it is
called properly later, then perhaps you just need to kick it at startup
time to enable it. Maybe imxfb_lcd_set_power(lcd, FB_BLANK_UNBLANK);

Did you try unloading the module (both when the LCD is enabled and when
it's disabled), and seeing that the regulator gets disabled when you
unload it?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/8144c3b2/attachment.sig>
