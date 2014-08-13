From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Aug 2014 09:55:38 -0700
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53EB9786.6010809@wwwdotorg.org>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <20140813085304.GE7735@ulmo> <53EB9786.6010809@wwwdotorg.org>
Message-ID: <CAOesGMgtBMQvHxz37pftMdJgOR0pD_NLZFLd+0FE5OxnozFSRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 9:51 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/13/2014 02:53 AM, Thierry Reding wrote:
>>
>> On Tue, Aug 12, 2014 at 06:56:07PM -0700, Dylan Reid wrote:
>>>
>>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>>> processor and is similar to the Venice2 reference platform.
>>>
>>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>>> and work on the 1366x768 models.  I haven't tried on the HD systems
>>> yet.
>>
>>
>> Presumably the HD systems will have a different compatible? Is it only
>> the panel that's different or are there other changes?
>
>
> Yes, we definitely need to plan ahead for the different SKUs. I assume we'll
> have different board names for each board, which then translates int DT
> filenames and U-Boot/cbootimage-configs/tegra-uboot-flasher board
>
>
>>> There is also an issue on reboot because the TPM isn't reset.  It will
>>> cause the stock firmware to enter recovery mode.  This can be worked
>>> around by an EC-reset, press refresh and power at the same time.
>>
>>
>> It's not clear to me what exactly this implies. Does it mean the system
>> won't boot unless you manually press "refresh" and "power"? Are those
>> keyboard buttons or keys on some debug board?
>>
>>> diff --git a/arch/arm/boot/dts/tegra124-big.dts
>>> b/arch/arm/boot/dts/tegra124-big.dts
>
>
>>> +/ {
>>> +       model = "Google Big";
>>
>>
>> Perhaps this should at least mention that it's the Acer Chromebook 13.
>> Otherwise this could just as well be some random development board.
>>
>>> +       compatible = "google,nyan-big", "nvidia,tegra124";
>>
>>
>> What's "nyan"? Are there other variants of "big" other than "nyan"?
>
>
> I thought this board was known as Nike?
>
>
>>> +       pinmux: pinmux at 0,70000868 {
>>> +               pinctrl-names = "default";
>>> +               pinctrl-0 = <&pinmux_default>;
>>> +
>>> +               pinmux_default: common {
>>> +                       dap_mclk1_pw4 {
>>> +                               nvidia,pins = "dap_mclk1_pw4";
>>> +                               nvidia,function = "extperiph1";
>>> +                               nvidia,enable-input =
>>> <TEGRA_PIN_DISABLE>;
>>> +                               nvidia,pull = <TEGRA_PIN_PULL_NONE>;
>>> +                               nvidia,tristate = <TEGRA_PIN_DISABLE>;
>>> +                       };
>>
>>
>> Stephen proposed a patch not so long ago that removes the static pinmux
>> settings from DTS files[0]. I'd expect he'll have objections to this DTS
>> providing the static settings.
>>
>> The assumption with that patch is that the bootloader will have to set
>> up the entire pinmux anyway (to prevent conflicting settings), therefore
>> there'd be no need to do it in the kernel. Is this something that your
>> bootloader already does (or could be modified to do)?
>>
>> [0]: http://patchwork.ozlabs.org/patch/363222/
>
>
> Yes, definitely I want to remove the pinmux from the kernel, since the HW
> design implies that the bootloader must set this up completely.
>
> IIRC, the bootloader on this device doesn't. However, the workaround was
> that the U-Boot that the firmware chain-loads in order to load Linux (which
> IIRC is mandatory for non-Google kernels?) would do this setup before
> booting the kernel.

You can wrap a regular mainline kernel with the verified boot block
and load it without u-boot. I do it all the time on x86, ARM is no
different.

The main reason for using u-boot is so that you get a command line,
can do network-based booting, bootloader configuration scripts, and so
on.

So, it's not a useful workaround, unfortunately. :(


-Olof
