From: sjg@chromium.org (Simon Glass)
Date: Sat, 15 Aug 2015 07:46:38 -0600
Subject: [PATCH] arm: rpi: Device tree modifications for U-Boot
In-Reply-To: <CAL_Jsq++ihz6svJAKWwT7-=KyJvyWXjdf=tZb4aDGgV_Dc=-Nw@mail.gmail.com>
References: <1439303153-12171-1-git-send-email-sjg@chromium.org>
 <1439312701.2451.3.camel@lynxeye.de>
 <CAPnjgZ3ztXnkxZJvitiXiKMzq5+x46hbv0PW4HcF7yGgsXUV+Q@mail.gmail.com>
 <CAPnjgZ0hzyjy=8o8ocaGCoOC7Js4CirhystidbvtabzbhRi4RQ@mail.gmail.com>
 <CAL_Jsq++ihz6svJAKWwT7-=KyJvyWXjdf=tZb4aDGgV_Dc=-Nw@mail.gmail.com>
Message-ID: <CAPnjgZ3ubK_5j4AV4wO6xgoRf8iN+G8YSQm0pSW5fVzwpxYu5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 14 August 2015 at 14:29, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Aug 14, 2015 at 1:34 PM, Simon Glass <sjg@chromium.org> wrote:
>> -linux-tegra
>>
>> Hi,
>>
>> On 12 August 2015 at 07:21, Simon Glass <sjg@chromium.org> wrote:
>>> Hi Lucas,
>>>
>>> On 11 August 2015 at 11:05, Lucas Stach <dev@lynxeye.de> wrote:
>>>> Hi Simon,
>>>>
>>>> why did you send this to the Tegra ML?
>>>>
>>>> Am Dienstag, den 11.08.2015, 08:25 -0600 schrieb Simon Glass:
>>>>> This updates the device tree from the kernel version to something suitable
>>>>> for U-Boot:
>>>>>
>>>>> - Add stdout-path alias for console
>>>>> - Mark the /soc node to be available pre-relocation so that the early
>>>>> serial console works (we need the 'ranges' property to be available)
>
> I find it quite strange that you must explicitly enable the parent
> node, but not the uart node.

U-Boot tries hard to find and bind the UART using the stdout-path
link. I would like to add it in the UART node also but we were able to
work around it so far.

>
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>>  arch/arm/boot/dts/bcm2835.dtsi | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>>>>> index 301c73f..bd6bff6 100644
>>>>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>>>>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>>>>> @@ -8,6 +8,7 @@
>>>>>
>>>>>       chosen {
>>>>>               bootargs = "earlyprintk console=ttyAMA0";
>>>>> +             stdout-path = &uart;
>>>>>       };
>>>>>
>>>>>       soc {
>>>>> @@ -16,6 +17,7 @@
>>>>>               #size-cells = <1>;
>>>>>               ranges = <0x7e000000 0x20000000 0x02000000>;
>>>>>               dma-ranges = <0x40000000 0x00000000 0x20000000>;
>>>>> +             u-boot,dm-pre-reloc;
>>>>
>>>> Why do you need this and why should upstream carry your favourite
>>>> bootloaders configuration? This is in no way hardware description.
>>>
>>> I'm not sure how much you know about U-Boot, so let me know if you
>>> need more info.
>>>
>>> U-Boot normally starts up by setting up its serial UART and displaying
>>> a banner message. At this stage typically only a few devices are
>>> initialised (e.g. maybe just the UART). It then relocates itself to
>>> the top of memory and starts up all the devices. It throws away any
>>> previous devices that it set up before relocation and starts again.
>>>
>>> U-Boot uses a thing called driver model (dm) which handles driver
>>> binding and probing. Driver model has the device tree and would
>>> normally scan through it and create devices for everything it finds.
>
> How do you debug the DM itself? It seems like you still would need
> something earlier for debug like earlycon in the kernel. u-boot DM is
> probably simple enough you can get away with using it early, but you
> often can't as the complexity increases. Ultimately you need something
> simple that just hits all the registers needed to get characters out.
> What happens when you add pinmux, clocks, PMIC, power domains, etc. to
> the DM and they all become dependencies for the UART?

This doesn't seem like a device tree binding question but let me try
to answer it.

This is a problem - one of the challenges of driver model is that the
UART gets further away from the reset vector.

In U-Boot there is a single debug UART which can be supported by the
various serial drivers (only one can be selected on each platform).
There is a special debug_uart_init() function which is supposed to set
up the UART for that platform. After that, and until driver model UART
is up, console output can go through the debug UART.

>
>>> Before relocation we don't need every device. Also the CPU is often
>>> running slowly, perhaps without the cache enabled. SDRAM may not be
>>> available yet so space is short. We want to avoid starting up things
>>> that will not be used.
>>>
>>> So this property indicates that the device is needed before relocation
>>> and should be set up by driver model. We need it to avoid a very slow
>>> and memory-hungry startup.
>
> Can't the need for that property change over time? Either as more
> drivers are converted to DM you need to add this or you add some
> feature that depends on a driver (e.g. get a board rev or boot mode
> from GPIO). You would have backwards compatibility issues with this.
> I'm somewhat less worried about that for u-boot as we should be
> bundling the dtb and bootloader rather than kernel and dtb. For the
> UART, you can just get which UART to initialize early from
> stdout-path. But for other cases, couldn't you just have the platform
> provide the list of needed drivers. Then when u-boot needs change, you
> just change u-boot.

Yes U-Boot and its device tree are normally built from the same tree
at the same time. We don't expect to have to support an older or newer
device tree with the same U-Boot binary. So I don't see a problem
here.

The UART should have as few dependencies as possible. But if the
particular platform needs to check a GPIO to find out the UART number
(i.e. stdout-path cannot be used) then we would need to support that
case. It hasn't come up yet but it might. I certainly see platforms
where we need some other nodes before relocation and would like to
mark them as such. But I hope that for UART we can generally use
stdout-path.

The list of drivers doesn't help that much. What would I do with such
a list, and where would I keep such platform-specific information
other than in the device tree? It seems much simpler to hold the
information about what the platform needs to get through early boot in
one place. Then we have just a few lines of generic code to deal with
it.

>
>>> As to why upstream should accept it, my understanding of upstream is
>>> that people can send patches to it and in fact are encouraged to do
>>> so, to avoid misunderstandings and duplication. The device tree files
>>> are stored in Linux so any binding or source file changes should end
>>> up there. Otherwise the files tend to diverge and we end up with
>>> multiple bindings and multiple versions of the same source file.
>>
>> Is the above explanation sufficient? Will this patch be applied?
>
> Well, for starters bindings need to be documented, so you need to send
> this as a binding doc with this detail.

OK I'll update the patch and resend it.

Regards.
Simon
