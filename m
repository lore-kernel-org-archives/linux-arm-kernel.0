From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 10 Oct 2012 12:47:31 +0530
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <3430030.rKEkeKmzui@vostro.rjw.lan>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <20121009145854.GB14079@kroah.com> <20121009151704.GP12801@game.jcrosoft.org>
 <3430030.rKEkeKmzui@vostro.rjw.lan>
Message-ID: <5075210B.3020309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/10/2012 3:42 AM, Rafael J. Wysocki wrote:
> On Tuesday 09 of October 2012 17:17:04 Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 07:58 Tue 09 Oct     , Greg Kroah-Hartman wrote:
>>> On Tue, Oct 09, 2012 at 01:46:33PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> On 22:02 Sun 07 Oct     , Rafael J. Wysocki wrote:
>>>>> On Sunday 07 of October 2012 15:12:01 Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>> On 00:18 Sun 07 Oct     , Rafael J. Wysocki wrote:
>>>>>>> On Saturday 06 of October 2012 18:14:29 Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> The following changes since commit 5f3d2f2e1a63679cf1c4a4210f2f1cc2f335bef6:
>>>>>>>>
>>>>>>>>   Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2012-10-06 03:16:12 +0900)
>>>>>>>>
>>>>>>>> are available in the git repository at:
>>>>>>>>
>>>>>>>>
>>>>>>>>   git://git.jcrosoft.org/linux-2.6.git tags/pm_suspend_standby_mem
>>>>>>>>
>>>>>>>> for you to fetch changes up to b73c8f97aa8e720bd3b921159687d00626c99d63:
>>>>>>>>
>>>>>>>>   arm: at91: drop at91_suspend_entering_slow_clock (2012-10-06 18:06:25 +0800)
>>>>>>>>
>>>>>>>> ----------------------------------------------------------------
>>>>>>>> pm: add suspend_mem and suspend_standby support
>>>>>>>>
>>>>>>>> Today when we go to suspend we can not knwon at drivers level if we go in
>>>>>>>> STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
>>>>>>>> suspend_standby.
>>>>>>>
>>>>>>> No way. Device drivers shouldn't be concerned about that.
>>>>>> I do need it on at91 as we swith to slow_clock in MEM suspend and some ip
>>>>>> need special handling when switching to slow_clock
>>>>>
>>>>> Well, my answer to that is: please fix your platform code instead of
>>>>> hacking the PM core to work around its problems.
>>>> how can I fix drivers pm issue when I no way to known at driver level the
>>>> real suspend, the PM core is supposed to proivde the right information to the
>>>> drivers so the driver can put it's in the right pm mode. If the pm core can not
>>>> provide such inforation the PM core is broken as we will have to do dirty
>>>> hack.
>>>
>>> Why do you need to know the difference in your driver?  We used to
>>> provide this information a long time ago, but it turned out to not be
>>> needed at all and just caused problems.
>> because on at91 I need to handle the mem standby at drviers level.
> 
> This is not an answer.  You're basically saying "it has to be done this way,
> because it has to be done this way".
> 
>> We do it today already by a hack in different drivers at91_udc (usb device),
>> atmel_serail and at91_ohci. Those 3 IP have specifci handling when switching
>> to mem pm. On at91 when switch to mem we shutdown everything and run form a slow
>> clock - this is done at soc level - but those IP have issue and need specific
>> care before doing so. Ohterwise when the SoC will wakeup but those IP will not
>>
>> in this patch series I send the update of those 3 drivers too
>> and kill the hack
> 
> Well, let's start over.  What's the difference between "suspend to RAM" (mem)
> and "standby" on your platform?
> 
>>>> Any generic framework is supposed to evolve for real user need here I've one
>>>> so I udpate the core to mach a need
> 
> Yes, if there are more users needing a change.  If there's only one, I think not
> really.
> 

We came across such a need while supporting various low-power modes in
AM335x SoC. I also wanted to put similar proposal, its good that Jean
submitted patches and we are having this discussion early.

Let me try to describe the need and issue here,

In case of AM33xx device, we have different low-power modes supported
by HW, for this discussion I will just talk about DeepSleep-0 and
StandBy mode supported by HW (few other modes also described in spec)-

Below is the Spec definition of these two low-power modes,

PowerMode    Application state             States
========================================================================
DeepSleep0   Everything is preserved       Master Oscillator = OFF
             including SDRAM.              VDD_MPU = 0.95v
                                           VDD_CORE = 0.95v
                                           PD_WKUP = ON
                                           PD_MPU = OFF
                                           PD_PER = OFF
                                           PD_GFX = OFF
                                           All IOs & RTC supplies are ON


Standby      Everything is preserved       Master Oscillator = ON
             including SDRAM.              One PLL is ON
             Only required module clocks   VDD_MPU = 0.95v
             are enabled rest are clock    VDD_CORE = OPP50
             gated                         PD_WKUP = ON
                                           PD_MPU = ON
                                           PD_PER = ON
                                           PD_GFX = OFF
                                           All IOs & RTC supplies are ON
                                           If more PLLs /power domains/
                                           modules are required, the
                                           power will increase
                                           accordingly



Now we have two major parameters here, Power Consumption and Latency
(Sleep + Wakeup). Since DeepSleep-0 is as good as off state, it gives
very less power consumption Vs huge Latency number, whereas, in case of
standby the power consumption is more but the Latency is reduced.

In addition to that, there are certain HW related parameters and issues
contribute to these parameters. For example,

In case of LCD driver the suspend/resume latency is in the range of
10msec, which can be reduced if driver knows that he is not entering or
entered in DeepSleep-0 and choose not to do certain things.
Another example would be, USB driver, we have seen Latency numbers in
the range of 200msec, and of which 100 msec can simply be taken away if
driver knows about the sleep state.


I understand that, there is trade-off between power and latency numbers,
but for certain use-cases latency is more important and it is not
possible without telling driver about the low-power state.


Thanks,
Vaibhav
> Thanks,
> Rafael
> 
> 
