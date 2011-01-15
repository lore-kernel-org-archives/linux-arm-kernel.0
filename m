From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Sat, 15 Jan 2011 19:58:39 +0100
Subject: [PATCH v2] ARM: pxa: PalmZ72: Add OV9640 camera support
In-Reply-To: <201101151941.07494.marek.vasut@gmail.com>
References: <1295054277-7879-1-git-send-email-marek.vasut@gmail.com>
	<20110115170829.GL15996@n2100.arm.linux.org.uk>
	<AANLkTinpAGgmLmjerVHVF6Z2ET1hZG3vtfFVcZYjB=EN@mail.gmail.com>
	<201101151941.07494.marek.vasut@gmail.com>
Message-ID: <AANLkTi=ks1DWPd4ahKGovtq3SJj6yO_Bs7D9Nd-exvUk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/15 Marek Vasut <marek.vasut@gmail.com>:
> On Saturday 15 January 2011 18:49:16 Bj?rn Forsman wrote:
>> 2011/1/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > On Sat, Jan 15, 2011 at 05:37:08PM +0100, Bj?rn Forsman wrote:
>> >> Hi,
>> >>
>> >> On 15 January 2011 02:17, Marek Vasut <marek.vasut@gmail.com> wrote:
>> >> > Rework of patch from 2009:
>> >> > PalmZ72: Add support for OV9640 camera sensor
>> >> >
>> >> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> >> > ---
>> >> > v2: Use gpio_request_array()/gpio_free_array() array
>> >> >
>> >> > ?arch/arm/mach-pxa/include/mach/palmz72.h | ? ?5 +
>> >> > ?arch/arm/mach-pxa/palmz72.c ? ? ? ? ? ? ?| ?127
>> >> > ++++++++++++++++++++++++++++++ 2 files changed, 132 insertions(+), 0
>> >> > deletions(-)
>> >> >
>> >> > diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h
>> >> > b/arch/arm/mach-pxa/include/mach/palmz72.h index 2bbcf70..0d4700a
>> >> > 100644
>> >> > --- a/arch/arm/mach-pxa/include/mach/palmz72.h
>> >> > +++ b/arch/arm/mach-pxa/include/mach/palmz72.h
>> >>
>> >> [snip]
>> >>
>> >> > +static int palmz72_camera_power(struct device *dev, int power)
>> >> > +{
>> >> > + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_PWDN, !power);
>> >> > + ? ? ? mdelay(50);
>> >> > + ? ? ? return 0;
>> >> > +}
>> >> > +
>> >> > +static int palmz72_camera_reset(struct device *dev)
>> >> > +{
>> >> > + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 1);
>> >> > + ? ? ? mdelay(50);
>> >> > + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 0);
>> >> > + ? ? ? mdelay(50);
>> >> > + ? ? ? return 0;
>> >> > +}
>> >>
>> >> (Sorry if these are stupid newbie-questions.)
>> >>
>> >> Is the entire kernel blocked during the above mdelay()s or
>> >> just some kernel thread? (Or: will this add like 100ms or 150ms
>> >> to boot time?)
>> >>
>> >> Can mdelay() be replaced with something non-blocking?
>> >
>> > mdelay() is a spinning delay - it doesn't voluntarily relinquish the
>> > CPU to another task.
>> >
>> > If you have preempt enabled and the region is preemptable, you can be
>> > preempted in the middle of the delay (in which case it becomes delay
>> > time + time away from the thread.)
>> >
>> > msleep() can be used for places where you can sleep, but is limited to
>> > the jiffy granularity for !HIRES kernels.
>>
>> Thanks for explaining!
>>
>> Marek, care to try msleep() so we avoid busy-waits?
>
> Let's keep it at mdelay() for now, can we? I'll send a subsequent patch once I
> can test with msleep() ... I don't have the hardware available now.

Sure. It was only a suggestion :-)

Best regards,
Bj?rn Forsman
