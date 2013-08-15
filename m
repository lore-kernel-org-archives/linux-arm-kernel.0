From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 15 Aug 2013 15:36:09 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815042812.GA8968@kroah.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
Message-ID: <CAGsJ_4w2hOgsOB=ZYmWqm7tM+pL6=UMR1fG++A+rdAReJzFSjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/15 Greg KH <greg@kroah.com>:
> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:
>> For the moment, there is strong markting requirement from
>> IVI(In-Vehicle Infotainment) or mobile to use ARM Trustzone. We take
>> IVI as an example, Auto requires security enviorment to access CAN bus
>> and other car busses. Auto requires security enviorment to show
>> rearview/surround view from cameras and play alert audio. on the other
>> hand, IVI system is generically working as a video streaming sink and
>> HDMI sink instead of a source. To support HDCP and widevine, we need
>> to make sure private keys and video buffers are only visible to
>> security mode. With CAN stack, video playback backend and more tasks,
>> generically it requires a multi-task RTOS running in security mode
>> parallel with Linux in non-security mode.
>>
>> Linux is a generic purpose OS with UI and all kinds of software, but
>> we need to make sure even the Linux is ROOTed, RTOS in security mode
>> is still active. We are able to find some opensource projects like
>> SafeG[1], Multivisor[2], SierraVisor[3], but it turns out that ARM
>> Linux has no rich support for this kind of architecture:
>> 1. hypervisor running in monitor mode
>> 2. RTOS running in security mode
>> 3. Linux running in non-security mode
>
> "Linux" is just a kernel, not a whole operating system :)

do agree. but  i am not saying i want linux kernel to do all these
things. i just want kernel is able to integrate into the system.

>
> Anyway, why can't Linux be the RTOS kernel as well?  What are the
> requirements for that kernel that Linux does not currently meet?
>
>> So the point is that we need generic support for this, especially for
>> IVI and other markets which want Trustzone technology a lot and have
>> complex user scenarios.
>> 1. Dispatch FIQ to security, dispatch IRQ to Linux, for this case, FIQ
>> is not permitted to happen on Linux
>
> Isn't that up to the hardware?  Nothing that Linux can do about that.

right. but linux need to assign interrupts to right group in GIC
hardware. now it doesn't care.

>
>> 2. IPC support for communication between RTOS in security mode and
>> Linux in non-security mode, as we need to communicate rich commands
>> and buffers
>
> What about using the virtual protocols we already have today for the
> existing hypervisors?  Don't reinvent something new if you don't have
> to.
>
>> 3. as some CPU time is stolen by security mode, so the scheduler need
>> to get this for load balance
>
> Does the kernel know this time is gone?  Or is it not aware of it (like
> MSIs on x86?)

for the moment, no if we don't have hooks similar with kvm, xen for it.

>
> thanks,
>
> greg k-h

-barry
