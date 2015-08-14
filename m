From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Aug 2015 15:29:03 -0500
Subject: [PATCH] arm: rpi: Device tree modifications for U-Boot
In-Reply-To: <CAPnjgZ0hzyjy=8o8ocaGCoOC7Js4CirhystidbvtabzbhRi4RQ@mail.gmail.com>
References: <1439303153-12171-1-git-send-email-sjg@chromium.org>
 <1439312701.2451.3.camel@lynxeye.de>
 <CAPnjgZ3ztXnkxZJvitiXiKMzq5+x46hbv0PW4HcF7yGgsXUV+Q@mail.gmail.com>
 <CAPnjgZ0hzyjy=8o8ocaGCoOC7Js4CirhystidbvtabzbhRi4RQ@mail.gmail.com>
Message-ID: <CAL_Jsq++ihz6svJAKWwT7-=KyJvyWXjdf=tZb4aDGgV_Dc=-Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 1:34 PM, Simon Glass <sjg@chromium.org> wrote:
> -linux-tegra
>
> Hi,
>
> On 12 August 2015 at 07:21, Simon Glass <sjg@chromium.org> wrote:
>> Hi Lucas,
>>
>> On 11 August 2015 at 11:05, Lucas Stach <dev@lynxeye.de> wrote:
>>> Hi Simon,
>>>
>>> why did you send this to the Tegra ML?
>>>
>>> Am Dienstag, den 11.08.2015, 08:25 -0600 schrieb Simon Glass:
>>>> This updates the device tree from the kernel version to something suitable
>>>> for U-Boot:
>>>>
>>>> - Add stdout-path alias for console
>>>> - Mark the /soc node to be available pre-relocation so that the early
>>>> serial console works (we need the 'ranges' property to be available)

I find it quite strange that you must explicitly enable the parent
node, but not the uart node.

>>>>
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>
>>>>  arch/arm/boot/dts/bcm2835.dtsi | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>>>> index 301c73f..bd6bff6 100644
>>>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>>>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>>>> @@ -8,6 +8,7 @@
>>>>
>>>>       chosen {
>>>>               bootargs = "earlyprintk console=ttyAMA0";
>>>> +             stdout-path = &uart;
>>>>       };
>>>>
>>>>       soc {
>>>> @@ -16,6 +17,7 @@
>>>>               #size-cells = <1>;
>>>>               ranges = <0x7e000000 0x20000000 0x02000000>;
>>>>               dma-ranges = <0x40000000 0x00000000 0x20000000>;
>>>> +             u-boot,dm-pre-reloc;
>>>
>>> Why do you need this and why should upstream carry your favourite
>>> bootloaders configuration? This is in no way hardware description.
>>
>> I'm not sure how much you know about U-Boot, so let me know if you
>> need more info.
>>
>> U-Boot normally starts up by setting up its serial UART and displaying
>> a banner message. At this stage typically only a few devices are
>> initialised (e.g. maybe just the UART). It then relocates itself to
>> the top of memory and starts up all the devices. It throws away any
>> previous devices that it set up before relocation and starts again.
>>
>> U-Boot uses a thing called driver model (dm) which handles driver
>> binding and probing. Driver model has the device tree and would
>> normally scan through it and create devices for everything it finds.

How do you debug the DM itself? It seems like you still would need
something earlier for debug like earlycon in the kernel. u-boot DM is
probably simple enough you can get away with using it early, but you
often can't as the complexity increases. Ultimately you need something
simple that just hits all the registers needed to get characters out.
What happens when you add pinmux, clocks, PMIC, power domains, etc. to
the DM and they all become dependencies for the UART?

>> Before relocation we don't need every device. Also the CPU is often
>> running slowly, perhaps without the cache enabled. SDRAM may not be
>> available yet so space is short. We want to avoid starting up things
>> that will not be used.
>>
>> So this property indicates that the device is needed before relocation
>> and should be set up by driver model. We need it to avoid a very slow
>> and memory-hungry startup.

Can't the need for that property change over time? Either as more
drivers are converted to DM you need to add this or you add some
feature that depends on a driver (e.g. get a board rev or boot mode
from GPIO). You would have backwards compatibility issues with this.
I'm somewhat less worried about that for u-boot as we should be
bundling the dtb and bootloader rather than kernel and dtb. For the
UART, you can just get which UART to initialize early from
stdout-path. But for other cases, couldn't you just have the platform
provide the list of needed drivers. Then when u-boot needs change, you
just change u-boot.

>> As to why upstream should accept it, my understanding of upstream is
>> that people can send patches to it and in fact are encouraged to do
>> so, to avoid misunderstandings and duplication. The device tree files
>> are stored in Linux so any binding or source file changes should end
>> up there. Otherwise the files tend to diverge and we end up with
>> multiple bindings and multiple versions of the same source file.
>
> Is the above explanation sufficient? Will this patch be applied?

Well, for starters bindings need to be documented, so you need to send
this as a binding doc with this detail.

Rob
