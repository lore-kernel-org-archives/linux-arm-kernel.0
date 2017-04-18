From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 18 Apr 2017 10:07:34 +0200
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
Message-ID: <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.04.2017 um 00:37 schrieb Doug Anderson:
> Hi,
>
> On Mon, Apr 17, 2017 at 4:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Hi,
>>
>>> Stefan Wahren <stefan.wahren@i2se.com> hat am 31. Oktober 2016 um 21:34 geschrieben:
>>>
>>>
>>> I inspired by this issue [1] i build up a slightly modified setup with a
>>> Raspberry Pi B (mainline kernel 4.9rc3), a powered 7 port USB hub and 5 Prolific
>>> PL2303 USB to serial convertors. I modified the usb_test for dwc2 [2], which
>>> only tries to open all ttyUSB devices one after the other.
>>>
>>> Unfortunately the complete system stuck after opening the first ttyUSB device (
>>> heartbeat LED stop blinking, no reaction to debug UART). The only way to
>>> reanimate the system is to powerdown the USB hub with the USB to serial
>>> convertors.
>>>
>>> [1] - https://github.com/raspberrypi/linux/issues/1692
>>> [2] - https://gist.github.com/lategoodbye/dd0d30af27b6f101b03d5923b279dbaa
>> since this issue still exists with 4.11 (even without or with microframe scheduler enabled), i want to ask some additional questions:
>>
>> Is this issue reproducible with other dwc2 platforms than bcm2835?
> +Edmund Szeto, who I seem to remember emailing me about similar
> questions in the past.
>
>
>> Does the soft lockup also occurs after opening the second serial convertor or later?
> I don't have serial converters easily available to me, but back in the
> day when I was stressing things out on rk3288 I never saw anything
> this bad.  ...of course, on rk3288 we've got 4 A17 cores running
> really fast, so possibly just being slower is what causes your
> problems here?

The downstream kernel of the Raspberry Pi foundation with it's
out-of-tree dwc_otg driver is able to handle 8 serial converter on a RPI
B. I would be happy to get at least 2 or 3 working on mainline.

>
> I will make the following observations:
>
> 1. With dwc2 you often end up in the situation where you need to
> service an interrupt every 125 uS.  If servicing that interrupt takes
> anywhere near 125 uS in the common case then you'll be in trouble.

I will try to measure this with a logic analyzer.

>
> ===
>
> 2. When I was testing on rk3288 (on kernel 3.14) I did see occasions
> where uvc_video_complete() could sometimes take > 125 uS.  It's been a
> long time now, but if I remember correctly this had to do with the
> fact that the URB buffers were allocated in a way where you had to
> access them non-cached and this was super duper slow.  In my
> particular case I could "fix" it by adjusting UVC_MAX_PACKETS
> (crosreview.com/321932).  ...and I had some timing code in
> crosreview.com/321980.
>
> Again, it was a long time ago, but elsewhere I have written down:
>
> -----
>
> Specifically:
> * The USB "complete" functions are called with local interrupts
> disabled.  Specifically see __usb_hcd_giveback_urb().
> * I see calls to uvc_video_complete() that easily take > 125us.
>
> Unfortunately the interrupts disabled while uvc_video_complete() is
> called are always the interrupts for the same CPU that's dealing with
> the normal dwc2 USB interrupts.
>
> --
>
> Ugh.  This may be the memcpy() as others have found:
>
> http://www.spinics.net/lists/linux-usb/msg83581.html
>
> ...looks like the issue is that the driver is allocating memory that's
> supposed to be DMA coherent and copying from this memory is slow.
>
> -----
>
> You could probably pick my timing patch and then see if you're
> actually hitting cases like this, I guess?
>
> ===
>
> 3. Are you running CPUFreq by chance?
>
> ...back in the day we had a bug on rk3288 where we were temporarily
> running the CPU as slow as 8 MHz for a short while during a CPUFreq
> transition.  If you happened to get a dwc2 interrupt while at this
> speed then you were in trouble.

There is no CPUFreq driver for bcm2835 in mainline and i hope the GPU
firmware doesn't play with the core frequency during runtime.

I also use the bcm2835_defconfig, which does have anything disabled
under kernel hacking.

Thanks
Stefan

>
>
> -Doug
