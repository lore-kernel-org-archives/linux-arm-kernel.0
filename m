From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Aug 2014 10:23:07 -0700
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53EB9BF0.9010002@wwwdotorg.org>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <53EB9BF0.9010002@wwwdotorg.org>
Message-ID: <CAOesGMhAzx==sXnHBg4dhAtO3=JP-s-MmzujskctA=7OUC0uRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 10:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/12/2014 07:56 PM, Dylan Reid wrote:
>>
>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>> processor and is similar to the Venice2 reference platform.
>>
>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>> and work on the 1366x768 models.  I haven't tried on the HD systems
>> yet.
>>
>> WiFi does not yet work, it needs at least some PMIC changes to enable
>> the 32k clock.
>>
>> The elan trackpad is not yet functional but hopefully will be soon as
>> there are patches under review.
>>
>> There is also an issue on reboot because the TPM isn't reset.  It will
>> cause the stock firmware to enter recovery mode.  This can be worked
>> around by an EC-reset, press refresh and power at the same time.
>
>
>> diff --git a/arch/arm/boot/dts/tegra124-big.dts
>> b/arch/arm/boot/dts/tegra124-big.dts
>
>
> I think we need to include the SKU name in the filename and compatible value
> below, or at least plan out that for other SKUs, we'll add the SKU name on.
>
>
>> +/ {
>> +       model = "Google Big";
>> +       compatible = "google,nyan-big", "nvidia,tegra124";
>
>
> I think it'd be more user-friendly if the filename and compatible value more
> obviously tied to the end-user-visible product name.

We didn't prefix the reference platform on the very first one we
shipped (snow), but for the peach platforms we used peach-pit and
peach-pi. Those had different SoCs inside (albeit very similar ones),
so there was a reason for separate DTS files.

Here, we should probably prefix with nyan (so tegra124-nyan-big.dts).
Users have shown themselves to be quite happy to use the internal
names, they also tend to be less confusing (since we can't rely on the
vendor to rename the product when the internals change, so we would
need a separate namespace anyway).

What we did on pit/pi was to add a more-specific revision of the
hardware in front. That was more about dealing with various
generations of the hardware though (as components sometimes change
over the lifetime production). Here it's more about the basic
SKU/feature set (panel size, touch screen). I suspect we'll do a
big-touch.dts that just includes this and appends the TS device.

For the panel sizes, do we need the specifics in the DT instead of via
EDID? Do we really need to describe the exact panel in the DTS? Note
that panels are pretty common to change over the production run of a
product too, second sourcing, etc.

Model could be changed to "Acer Chromebook 13", I suppose. In the past
we've used "Google Peach Pit", "Google Snow". No user has complained
yet about that.


-Olof
