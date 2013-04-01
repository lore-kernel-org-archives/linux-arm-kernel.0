From: robherring2@gmail.com (Rob Herring)
Date: Mon, 01 Apr 2013 17:40:32 -0500
Subject: [PATCH 08/10] arm: zynq: Add smp support
In-Reply-To: <CAHTX3dLD6gPG-1nzbk9gcsiO=SAq7UKDa7vvOOYHvTHt8zJhUg@mail.gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
 <51505C39.4060507@gmail.com> <51507BCC.2050707@monstr.eu>
 <5150CB64.5030502@gmail.com>
 <CAHTX3dLD6gPG-1nzbk9gcsiO=SAq7UKDa7vvOOYHvTHt8zJhUg@mail.gmail.com>
Message-ID: <515A0CE0.7050401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 02:42 AM, Michal Simek wrote:
> 2013/3/25 Rob Herring <robherring2@gmail.com>:
>> On 03/25/2013 11:31 AM, Michal Simek wrote:
>>> On 03/25/2013 03:16 PM, Rob Herring wrote:
>>>> On 03/25/2013 08:53 AM, Michal Simek wrote:
>>>>> Zynq is dual core Cortex A9 which starts always
>>>>> at zero. Using simple trampoline ensure long jump
>>>>> to secondary_startup code.

[...]

>>>>> +        slcr_cpu_stop(cpu);
>>>>
>>>> Isn't a secondary cpu already stopped?
>>>
>>> On the normal boot this is really necessary because first stage bootloader
>>> doesn't stop cpu just keep it in loop and without stopping cpu
>>> and starting it again it doesn't work.
>>
>> And there is no way to exit the loop other than a reset?
> 
> You can exit the loop by writing jump address to one location where bootloader
> expect it. Then it jumps to proper function and it was done like that before.
> But this is not suitable for cpu hotplug because that loop is placed
> in OCM (on chip memory)
> and it can be used for different purpose.
> Also there is no way how to return cpu to this mode.

I was asking about the cold boot case, not hotplug. If you are spinning
in the bootloader waiting for a jump address, then why do you need the
slcr_cpu_stop for cold boot? In the hotplug case, you have already
called slcr_cpu_stop in the unplug path, so this shouldn't be needed
there either.

[...]

>>>>> +            __raw_writel(address, phys_to_virt(0x8));
>>
>> This should be a per core address including core 0 if you ever want to
>> do something like cpuidle powergating on one core and hotplug on another.
> 
> That's interesting idea.
> Please correct me if I am wrong, I didn't play with cpuidle.
> 
> Zynq is dual core and hotplug can be done only on cpu1. (not sure if
> in general cpu0
> can be unplugged too. If yes, are you doing that?).

You cannot do hotplug on cpu 0, but that is a current Linux limitation.
I believe support to hotplug cpu 0 was recently added for x86. So this
may change at some point.

What the h/w can support is another issue. Some chips have independent
power domains per core and some have combined domains. I can and do
powergate individual cores including core 0 in cpuidle for highbank. The
main difference to hotplug is whether I set the wake-up address when I
go down (cpuidle) or when I wake the core (hotplug). For hotplug, you
don't want the core to come back before the kernel is ready for it.

> I didn't play with cpuidle code but I am not quite sure if you can use hotplug
> if cpu0 is in idle because this code is for >cpu0.
> 
> I can imagine to be more flexible on quad core where your comment make
> definitely sense.

The next part could be quad core...

Rob
