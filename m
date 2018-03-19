From: david@lechnology.com (David Lechner)
Date: Mon, 19 Mar 2018 17:54:27 -0500
Subject: =?UTF-8?Q?Re:_[PATCH_v8_00/42]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
In-Reply-To: <CAHCN7xLt6QqHodd=0HKXBxLjjn8ua5Re7NYW=sPeH+TmnXpkJQ@mail.gmail.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <CAMpxmJX-AxhpPpCnWoaSGYmNh3o8iRjdKacnmozsPWmhpcGdTg@mail.gmail.com>
 <af89be8d-04dd-e845-1d5b-afdd7e55629f@lechnology.com>
 <CAHCN7xKQ47DnVXiZTJ-0myoth2SJ3wnyvDb2i07uKZDgomhgwQ@mail.gmail.com>
 <CAMpxmJWoP+BDYeuqCnQ2txWy7wkxKuyjKODJqgDtRkq0ahY1mw@mail.gmail.com>
 <CAMpxmJX+BqnU=cK0KMOOCrXd4bB2RRZ30A-U3f3tk6K05csrTw@mail.gmail.com>
 <CAHCN7xLt6QqHodd=0HKXBxLjjn8ua5Re7NYW=sPeH+TmnXpkJQ@mail.gmail.com>
Message-ID: <4dc2725d-0dee-1c7f-1e6d-9a93e6228826@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2018 12:52 PM, Adam Ford wrote:
> On Mon, Mar 19, 2018 at 11:15 AM, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>> 2018-03-19 17:14 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
>>> 2018-03-19 17:11 GMT+01:00 Adam Ford <aford173@gmail.com>:
>>>> On Mon, Mar 19, 2018 at 10:59 AM, David Lechner <david@lechnology.com> wrote:
>>>>> On 03/19/2018 08:17 AM, Bartosz Golaszewski wrote:
>>>>>>
>>>>>> 2018-03-16 3:52 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>>>>
>>>>>>> This series converts mach-davinci to use the common clock framework.
>>>>>>>
>>>>>>> The series works like this, the first 19 patches create new clock drivers
>>>>>>> using the common clock framework. There are basically 3 groups of clocks
>>>>>>> -
>>>>>>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each
>>>>>>> have
>>>>>>> unique init data, which is the reason for so many patches.
>>>>>>>
>>>>>>> Then, starting with "ARM: davinci: pass clock as parameter to
>>>>>>> davinci_timer_init()", we get the mach code ready for the switch by
>>>>>>> adding the
>>>>>>> code needed for the new clock drivers and adding #ifndef
>>>>>>> CONFIG_COMMON_CLK
>>>>>>> around the legacy clocks so that we can switch easily between the old and
>>>>>>> the
>>>>>>> new.
>>>>>>>
>>>>>>> "ARM: davinci: switch to common clock framework" actually flips the
>>>>>>> switch
>>>>>>> to start using the new clock drivers. Then the next 8 patches remove all
>>>>>>> of the old clock code.
>>>>>>>
>>>>>>> The final three patches add device tree clock support to the one SoC that
>>>>>>> supports it.
>>>>>>>
>>>>>>> This series has been tested on LEGO MINDSTORMS EV3 (device tree) and TI
>>>>>>> OMAP-L138 LCDK (both device tree and legacy board file).
>>>>>>>
> 
> 
> Does anyone have an LCD connected to the LCDC controller with device
> tree?  I posted an RFC patch a while ago for the DA850-EVM, but I got
> distracted and forgot about it, so I never working on getting the
> patch ready for acceptance.
> 
> I am trying to test the LCD now, but I cannot get the screen to come
> up, but in the process, it appears as if the clocking to the LCD isn't
> quite right.  I know it used to work, but I am going to probe some
> pins, but I am getting warning messages I have never received before.
> The desired clock frequency is 9000000, but when I use the cpufreq in
> ondemand mode, I get the following messages:
> 
> #  echo ondemand > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> # tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz) differs from the
>   calculated rate (54000000Hz)
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz) differs from the
>   calculated rate (54000000Hz)
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz) differs from the
>   calculated rate (54000000Hz)
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz) differs from the
>   calculated rate (54000000Hz)
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz) differs from the
>   calculated rate (54000000Hz)
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz) differs from the
>   calculated rate (54000000Hz)
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> 
> As ondemend is used and the processor scaling happens, the above
> message appears on and off.
> 
> I do not know if it impacts the LCD image since I haven't been able to
> get it working yet, but I'll troubleshoot it and when/if I can get the
> LCD working, I'll turn on the ondemand again and see how it behaves.
> 
> adam
> 
> 

I've just been using the VGA connector on the LCDK since that is the only
hardware I have that uses the LCDC controller and I haven't tried it with
ondemand CPU freq yet.

But, I do know this. The parent clock for the LCDC (PLL0 SYSCLK2) must be
(according to the TRM) set to a fixed ratio to the ARM clock (/2), so it
can only have certain rates. The tilcdc driver then tries to pick a
divider for that rate to get close enough to the requested 54MHz. Also,
this divider must be at least 2. It can't be 1 (or 0).

So, if the CPU throttles down to 100, 200, or 300MHz, then 50Mz is as
close as any integer divider can get. The kernel prints a warning if
the difference between the requested and actual rate is over 5%. There
is a note in the kernel comments that this 5% value is arbitrary, so
maybe it needs to change to 10%?

I haven't dug deep enough to understand why the driver thinks it needs
a 54MHz pixel when you think it should be 9MHz.

I am also occasionally seeing the underflow error when the CPU is busy.
Maybe there is some more tweaking that could be done with the master
priority controller (unrelated to this patch series)? Or maybe if you
want to use the LCDC, then you just need to run at 475MHz all of the
time?
