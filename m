From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 19 Dec 2016 18:50:34 +0200
Subject: [PATCH] drm: tilcdc: simplify the recovery from sync lost error
 on rev1
In-Reply-To: <CAMpxmJVHXoP0BokfbPwQmC=eBaNfS5yfG77EB_MnScmSbUVAdA@mail.gmail.com>
References: <1481641656-25227-1-git-send-email-bgolaszewski@baylibre.com>
 <590211f1-8e31-cecc-8dd2-f7e2976b81d1@ti.com>
 <CAMpxmJVHXoP0BokfbPwQmC=eBaNfS5yfG77EB_MnScmSbUVAdA@mail.gmail.com>
Message-ID: <477e8801-5b14-5d76-eb07-bf3ec6c1795b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/16 16:19, Bartosz Golaszewski wrote:
>> I would add here:
>> +               if ((tilcdc_read(dev, LCDC_RASTER_CTRL_REG) &
>> +                               LCDC_RASTER_ENABLE)) {
>>
>>> +                     tilcdc_clear(dev,
>>> +                                  LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
>>> +                     tilcdc_set(dev,
>>> +                                LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
>> +               }
>>
>> Just in case the interrupt is for some reason handled right after the
>> crtc is disabled.
>>
>> With this addition I could send a pull request for this fix still today,
>> if you agree with the change.
> I'm not sure this can really happen, but it won't hurt either, so I'll
> send a v2.

Well, in theory it is quite possible. If the driver clears the raster
enable at the same time when sync lost interrupt is generated, then the
irq routine handles the irq before the interrupts are disabled. Then it
happens that rastere remains on but the driver thinks it has already
turned it off.

In practice this is of course terribly unlikely, but a race is a race
and should be avoided.

Anyway, my vacation has already been started so I won't send a pull
request now. I do not like the idea of doing something like that and
then vanishing for two weeks. I hope they still take fixes for 4.10 in
4th Jan.

Best regards,
Jyri
