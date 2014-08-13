From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Aug 2014 14:17:08 -0600
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAOesGMgeLbuURwA1VVxkLp=vH9PB_VdUHFJthH=ae-_ZDVYyAA@mail.gmail.com>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>	<53EB9BF0.9010002@wwwdotorg.org>	<CAOesGMhAzx==sXnHBg4dhAtO3=JP-s-MmzujskctA=7OUC0uRg@mail.gmail.com>	<53EBA0ED.30607@wwwdotorg.org>
 <CAOesGMgeLbuURwA1VVxkLp=vH9PB_VdUHFJthH=ae-_ZDVYyAA@mail.gmail.com>
Message-ID: <53EBC7C4.4050601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 11:37 AM, Olof Johansson wrote:
> On Wed, Aug 13, 2014 at 10:31 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/13/2014 11:23 AM, Olof Johansson wrote:
>>>
>>> On Wed, Aug 13, 2014 at 10:10 AM, Stephen Warren <swarren@wwwdotorg.org>
>>> wrote:
>>>>
>>>> On 08/12/2014 07:56 PM, Dylan Reid wrote:
>>>>>
>>>>>
>>>>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>>>>> processor and is similar to the Venice2 reference platform.
>>>>>
>>>>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>>>>> and work on the 1366x768 models.  I haven't tried on the HD systems
>>>>> yet.
>>>>>
>>>>> WiFi does not yet work, it needs at least some PMIC changes to enable
>>>>> the 32k clock.
>>>>>
>>>>> The elan trackpad is not yet functional but hopefully will be soon as
>>>>> there are patches under review.
>>>>>
>>>>> There is also an issue on reboot because the TPM isn't reset.  It will
>>>>> cause the stock firmware to enter recovery mode.  This can be worked
>>>>> around by an EC-reset, press refresh and power at the same time.
>>>>
>>>>
>>>>
>>>>> diff --git a/arch/arm/boot/dts/tegra124-big.dts
>>>>> b/arch/arm/boot/dts/tegra124-big.dts
>>>>
>>>>
>>>>
>>>> I think we need to include the SKU name in the filename and compatible
>>>> value
>>>> below, or at least plan out that for other SKUs, we'll add the SKU name
>>>> on.
>>>>
>>>>
>>>>> +/ {
>>>>> +       model = "Google Big";
>>>>> +       compatible = "google,nyan-big", "nvidia,tegra124";
>>>>
>>>>
>>>>
>>>> I think it'd be more user-friendly if the filename and compatible value
>>>> more
>>>> obviously tied to the end-user-visible product name.
>>>
>>>
>>> We didn't prefix the reference platform on the very first one we
>>> shipped (snow), but for the peach platforms we used peach-pit and
>>> peach-pi. Those had different SoCs inside (albeit very similar ones),
>>> so there was a reason for separate DTS files.
>>>
>>> Here, we should probably prefix with nyan (so tegra124-nyan-big.dts).
>>> Users have shown themselves to be quite happy to use the internal
>>> names, they also tend to be less confusing (since we can't rely on the
>>> vendor to rename the product when the internals change, so we would
>>> need a separate namespace anyway).
>>
>>
>> I can see that the vendor might change the internals without changing the
>> product name. That kind of thing happens too frequently across all kinds of
>> products. So, there are certainly disadvantages using consumer marketing
>> names here.
>>
>> Presumably though the name "big" would no longer apply to any modified HW?
>> Hence, I can't understand the need to say "nyan-big" rather than just "big".
>> Is "nyan-" really needed to fully qualify the name? Also, the board isn't a
>> Nyan, albeit the design may have been strongly derived from the reference
>> board named Nyan.
>
> it's more about partitioning the namespace and showing similarities
> (nyan-big and nyan-foo might be able to share a common dtsi for most
> of the platform, for example).

I don't think the files need to have a common prefix to include common 
content.

In other words, assuming the naming made sense, the following would be 
fine if it represented reality:

tegra124-nyan.dtsi  represents common parts of a reference design
tegra124-foo.dts    includes tegra124-foo.dts
tegra124-bar.dts    includes tegra124-foo.dts

> See https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-3.10/arch/arm/boot/dts/
> for how it's done in the product tree (some of those bindings are of
> course divergent from upstream, so it's more about the file structure
> in this case).

I've actually disliked the fact that the Venice2 board was represented 
as tegra124-nyan-rev0.dts rather than tegra124-venice2.dts there...
