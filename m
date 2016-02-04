From: john.stultz@linaro.org (John Stultz)
Date: Thu, 4 Feb 2016 15:46:15 -0800
Subject: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <20160204230814.GA4847@rob-hp-laptop>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
 <20160204230814.GA4847@rob-hp-laptop>
Message-ID: <CALAqxLVyznpLd2MLgGr28TDECpLZ=RpmhxH-SHqntXfBsctcmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 3:08 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Feb 02, 2016 at 05:59:11PM +0800, Andy Yan wrote:
>> add device tree bindings document for reboot-mode driver
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v3:
>> - descirbe all reboot mode as properity instead of subnode
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>  .../bindings/power/reset/reboot-mode.txt           | 26 ++++++++++++++++
>>  .../bindings/power/reset/syscon-reboot-mode.txt    | 36 ++++++++++++++++++++++
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> new file mode 100644
>> index 0000000..517080f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> @@ -0,0 +1,26 @@
>> +Generic reboot mode core map driver
>> +
>> +This driver get reboot mode arguments and call the write
>> +interface to stores the magic value in special register
>> +or ram . Then the bootloader can read it and take different
>> +action according the argument stored.
>> +
>> +All mode properties are vendor specific, it is a indication to tell
>
> The values should be vendor specific. The property names should not. We
> can allow vendor specific ones, but we need to have a common set.
>
>> +the bootloder what to do when the system reboot, and should be named
>> +as mode-xxx = <magic> (xxx is mode name).
>> +
>> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
>> +- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
>> +- mode-fastboot: Android fastboot mode, it's a mode to  re-flash partitions on the device.
>> +- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
>> +            usually used in development.
>> +- mode-maskrom: It's a mode to download bootloader on Rockchip platform.
>> +
>> +Example:
>> +     reboot-mode {
>> +             mode-normal = <BOOT_NORMAL>;
>> +             mode-recovery = <BOOT_RECOVERY>;
>> +             mode-fastboot = <BOOT_FASTBOOT>;
>
> I tend to agree with John on calling this mode-bootloader.
>
> OTOH, fastboot is more specific about what the mode is. The name in DT
> and the userspace name don't necessarily have to be the same.

Wait. This is a bit confusing. The utility of adding a property name
and using that name be the reboot command parsed for made sense
(compared to earlier versions which had command strings) as it made
the dts more terse.   But it sounds here like you're suggesting we
should have some logic in the driver that translates "reboot fastboot"
to mode-bootloader or vice versa.

>> +             mode-loader = <BOOT_LOADER>;
>
> This one needs a better name. Maybe it should be 'rockchip,mode-loader'
> as it is vendor specific. Either way, loader is vague. Perhaps
> rockchip,mode-bl-download?

Hrm. So how what reboot command do you expect to trigger that?

Though I do like the vendor specific prefix here, as it clarifies how
universal the command is (and its easy add standard commands if they
become more established and remap things in the future).

>
>> +             mode-maskrom = <BOOT_MASKROM>;
>
> I think this should be "mode-rom-download".

I think one of the difficult things here is that there's no real
standards for all bios/bootloader modes. So they are somewhat
firmware/bootloader/device specific, and thus we need something that
is flexible enough to allow lots of different modes to be easily
specified.  That said, this does expose a userspace interface (though
one could argue kernel ABI doesn't cross reboots :) so we should try
to have some consistency so the same userspace can work on various
devices.

I do think the "bootloader" and "recovery" arguments are somewhat
defacto standards, well established on most android devices.

I think here the concern is rockchip probably has some userspace that
is already using "reboot maskrom" or "reboot loader" for their own
uses. And its a bit of a pain to ask that userspace to be reworked to
use "reboot rom-download" or "reboot rockchip,rom-download" depending
on how we try to deal with these.  (Granted, non-upstream interfaces
aren't official, so that is their risk somewhat, but we avoid being
smug about that :)

Another part of the issue is there isn't really a way to probe for
reboot cmd capability here. As much as I'd rather not complicate
things, one couldn't easily extend existing userspace to work with
current kernels as well as future kernels, since the reboot with an
invalid command won't fail. The machine still resets. So you can't try
one and fallback to the other.

Maybe there needs to be a sysfs entry with the list of the supported commands?

thanks
-john
