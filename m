From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Apr 2018 17:53:02 +0530
Subject: [RFC 2/2] DTS: davinci: da850evm: Enable LCD and Backlight
In-Reply-To: <CAHCN7xLw090i3Xe1gZ76gziN183vi9Caj-XR7hz4PT2E+GCEOw@mail.gmail.com>
References: <1504933135-29747-1-git-send-email-aford173@gmail.com>
 <1504933135-29747-2-git-send-email-aford173@gmail.com>
 <6cf5489c-0e87-0c9e-23e4-5b5ad40744a2@ti.com>
 <CAHCN7xLw090i3Xe1gZ76gziN183vi9Caj-XR7hz4PT2E+GCEOw@mail.gmail.com>
Message-ID: <7d2e1d9a-8d67-492d-fb12-0304bc162c93@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 March 2018 10:29 PM, Adam Ford wrote:
> On Mon, Sep 11, 2017 at 5:02 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Saturday 09 September 2017 10:28 AM, Adam Ford wrote:
>>> When using the board files the LCD works, but not with the DT.
>>> This adds enables the original da850-evm to work with the same
>>> LCD in device tree mode.
>>>
>>> RFC:  Currently, I cannot get the backlight to do anything other
>>> than 100%. I don't get the userspace files to write the brightness.
>>> Any suggestions on what I am dowing wrong?
>>
>> Not sure what went wrong for you here, but applying your patches and
>> building the new kernel & modules did create the
>> /sys/class/backlight/backlight/brightness needed.
>>
>> That said, the brightness changes did not seem take effect. I did not
>> debug it further.
>>
> 
> It looks like there is an issue with the PWM.  The pin is able to be
> muxed between EPWM0_TZ or ECAP2_PWM2.
> I am trying to use ecap2, but when looking at the pin on the scope
> it's not toggling.  Is that the correct PWM to use?

Hmm, based on the schematic I have LCD_PWM is connected to eHRPWM1B.
Unfortunately, on this board that pin is also used for SPI1 CS0. I think
this is the reason even the legacy boot lacks backlight control feature.
On earlier versions of the board, the same SoC pin was sent unbuffered
to both the LCD and SPI flash. You could see the LCD flicker when SPI
accesses happen. This was fixed in later versions of the board by adding
a buffer.

I think it is best to leave out backlight control completely.

There is panel and backlight power connected to GP8[10] and GP2[15]
respectively. I don't see those enabled in your patch. BTW,
DA850_LCD_PWR_PIN defined in board-da850-evm.c seems to be pointing to
the wrong GPIO.

I also get these warnings which I did not see before.

OF: graph: no port node found in /soc at 1c00000/display at 213000
OF: graph: no port node found in /soc at 1c00000/display at 213000
OF: graph: no port node found in /soc at 1c00000/display at 213000

> 
> Do you know if ecap2 is setup to clock correctly on L138 using DT?
> Looking at this patch, do you see anything that stands out
> 
> Thanks for any suggestions you might have.  I know I let this go stale
> for a while, but I'm still trying to modernize the DT whenever
> possible.

Thanks for your efforts on this. It will be nice to see
board-da850-evm.c go away.

Thanks,
Sekhar
