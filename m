From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 6 Dec 2010 13:06:36 +0800
Subject: [PATCH 0/3] OMAP: Introduce Backlight driver for Sharp
	LS037V7DW01 LCD panel
In-Reply-To: <1291217575.10133.165.camel@tubuntu>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
	<1291217575.10133.165.camel@tubuntu>
Message-ID: <AANLkTikMzXs=Rp8Wgm5PRD-VEGn=O9ii+by_27hsP-ar@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 1, 2010 at 11:32 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2010-11-30 at 20:07 +0800, ext Bryan Wu wrote:
>> After instroducing generic DPI panel driver for OMAP DSS2 system, we need to
>> split out backlight driver from Sharp LS037V7DW01 panel driver before we move
>> to the generic DPI panel driver.
>>
>> This patchset introcuded backlight driver and cleanup the old Sharp LS037V7DW01
>> panel driver related code.
>>
>> It's built on mainline 2.6.37-rc4
>>
>> Bryan Wu (3):
>> ? Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
>> ? OMAP: move Sharp LS LCD panel device to generic DPI panel driver and new backlight driver
>> ? OMAP: DSS2: remove Sharp LS037V7DW01 panel driver
>
> I don't think this is quite the right direction.
>
> All the backlight driver does is call a function in the board file. It's
> not really a "sharp ls backlight driver", but rather generic one. I'm
> not even sure if it needs the dssdev pointer.
>

Since dssdev struct contains backlight releated fields, I passed that
into the driver. It can be replaced by a backlight related platform
data struct. Then we can remove those backlight related fields from
dssdev struct.

> This kind of backlight is, in a sense, totally separate component from
> the panel itself. All they have in common is that they are packaged in
> the same physical display module, and they usually share the same
> connector.
>
> I have seen three kinds of backlights on OMAP devices:
> - on/off GPIO (like on 3430 SDP)
It seems like that we need a gpio_bl.c driver for this kind of usage.

> - PWM based (zoom seems to have this)

I failed to find any PWM or Backlight code in ZOOM boards source file.
Is that possible to us pwm_bl.c driver which is used by pxa?

> - Panel controlled (Taal-panel. Also PWM based, but OMAP doesn't see
> that)
>
Yeah, I don't plan to reform this driver at this time.

> The first two could (should?) be totally separate backlights from the
> panel itself. For those, a generic backlight driver could perhaps work.
> The third one needs to be quite tied to the panel driver, and I'm not
> sure how easy it would be to have a separate driver for that.
>

OK, I totally understand you concern now. How about a GPIO based
backlight driver for the first 2 cases.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
