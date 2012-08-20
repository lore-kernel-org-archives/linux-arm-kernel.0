From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 20 Aug 2012 06:27:01 +0000
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <20120816140056.GK15365@opensource.wolfsonmicro.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
 <20120816140056.GK15365@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Aug 16, 2012 at 19:30:56, Mark Brown wrote:
> On Thu, Aug 16, 2012 at 01:22:27PM +0000, AnilKumar, Chimata wrote:
> 
> > But problem here is single input supply battery/main is not sufficient.
> 
> What makes you say this?
> 
> > pmic->desc[i].supply_name = info->vin_name;
> > with this assignment regulator core searches for exact supply name vcc1 or
> > vcc2 etc if there are no matches then it will not register any regulators. 
> 
> Why does this mean you need multiple regulators?  A single regulator can
> of course supply multiple devices.

I got your point but tps65910 driver is failing if we add single fixed
regulator. Solution is driver needs to change or add multiple fixed
regulators.

Let's take this example

ocp {
        vcc5v_supply: fixedregulator at 0 {
                compatible = "regulator-fixed";
                regulator-name = "vcc5v";
                regulator-boot-on;
        };
};

/include/ "tps65910.dtsi"

&tps {
        regulators {
                vcc1-supply = <&vcc5v_supply>;
                vcc2-supply = <&vcc5v_supply>;
                vcc3-supply = <&vcc5v_supply>;
                vcc4-supply = <&vcc5v_supply>;
                vcc5-supply = <&vcc5v_supply>;
                vcc6-supply = <&vcc5v_supply>;
                vcc7-supply = <&vcc5v_supply>;
                vccio-supply = <&vcc5v_supply>;

                vrtc_reg: regulator at 0 { /* vrtc input is vcc7 */
                        regulator-always-on;
                };

                ... 
                ...
        };
};

These changes are added to am335x-evm.dts file after this change I
am seeing below error.

vrtc:
tps65910 0-002d: Failed to find supply vcc7
tps65910 0-002d: failed to register tps65910-pmic regulator

To get rid of this error we have to change the driver like this

if (info->vin_name) {
         snprintf(in_supply, 32, "%s-supply", info->vin_name);
         if (of_find_property(np, in_supply, 0))
                  pmic_plat_data->input_supply[idx] = info->vin_name;
}

And

pmic->desc[i].supply_name = pmic_plat_data->input_supply[i];

Regards
AnilKumar
