From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 15 Aug 2013 16:36:04 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <CABb+yY3CoL2i2FOXUthbv4isUYLV-cOSbHi2wwUz9KwXVNYhyA@mail.gmail.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <CABb+yY3CoL2i2FOXUthbv4isUYLV-cOSbHi2wwUz9KwXVNYhyA@mail.gmail.com>
Message-ID: <CAGsJ_4zGpOV3AJHX+=v0wGB_Vrc3em0ArjUDFvH7J1EOnxh1UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/15 Jassi Brar <jassisinghbrar@gmail.com>:
> On Thu, Aug 15, 2013 at 1:15 PM, Barry Song <21cnbao@gmail.com> wrote:
>> 2013/8/15 Jassi Brar <jassisinghbrar@gmail.com>:
>>> On Thu, Aug 15, 2013 at 9:58 AM, Greg KH <greg@kroah.com> wrote:
>>>> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:
>>>>> For the moment, there is strong markting requirement from
>>>>> IVI(In-Vehicle Infotainment) or mobile to use ARM Trustzone. We take
>>>>> IVI as an example, Auto requires security enviorment to access CAN bus
>>>>> and other car busses. Auto requires security enviorment to show
>>>>> rearview/surround view from cameras and play alert audio. on the other
>>>>> hand, IVI system is generically working as a video streaming sink and
>>>>> HDMI sink instead of a source. To support HDCP and widevine, we need
>>>>> to make sure private keys and video buffers are only visible to
>>>>> security mode. With CAN stack, video playback backend and more tasks,
>>>>> generically it requires a multi-task RTOS running in security mode
>>>>> parallel with Linux in non-security mode.
>>>>>
>>>>> Linux is a generic purpose OS with UI and all kinds of software, but
>>>>> we need to make sure even the Linux is ROOTed, RTOS in security mode
>>>>> is still active. We are able to find some opensource projects like
>>>>> SafeG[1], Multivisor[2], SierraVisor[3], but it turns out that ARM
>>>>> Linux has no rich support for this kind of architecture:
>>>>> 1. hypervisor running in monitor mode
>>>>> 2. RTOS running in security mode
>>>>> 3. Linux running in non-security mode
>>>>
>>>> "Linux" is just a kernel, not a whole operating system :)
>>>>
>>>> Anyway, why can't Linux be the RTOS kernel as well?  What are the
>>>> requirements for that kernel that Linux does not currently meet?
>>
>> we will run rtos+linux instead of linux+linux. typically, Auto
>> industry has long history to use rtos. on the other hand, we need to
>> boot the rtos very fast in hundreds of milliseconds to make sure
>> rearview, early audio have been ready.
>>
> Why do you think optimized linux can't boot up in "hundereds of millisecs"?

yes. i think linux can boot up in "hundereds of millisecs" if we do
decrease the drivers, refine our drivers and don't mount a big
filesystem running on slow storage.
but just like linux has a strong eco-system, auto has strong auto
eco-system. even we put linux+linux, our customers will replace the
backend linux by its own rtos.

>
>>>>
>>> Yes, in fact at least during development Linux usually runs in Secure mode.
>>> Ideally I would love to see 2 instances of Linux running - one inrs
>>> NonSecure mode and another in Secure mode, getting capabilities via 2
>>> corresponding DTBs reflecting the h/w partitioning done by the TZ.
>>
>> not real. i think there are similar users in linux already. at least
>> omap and exynos have some chip specific codes like omap-smc.S,
>> sleep34xx.S, exynos-smc.S and so on.
>>
> ... and there are socs that has TZ but don't implement SMC (yet).
>
yes. that is because they don't need.
markting input for automotive industry requires TZ. without it, we
still need other replacement like NoC firewall. TZ turns out to the
best one integrated well in ARM SoC.


>> and i have explained why we don't use linux+linux.
>>
>>>
>>>>
>>>>> 3. as some CPU time is stolen by security mode, so the scheduler need
>>>>> to get this for load balance
>>>>
>>>> Does the kernel know this time is gone?  Or is it not aware of it (like
>>>> MSIs on x86?)
>>>>
>>> The TrustedOS could share time on the same cpu as the UnTrustedOS or
>>> be assigned a dedicated cpu on an MP.
>>
>> no. TrustedOS will not hold a whole CPU and we don't put a whole core
>> to RTOS as it has low CPU loading.
>>
>  If by "we" you mean you and your device, I can understand. Otherwise
> please have a look at some TZ whitepaper. It is possible to run in AMP
> mode where SecureOS has dedicated cpu core(s).

yes. i do agree. i saw xilinx zynq has a mode, "CPU0 with freertos
+CPU1 with linux". but i talked with xilinx guys, even some xilinx
guys think it is not flexible enough.

anyway, this arch is not ok to me and my devices. this is a waster of
cpu resource.

-barry
