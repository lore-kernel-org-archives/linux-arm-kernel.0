From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Mon, 28 Sep 2015 12:15:22 +0200
Subject: [PATCH v6 5/5] leds: netxbig: set led_classdev max_brightness
In-Reply-To: <20150928091956.GY7306@kw.sim.vm.gnt>
References: <1443301358-2131-1-git-send-email-simon.guinot@sequanux.org>
 <1443301358-2131-6-git-send-email-simon.guinot@sequanux.org>
 <5608F41B.4020307@samsung.com> <20150928091956.GY7306@kw.sim.vm.gnt>
Message-ID: <5609133A.3050802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2015 11:19 AM, Simon Guinot wrote:
> On Mon, Sep 28, 2015 at 10:02:35AM +0200, Jacek Anaszewski wrote:
>> Hi Simon,
>
> Hi Jacek,
>
>>
>> Does your device support reading the brightness currently set?
>
> No it don't.
>
>> If so, it would be good to implement brightness_get op, because
>> AFAIR you mentioned that the firmware you are working with sets
>> always maximum brightness value. Having the op implemented would
>> allow to find this out.
>
> I don't understand how this can help. I mean, the only issue is that at
> startup the initial LED state is unknown. And the software brightness
> value could be false. But once the LED is configured, the brightness
> values for software and hardware are synchronized. The brightness value
> is stored/cached in led_classdev and it can be retrieved by the user via
> sysfs...
>
> For my own knowledge, is there some interest in having brightness_get(),
> aside of guessing the LED initial state ?

Some LED controllers can adjust brightness in case battery voltage level
falls below some threshold.

> What does the embedded firmware is writing 255 or 0 into the brightness
> sysfs attribute. The max_brightness value is ignored. After this patch,
> writing 255 and 0 still allows to configure the LED in the same way:
> maximum brightness or off. Thus, I believe there is no compatibility
> issue.

LED core always assures that brightness value passed to brightness_set
op does not exceed max_brightness value. So, now after executing
"echo 255 > brightness", LED core will adjust it to max_brightness
(e.g. 7) before passing to brightness_set.

In the message [1], you mentioned that "LEDs are only enabled at their
maximum level", so IIUC following is possible:

#echo 3 > "brightness"

firmware sets brightness to max_brightness from DT (e.g. 7), but

#cat brightness
#3

Is it true?

> But of course, I will update the firmware as well :)

[1] http://www.spinics.net/lists/devicetree/msg94358.html
-- 
Best Regards,
Jacek Anaszewski
