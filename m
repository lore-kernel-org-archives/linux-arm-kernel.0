From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 30 Apr 2015 21:38:32 +0800
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <20150430092953.GA32190@leverpostej>
References: <55417F5A.4040300@linaro.org> <3341308.O9mDCt0NEl@wuerfel>
 <CAFEAcA_VSkPPhmMmn+M+AoX5wjB0r66xq0ygMLSfR7zg0yiXnw@mail.gmail.com>
 <20150430092953.GA32190@leverpostej>
Message-ID: <55423058.8010509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?04?30? 17:29, Mark Rutland wrote:
> On Thu, Apr 30, 2015 at 10:08:05AM +0100, Peter Maydell wrote:
>> On 30 April 2015 at 09:03, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thursday 30 April 2015 09:03:22 Shannon Zhao wrote:
>>>>
>>>> I am looking at adding support for external power down and reboot to
>>>> ARM VMs.  With ACPI this is fairly straight forward and requires only
>>>> adding a GPIO controller to the virt machine model and extending ACPI
>>>> appropriately (see code here [1]). In addition Linaro LEG also have
>>>> done a test that uses GPIO as power button to shutdown OS on fast model
>>>> (see detail here [2]).
>>>>
>>>> However, we would like for this to work in systems that do not use
>>>> ACPI as well. Adding a GPIO controller will still work, but we would
>>>> need a generic way to tell Linux how to handle the GPIO events without
>>>> adding any board-specific code to the VIRT platform. And what guest
>>>> kernel driver do we need? Do we need another user-level daemon like acpid?
>>>>
>>>> Note that external shutdown can also be accomplished using the qemu
>>>> guest agent [3], but maybe this is not a sufficiently stable approach.
>>>>
>>>> Any input on the approach to take here is very welcome.
>>>
>>> I would expect drivers/power/reset/gpio-poweroff.c to work in an identical
>>> way with ACPI and DT, once you have added an ACPI binding for it.
>>
>> Looking at Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
>> that appears to be for "let the guest kernel turn off the system
>> from the inside by toggling a GPIO line". What we want is the
>> opposite: the external system (QEMU, in this case) toggles a GPIO
>> line in order to request the guest kernel to do a clean shutdown
>> or reboot. Or have I misunderstood what gpio-poweroff can do?
>
> No, you're correct.
>
> There are a few "power button" bindings around, but it looks like they
> all rely on platform details and aren't that generic.
>
> With ACPI what events may be singalled? Just power off, or reset, etc?

For the ACPI events, we generally have three events:
  - sleep event
  - power off event
  - wakeup event

>
> Which of these do we need to be able to handle with DT?

I think power off event is the most used event, sleep
and wakeup events are often used for laptops.

For ACPI based power off, there will be a GPIO singled
event (hardware reduced platform such as ARM64) or a
special interrupt called SCI signaled to OS to let
OS know there is a button event happened, then there is
a driver handle this interrupt to tell the detail event,
the driver will send the event to user space using input
framework(deprecated) or netlink event.

I think DT can do it in a similar way, using input framework
or netlink sending power button to user space and shutdown
the system.

If any detail information needed, please let me know.

Thanks
Hanjun
