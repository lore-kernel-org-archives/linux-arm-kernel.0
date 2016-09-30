From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 30 Sep 2016 17:06:12 +0200
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
Message-ID: <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-30 14:59 GMT+02:00 Peter Ujfalusi <peter.ujfalusi@ti.com>:
> On 09/29/16 19:31, Bartosz Golaszewski wrote:
>> Default memory settings of da850 do not meet the throughput/latency
>> requirements of tilcdc. This results in the image displayed being
>> incorrect and the following warning being displayed by the LCDC
>> drm driver:
>>
>>   tilcdc da8xx_lcdc.0: tilcdc_crtc_irq(0x00000020): FIFO underfow
>>
>> Reconfigure the LCDC priority to the highest. This is a workaround
>> for the da850-lcdk board which has the LCD controller enabled in
>> the device tree, but a long-term, system-wide fix is needed for
>> all davinci boards.
>>
>> This patch has been modified for mainline linux. It comes from a
>> downstream TI release for da850[1].
>>
>> Original author: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
>>

[snip]

>
> Is this safe to do for all da850 boards (to change PR_OLD_COUNT from 0xff to
> 0x20)? Most probably it is, but this setting has nothing to do with LCDC.
>
> The whole priority configuration has nothing to do with the LCDC, it is a
> system level priority.
>
> Now you have lowered the eDMA3_0-TPTC0/1 priority. Audio is serviced by
> eDMA3_0-TPTC1. So are we going to see issues in audio if LCDC is taking the
> highest priority?
>

Just ran a quick test with speaker-test -c2 -twav. Besides the fact
that the left and right channels are inverted (I'm looking into that),
I didn't notice any problems. Even at 1024x768 resolution, playing
audio at the same time seems to work fine.

Best regards,
Bartosz Golaszewski
