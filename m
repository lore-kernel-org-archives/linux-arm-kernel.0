From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu, 21 Jan 2016 14:27:57 +0800
Subject: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
In-Reply-To: <20160120182840.GA15741@rob-hp-laptop>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop>
Message-ID: <56A07A6D.3010406@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob:
    thanks for your review.
On 2016?01?21? 02:28, Rob Herring wrote:
> On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
>> add device tree binding document for reboot-mode driver
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>   .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++++++++++
>>   .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++++++++++++++
>>   2 files changed, 93 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> new file mode 100644
>> index 0000000..81d9f66
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> @@ -0,0 +1,41 @@
>> +Generic reboot mode core map driver
>> +
>> +This driver get reboot mode arguments and call the write
>> +interface to stores the magic value in special register
>> +or ram . Then the bootloader can read it and take different
>> +action according to the argument stored.
>> +
>> +Required properties:
>> +- compatible: only support "syscon-reboot-mode" now.
>> +
>> +Each mode is represented as a sub-node of reboot_mode:
>> +
>> +Subnode required properties:
>> +- linux,mode: reboot mode command,such as "loader", "recovery", "fastboot".
>> +- loader,magic: magic number for the mode, this is vendor specific.
>> +
>> +Example:
>> +	reboot_mode {
> reboot-mode instead please.
>

     Sorry, I have already correct it in DT file, forget it here. It 
will be changed in next version.

>> +		compatible = "syscon-reboot-mode";
>> +		offset = <0x40>;
> This doc by itself is a little confusing. For example, is a child of the
> syscon node? I would remove offset (and perhaps compatible) from this
> example.

    Yes, is a child of a syscon mapped node. For example, Rockchip 
platform use a register of PMU(rk3066/rk3288) or GRF(rk3036), PMU and 
GRF are aleady mapped by syscon.
    offset and compatible are used by write interface driver like 
syscon-reboot-mode.c. If you don't like it appear in the core map doc, I 
will move it to the syscon-reboot-mode.txt?
>> +
>> +		loader {
>> +			linux,mode = "loader";
>> +			loader,magic = <BOOT_LOADER>;
>> +		};
> Sorry, my previous suggestion was not clear. I'm suggesting get rid of
> the subnodes and just do properties like this:
>
> loader = <BOOT_LOADER>;
> maskrom = <BOOT_MASKROM>;
>
> That's the same amount of information unless node names and linux,mode
> values are going to diverge. Do they need to? I can't see a reason.

     Because the command"linux,mode" and value"loader,magic" is vendor 
specific. I don't know what commands and how many mode other platform 
will use. So as John says in his reply, this sort of flexibility help us 
adapt the driver to different hardware/system environments.
>
> We need to be clear what loader means. More specifically, it is boot
> into bootloader shell.
     Actually, Rockchip platform will reboot into a bootloader download 
mode with this command. This mode can download faster than maskrom 
download mode.
>> +
>> +		maskrom {
> In theory, the bootrom could have multiple modes. This typically means a
> USB download mode. So perhaps a more precise name would be
> "rom-download".
>
> In chips I'm familiar with the bootrom mode is selected via a different
> mechanism than the secondary bootloader modes, but I suppose the same
> mechanism could be used.
    Yes , they use the same mechanism.
>> +			linux,mode = "maskrom";
>> +			loader,magic = <BOOT_MASKROM>;
>> +		};
>> +
>> +		recovery {
>> +			linux,mode = "recovery";
>> +			loader,magic = <BOOT_RECOVERY>;
>> +		};
>> +
>> +		fastboot {
>> +			linux,mode = "fastboot";
>> +			loader,magic = <BOOT_FASTBOOT>;
>> +		};
>
>
>
