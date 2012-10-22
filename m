From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 11:14:23 -0600
Subject: [PATCH] ARM: dt: tegra: ventana: define pinmux for ddc
In-Reply-To: <5084F5D1.7050005@nvidia.com>
References: <1350626311-18131-1-git-send-email-markz@nvidia.com>
 <50817668.6020709@wwwdotorg.org> <5084F5D1.7050005@nvidia.com>
Message-ID: <50857EEF.2070707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 01:29 AM, Mark Zhang wrote:
> On 10/19/2012 11:48 PM, Stephen Warren wrote:
>> On 10/18/2012 11:58 PM, Mark Zhang wrote:
>>> Define pinmux for DDC. The DDC pinmux in Ventana is 2 pins in I2C2.
>>
>>> +++ b/arch/arm/boot/dts/tegra20-ventana.dts
>>
>>> -            ddc {
>>> -                nvidia,pins = "ddc", "owc", "spdi", "spdo",
>>> -                    "uac";
>>> -                nvidia,function = "rsvd2";
>>> -            };
>>
>> So that removes the entries for 5 pin groups, yet below, entries are
>> only added for the ddc and pta pingroups, so the other 4 pin groups
>> become unconfigured.
>>
> 
> Right. So I think it should be changed to:
> 
>         owc {
>             nvidia,pins = "owc", "spdi", "spdo", "uac";
>             nvidia,function = "rsvd2";
>         };
> 
> Is this right?

Looks correct, yes.

>>> +
>>> +        state_i2cmux_ddc: pinmux_i2cmux_ddc {
>>> +            ddc {
>>> +                nvidia,pins = "ddc";
>>> +                nvidia,function = "i2c2";
>>> +            };
>>> +            pta {
>>> +                nvidia,pins = "pta";
>>> +                nvidia,function = "rsvd4";
>>> +            };
>>
>> Does this actually work? The pta pingroup is configured by the "hog"
>> pinctrl state of the pinctrl node itself, so this state should fail to
>> be applied since it attempts to touch the same pingroup.
> 
> I know little about kernel pinctrl subsystem. After reading some docs
> and codes, I think what you mean is, in Ventana's pinmux configuration,
> pta pingroup has been defined as "hdmi" function and this can't be
> changed(non-dynamic pinmuxing).
> So I want to know why we have defined pta pingroup as hdmi function?
> Can we remove this definition to make the i2cmux above working?

I don't recall why pta was defined to be HDMI. The issue isn't that this
patch changes the pinmux selection for the pta pingroup, but simply that
both the pinctrl node's state definition, and the new I2C mux node's
state definition both attempt to configure pingroup pta. The solution is
most likely to simply remove the pta configuration from the main pinctrl
node.
