From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Mon, 28 Sep 2015 15:43:02 +0200
Subject: [PATCH v6 5/5] leds: netxbig: set led_classdev max_brightness
In-Reply-To: <20150928132533.GA7306@kw.sim.vm.gnt>
References: <1443301358-2131-1-git-send-email-simon.guinot@sequanux.org>
 <1443301358-2131-6-git-send-email-simon.guinot@sequanux.org>
 <5608F41B.4020307@samsung.com> <20150928091956.GY7306@kw.sim.vm.gnt>
 <5609133A.3050802@samsung.com> <20150928115033.GZ7306@kw.sim.vm.gnt>
 <56093188.4050405@samsung.com> <20150928132533.GA7306@kw.sim.vm.gnt>
Message-ID: <560943E6.1050606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2015 03:25 PM, Simon Guinot wrote:
> On Mon, Sep 28, 2015 at 02:24:40PM +0200, Jacek Anaszewski wrote:
>> On 09/28/2015 01:50 PM, Simon Guinot wrote:
>>> On Mon, Sep 28, 2015 at 12:15:22PM +0200, Jacek Anaszewski wrote:
>>>> On 09/28/2015 11:19 AM, Simon Guinot wrote:
>>>>> On Mon, Sep 28, 2015 at 10:02:35AM +0200, Jacek Anaszewski wrote:
>>>>>> Hi Simon,
>>>>>
>>>>> Hi Jacek,
>>>>>
>>>>>>
>>>>>> Does your device support reading the brightness currently set?
>>>>>
>>>>> No it don't.
>>>>>
>>>>>> If so, it would be good to implement brightness_get op, because
>>>>>> AFAIR you mentioned that the firmware you are working with sets
>>>>>> always maximum brightness value. Having the op implemented would
>>>>>> allow to find this out.
>>>>>
>>>>> I don't understand how this can help. I mean, the only issue is that at
>>>>> startup the initial LED state is unknown. And the software brightness
>>>>> value could be false. But once the LED is configured, the brightness
>>>>> values for software and hardware are synchronized. The brightness value
>>>>> is stored/cached in led_classdev and it can be retrieved by the user via
>>>>> sysfs...
>>>>>
>>>>> For my own knowledge, is there some interest in having brightness_get(),
>>>>> aside of guessing the LED initial state ?
>>>>
>>>> Some LED controllers can adjust brightness in case battery voltage level
>>>> falls below some threshold.
>>>
>>> OK, thanks for the explanation.
>>>
>>>>
>>>>> What does the embedded firmware is writing 255 or 0 into the brightness
>>>>> sysfs attribute. The max_brightness value is ignored. After this patch,
>>>>> writing 255 and 0 still allows to configure the LED in the same way:
>>>>> maximum brightness or off. Thus, I believe there is no compatibility
>>>>> issue.
>>>>
>>>> LED core always assures that brightness value passed to brightness_set
>>>> op does not exceed max_brightness value. So, now after executing
>>>> "echo 255 > brightness", LED core will adjust it to max_brightness
>>>> (e.g. 7) before passing to brightness_set.
>>>>
>>>> In the message [1], you mentioned that "LEDs are only enabled at their
>>>> maximum level", so IIUC following is possible:
>>>>
>>>> #echo 3 > "brightness"
>>>>
>>>> firmware sets brightness to max_brightness from DT (e.g. 7), but
>>>>
>>>> #cat brightness
>>>> #3
>>>>
>>>> Is it true?
>>>
>>> Oh no sorry, it is a misunderstanding. By "LEDs are only enabled at
>>> their maximum level", I was meaning "LEDs are only enabled at their
>>> maximum level by the LaCie stock firmware". The firmware don't make
>>> use of the different hardware brightness levels available. But the
>>> feature works perfectly. If you write 3 into sysfs "brightness", then
>>> you get the third brightness level.
>>
>> I thought that driver talks to firmware, which controls the LEDs.
>>  From your explanation I infer that this driver replaces LaCie stock
>> firmware, am I right? There must be however some circuit that controls
>> LED brightness then.
>
> OK, I think I may have managed to confuse you completely.
>
> The LEDs are controlled by a CPLD. The leds-netxbig driver talks to the
> CPLD via the gpio-ext "kind of" bus:
>
> leds-netxbig -> gpio-ext bus -> CPLD -> LEDs
>
> "LaCie stock firmware" don't refer to the firmware embedded in the CPLD
> but to the stock LaCie Linux system running *on* the board.
>
> "LEDs are only enabled at their maximum level by the LaCie stock
> firmware" means: "In the Linux LaCie system running on the board,
> userland only configures the LED brightness to 0 or 255".
>
> It don't mean that the CPLD does some weird stuff implying that the
> feature is somewhat broken. No, the feature works. Simply userland
> (in the stock LaCie system aka firmware) don't use it.
>
> Remember that your original question was:
>
> "Doesn't specification of your device say what current value given
>   brightness level reflects?"
>
> Let me rephrase my answer without using "LaCie stock firmware":
>
> No this information is not available in the board specification. It is
> probably because this feature is not used by the LaCie Linux userland.
> The LED brightness is configured to off or full. Other levels are not
> used. That's probably why no one took care of measuring the LED current
> consumption.
>
> Let me know if it is still unclear for you.

Thanks for this explanation. Now everything is clear.

-- 
Best Regards,
Jacek Anaszewski
