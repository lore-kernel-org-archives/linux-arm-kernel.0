From: dgreid@chromium.org (Dylan Reid)
Date: Wed, 13 Aug 2014 12:07:59 -0700
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53EB9BF0.9010002@wwwdotorg.org>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <53EB9BF0.9010002@wwwdotorg.org>
Message-ID: <CAEUnVG6ki9O5hzw9OvJ1+8Www_G1+rqXujmNyJy+qOP-z_JR=A@mail.gmail.com>
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

I'll change the model to "Acer Chromebook 13"

If we need a separate DT for the FullHD skew, then can we add a file
'tegra124-nyan-big-full-hd.dtsi'?  We may also add
'tegra124-nyan-big-full-hd-touch.dtsi' as well.  They would just
override the necessary things from this file.

>
>
>> +       gpio-keys {
>> +               compatible = "gpio-keys";
>> +
>> +               lid {
>> +                       label = "Lid";
>> +                       gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
>> +                       linux,input-type = <5>;
>> +                       linux,code = <0>;
>
>
> Aren't there #defines for the 5 and 0 there?

yes for code, apparently not for input-type.  I think 5 means EV_SW,
maybe that should get added to include/dt-bindings/input somewhere?

>
>
>> +       sound {
>> +               compatible = "nvidia,tegra-audio-max98090-venice2",
>> +                            "nvidia,tegra-audio-max98090";
>> +               nvidia,model = "NVIDIA Tegra Venice2";
>
>
> Those strings should all use the same board name as the filename, compatible
> value, and model of the root node. Based on the content in your patch, I
> would expect:
>
>                 compatible = "nvidia,tegra-audio-max98090-big",
>                              "nvidia,tegra-audio-max98090";
>                 nvidia,model = "Google Big";

Changed model to Acer Chromebook 13 and the compativle string to 'nyan-big'.

>
> In particular, nvidia,model is used to index into /var/lib/alsa/asound.state
> by name, so it needs to be unique for each board.
>
>
>> +               nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(R, 7)
>> +                                                       GPIO_ACTIVE_HIGH>;
>
>
> That property doesn't (yet) exist in the binding/code upstream. It could
> obviously be added.

I will remove it from this patch, and get it added to the driver first.

Thanks for reviewing!
