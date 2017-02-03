From: lukma@denx.de (Lukasz Majewski)
Date: Sat, 4 Feb 2017 00:21:50 +0100
Subject: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5
 GHz SoC operation
In-Reply-To: <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
 <1486135491-14223-2-git-send-email-lukma@denx.de>
 <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
Message-ID: <20170204002150.707b231d@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thanks for sharing the knowledge :-)

> On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
> > The "opp_high" property brings support for 1.5 GHz CPU frequency
> > for TI's am57xx line of processors.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/dra7.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> 
> This can't be blindly enabled for all am57xx SoCs, 

Yes, I'm fully aware of AVS, which uses fuses and SoC silicon revision
to assess if frequency can be enabled.

Example from my playground:

- AM5728 works with 1.5 GHz enabled

- AM5718 hangs when I try to enable 1.5 GHz frequency


> there is a
> forthcoming ti-cpufreq [1] driver 

I've backported and tested this code on v4.9 vanilla. It works :-)

> that is needed that will decided
> which OPPs can and cannot be enabled for the specific variant in use.

I do have a question:

Do you know the correct opp-supported-hw value for 1.5 GHz on AM57x8
SoC?
In TI's SDK Linux (v4.4): opp-supported-hw = <0xFF 0x04>; but this seems
to be always enabled (and not taking silicon revision and efuse into
account).

For my use case it would be best to see what data should prevent my
AM5718 from 1.5 GHz OPP. 

In other words I need to be 100% sure that my silicon SoC version
doesn't support the 1.5 GHz frequency.


> 
> Regards,
> Dave
> 
> [1] http://www.spinics.net/lists/devicetree/msg158967.html
> 
> > diff --git a/arch/arm/boot/dts/dra7.dtsi
> > b/arch/arm/boot/dts/dra7.dtsi index a860a56..5e678cd 100644
> > --- a/arch/arm/boot/dts/dra7.dtsi
> > +++ b/arch/arm/boot/dts/dra7.dtsi
> > @@ -108,6 +108,11 @@
> >  			opp-hz = /bits/ 64 <1176000000>;
> >  			opp-microvolt = <1160000 885000 1160000>;
> >  		};
> > +
> > +		opp_high at 1500000000 {
> > +			opp-hz = /bits/ 64 <1500000000>;
> > +			opp-microvolt = <1210000 950000 1250000>;
> > +		};
> >  	};
> >
> >  	/*
> >
> 


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
