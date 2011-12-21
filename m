From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Dec 2011 17:59:07 +0800
Subject: Is Pandaboard cpuhotplug working stably?
In-Reply-To: <20111221094624.GB3354@n2100.arm.linux.org.uk>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Dec 21, 2011 at 05:23:48PM +0800, Barry Song wrote:
>> Hi guys,
>> i tried cpuhotplug on pandaboard for both
>> Pandroid_Froyo_L27.8.2_release_pkg and Linaro 11.11. It has failed to
>> work stably.
>> On Pandroid_Froyo_L27.8.2_release_pkg, unplugging cpu1 works well:
>> # echo 0 > /sys/devices/system/cpu/cpu1/online
>> CPU1: shutdown
>>
>> if i enable the cpu1 again by "echo 1 >
>> /sys/devices/system/cpu/cpu1/online", the system will restore to 3
>> random status: hang, normal, panic.
>>
>> Using ?Linaro 11.11 release, "echo 0 >
>> /sys/devices/system/cpu/cpu1/online" will make system hang and the
>> whole system will not be able to reset by pressing reset key, the only
>> way to reset system is pulling out AV power.
>>
>> i am sorry i can't get more time to debug and find more clues. just
>> want to ask people whether this is a version the cpuhotplug works
>> normal on?
>
> cpu hotplug is basically totally buggered - the preconditions placed
> upon the bringup code path are basically impossible to satisfy in any
> shape or form at the moment.
>
> There's the requirement that the secondary CPU is marked online and
> active before interrupts are enabled for the thread migration stuff
> to behave correctly. ?However, this is incompatible with smp_call_function()
> which will wait for online CPUs to respond to an IPI - which this one
> won't because interrupts are disabled.
>
> I think there was some discussion about how to fix this but I don't
> recall the details.

thanks, Russell. then could i think this is an ARM-kernel-specific bug
which exists on all ARM SMP chips for the moment?
and that bug doesn't happen on x86:
root at ubuntu:~/simple-rootfs/initrd/bin# echo 0 >
/sys/devices/system/cpu/cpu3/online
root at ubuntu:~/simple-rootfs/initrd/bin# echo 1 >
/sys/devices/system/cpu/cpu3/online
root at ubuntu:~/simple-rootfs/initrd/bin# echo 0 >
/sys/devices/system/cpu/cpu2/online
root at ubuntu:~/simple-rootfs/initrd/bin# echo 1 >
/sys/devices/system/cpu/cpu2/online

-barry
