From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 10:59:20 +0200
Subject: [PATCH v2 1/5] ARM: dts: Add Peach Pit and Pi dts entry for
 max77802 PMIC
In-Reply-To: <CAD=FV=VVLmnvZToewvsiJDUbapPj5BBA=RG4a7_N9wadRN7CTg@mail.gmail.com>
References: <1408533593-32346-1-git-send-email-javier.martinez@collabora.co.uk>	<1408533593-32346-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=VVLmnvZToewvsiJDUbapPj5BBA=RG4a7_N9wadRN7CTg@mail.gmail.com>
Message-ID: <541012E8.9010208@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 09/10/2014 06:42 AM, Doug Anderson wrote:
>> +
>> +                       ldo35_reg: LDO35 {
>> +                               regulator-name = "ldo_35";
>> +                               regulator-min-microvolt = <1200000>;
>> +                               regulator-max-microvolt = <1200000>;
>> +                               inl2-supply = <&buck7_reg>;
> 
> Is this a typo?  Shouldn't supplies be specified at the top?
>

Yes it is a left over from a previous attempt. The first time I looked at the
DT binding doc to see how parent supplies should be defined, the example said:

        xyzreg: regulator at 0 {
                regulator-min-microvolt = <1000000>;
                regulator-max-microvolt = <2500000>;
                regulator-always-on;
                vin-supply = <&vin>;
        };

but that didn't work for me since the parent supplies are not parsed in
of_get_regulation_constraints() [0] but in regulator_register() [1] by calling
regulator_dev_lookup() passing the parent device.

So then I looked at other DTS and found that the supplies where indeed defined
on the top as properties of the "regulators" parent node so that's what I
used. I missed to remove the supply for this regulator, thanks a lot for noticing.

BTW, Documentation/devicetree/bindings/regulator/regulator.txt should be
changed to reflect that the supplies should not be defined in the regulator
node but in the parent node but that is unrelated to this patch of course.

> 
> Other than that, you can add my Reviewed-by.
> 

Best regards,
Javier

[0]: http://lxr.free-electrons.com/source/drivers/regulator/of_regulator.c#L19
[1]: http://lxr.free-electrons.com/source/drivers/regulator/core.c#L3506
