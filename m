From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 21 Aug 2012 10:57:20 +0000
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <20120820200715.GT26991@opensource.wolfsonmicro.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
 <20120816140056.GK15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
 <20120820200715.GT26991@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA1AC7D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Aug 21, 2012 at 01:37:15, Mark Brown wrote:
> On Mon, Aug 20, 2012 at 06:27:01AM +0000, AnilKumar, Chimata wrote:
> > On Thu, Aug 16, 2012 at 19:30:56, Mark Brown wrote:
> 
> > > Why does this mean you need multiple regulators?  A single regulator can
> > > of course supply multiple devices.
> 
> > I got your point but tps65910 driver is failing if we add single fixed
> > regulator. Solution is driver needs to change or add multiple fixed
> > regulators.
> 
> No, really.  One regulator can supply many things, not being a.
> 
> > vrtc:
> > tps65910 0-002d: Failed to find supply vcc7
> > tps65910 0-002d: failed to register tps65910-pmic regulator
> 
> So you've specified a whole bunch of supplies and this one individual
> supply is not matching (and it's not the first...).  You should
> investigate what's gone wrong there rather than bodging around the
> problem.  I can't immediately say anything much based on the information
> you've given.
> 

Sorry for the noise in this issue, I found the root cause. I
was defining the supply names like this which is wrong.

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

This was suppose to be

&tps {
        vcc1-supply = <&vcc5v_supply>;
        vcc2-supply = <&vcc5v_supply>;
        vcc3-supply = <&vcc5v_supply>;
        vcc4-supply = <&vcc5v_supply>;
        vcc5-supply = <&vcc5v_supply>;
        vcc6-supply = <&vcc5v_supply>;
        vcc7-supply = <&vcc5v_supply>;
        vccio-supply = <&vcc5v_supply>;

        regulators {

                vrtc_reg: regulator at 0 { /* vrtc input is vcc7 */
                        regulator-always-on;
                };

                ... 
                ...
        };
};

Thanks for your continuous feedback.

Thanks
AnilKumar
