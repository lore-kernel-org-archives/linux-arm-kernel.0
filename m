From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu, 24 Mar 2016 15:27:55 +0800
Subject: [PATCH v6 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <CAJKOXPdUW5f6_sz14NMU8LP+QoKStB9omXticMkQX4D866okWw@mail.gmail.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646592-540-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPdUW5f6_sz14NMU8LP+QoKStB9omXticMkQX4D866okWw@mail.gmail.com>
Message-ID: <56F396FB.8030402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof:

On 2016?03?24? 10:27, Krzysztof Kozlowski wrote:
> Interesting idea. While looking at the code I stumped over few things below:
>
> On Tue, Mar 22, 2016 at 8:36 PM, Andy Yan <andy.yan@rock-chips.com> wrote:
>> add device tree bindings document for reboot-mode driver
> s/add/Add/
> Plus a full-stop at the end of sentence.
     okay, I will do it in next version.
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> binding
> What is that?

     This will be removed
>
>> ---
>>
>> Changes in v6:
>> - fix a typo with "property"
>> - describe property "mask" more clear
>>
>> Changes in v5:
>> - delete a unnecessary blank line in syscon-reboot-mode.txt
>> - rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
>> - rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more clear mean
>>
>> Changes in v4:
>> - remove mode-maskrom
>> - rename mode-fastboot to mode-bootloader to keep compatible with the exiting Android device
>>
>> Changes in v3:
>> - descirbe all reboot mode as properity instead of subnode
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>   .../bindings/power/reset/reboot-mode.txt           | 24 +++++++++++++++
>>   .../bindings/power/reset/syscon-reboot-mode.txt    | 35 ++++++++++++++++++++++
>>   2 files changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> new file mode 100644
>> index 0000000..3457949
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> @@ -0,0 +1,24 @@
>> +Generic reboot mode core map driver
>> +
>> +This driver get reboot mode arguments and call the write
>> +interface to stores the magic value in special register
> s/stores/store/
>> +or ram . Then the bootloader can read it and take different
> s/ram ./ram./
>
>> +action according the argument stored.
> according to
>
>> +
>> +All mode properties are vendor specific, it is a indication to tell
>> +the bootloder what to do when the system reboot, and should be named
> s/bootloder/bootloader/
> s/reboot/reboots/
>
>> +as mode-xxx = <magic> (xxx is mode name).
>> +
> These are examples? If yes then add a note, like:
>
> +For example modes common on Android platform:

     Thanks for your carefully review, all these will be fixed in next 
version.
>> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
>> +- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
>> +- mode-bootloader: Android fastboot mode, it's a mode to re-flash partitions on the Android based device.
>> +- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
>> +              usually used in development.
> The "bootloader" and "loader" examples are very confusing. Maybe just
> name the first one as "mode-fastboot" and second as
> "rockchip-download"? The term "loader" does not look for me as
> anything related to uploading/downloading new firmware.

     About these two modes, we have a long discussion with Rob and John [0]
     We keep them as what you see now to keep compatibility with exiting 
devices.

  [0] https://lkml.org/lkml/2016/2/2/128
>
>> +
>> +Example:
>> +       reboot-mode {
>> +               mode-normal = <BOOT_NORMAL>;
>> +               mode-recovery = <BOOT_RECOVERY>;
>> +               mode-bootloader = <BOOT_FASTBOOT>;
>> +               mode-loader = <BOOT_BL_DOWNLOAD>;
>> +       }
>> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>> new file mode 100644
>> index 0000000..eb28469
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>> @@ -0,0 +1,35 @@
>> +SYSCON reboot mode driver
>> +
>> +This driver get reboot mode magic value form reboot-mode driver
> s/get/gets/
>
>> +and stores it in a SYSCON mapped register. Then the bootloader
>> +can read it and take different action according to the magic
>> +value stored.
>> +
>> +This DT node should be represented as a sub-node of a "syscon", "simple-mfd"
>> +node.
>> +
>> +Required properties:
>> +- compatible: should be "syscon-reboot-mode"
>> +- offset: offset in the register map for the storage register (in bytes)
>> +
>> +Optional property:
>> +- mask: bits mask of the bits in the register to store the reboot mode magic value,
>> +  default set to 0xffffffff if missing.
>> +
>> +The rest of the properties should follow the generic reboot-mode discription
> s/discription/description/
>
> Please, run the spell check...
>
> Best regards,
> Krzysztof
>
>
>
>
