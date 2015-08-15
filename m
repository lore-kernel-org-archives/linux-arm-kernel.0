From: sjg@chromium.org (Simon Glass)
Date: Sat, 15 Aug 2015 07:47:00 -0600
Subject: [PATCH] arm: rpi: Device tree modifications for U-Boot
In-Reply-To: <55CEB607.7060908@wwwdotorg.org>
References: <1439303153-12171-1-git-send-email-sjg@chromium.org>
 <1439312701.2451.3.camel@lynxeye.de>
 <CAPnjgZ3ztXnkxZJvitiXiKMzq5+x46hbv0PW4HcF7yGgsXUV+Q@mail.gmail.com>
 <55CEB607.7060908@wwwdotorg.org>
Message-ID: <CAPnjgZ1KxqDf2o_UnsmbWs9DZJpupj6D2trBACrJm-eT1g_xVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 14 August 2015 at 21:46, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/12/2015 07:21 AM, Simon Glass wrote:
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
>>
>> Before relocation we don't need every device. Also the CPU is often
>> running slowly, perhaps without the cache enabled. SDRAM may not be
>> available yet so space is short. We want to avoid starting up things
>> that will not be used.
>>
>> So this property indicates that the device is needed before relocation
>> and should be set up by driver model. We need it to avoid a very slow
>> and memory-hungry startup.
>>
>> As to why upstream should accept it, my understanding of upstream is
>> that people can send patches to it and in fact are encouraged to do
>> so, to avoid misunderstandings and duplication. The device tree files
>> are stored in Linux so any binding or source file changes should end
>> up there. Otherwise the files tend to diverge and we end up with
>> multiple bindings and multiple versions of the same source file.
>
> On many platforms, we have U-Boot SPL running first, then the main
> U-Boot. The main U-Boot binary contains both the code to do the
> relocation and the binary that runs after relocation. It seems like it'd
> be simpler to split these up into 3 binaries that each do a single job:
>
> 1) SPL, roughly as-is today (varying jobs depending on platform)
>
> 2) Relocator, which does nothing but work out where to copy U-Boot,
> memcpy()s it there, relocates the image (if not PIE), and jumps to it.
>
> 3) The main U-Boot.
>
> Item (2) above should be simple enough that it can use a very simple
> debug mechanism rather like DEBUG_LL in the Linux kernel. Similar to
> what Rob mentioned in his email.
>
> Item (3) could use DM and DT/ACPI/... to get device information in a
> complete non-hard-coded manner.

This comment does no seem to relate to my patch. We could certainly
re-architect U-Boot to work this way. There are  lot of reasons why
U-Boot works as it does and many platforms don't have SPL.

Relating what you said to the current U-Boot, your item (2) is
analogous to us not setting up driver model before relocation at all,
and just having a debug UART. That's a huge topic though, well beyond
the scope of my original patch. I think it would be better for you to
start a thread on the U-Boot mailing list with your proposal. At least
on x86 (which has no SPL) there are all sorts of things that currently
happen before relocation.

Regards,
Simon
