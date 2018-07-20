From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jul 2018 16:36:33 +0100
Subject: Computing the dynamic-power-coefficient on Exynos5422
In-Reply-To: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
References: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
Message-ID: <20180720153633.GP17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 04:15:30PM +0200, Oliver Effland wrote:
> Hello everyone,
> 
> I hope this is the right place to ask, otherwise please just point me in the right direction.
> 
> I'm currently testing the EAS patches [v4] on an ODROID-XU3 board, which has an Exynos5422 SoC. However, the corresponding DT is missing the "dynamic-power-coefficient" that is needed for an appropriate EM.
> So I'm trying to compute the dynamic-power-coefficient according to the formula:
> 
> Pdyn = dynamic-power-coefficient * V^2 * f
> 
> The frequency f is given by the DT.The actual Voltage and Power are determined by means of the on-chip sensors (returns the values for the specific cluster). When using the Voltage given in the DT, the differences for the d-p-coefficient are negligible.
> 
> So I'm calculating the d-p-coefficient (mW/MHz/uV^2) by reading out the following SoC sensor values.

Well, let's work this forward.  Let's take a simple, reasonable case.

V=1V, f = 200MHz.  Now let's select the smallest value that
dynamic-power-coefficient can be in DT, which, as it's an integer,
is 1.  We're told that V is in uV, and f is in MHz.  So, let's plug
the figures in:

Pdyn = 1 * (1000000)^2 * 200

That is 2 * 10^14mW, or 200GW.

Somehow, I think the binding documentation is very wrong.

> 
> For the little cluster (A7):
> frequency(MHz)  Voltage(V)  Power(mW)	Dynamic-power-coefficient
>  200		0.9175	     49.470	~2.938*10^-13
>  400		0.9165	     91.892	~2.736*10^-13
>  600		0.9638	    149.454	~2.682*10^-13
>  800		1.0263	    223.453	~2.652*10^-13
> 1000		1.1000	    327.707	~2.708*10^-13
> 1200		1.1725	    445.899	~2.703*10^-13
> 1400		1.2713	    627.010	~2.771*10^-13
> 
> For the big cluster (A15):
> frequency(MHz)  Voltage(V)  Power(mW)	Dynamic-power-coefficient
>  200		0.9162	     159.676	~9.510*10^-13
>  500		0.9138	     325.480	~7.797*10^-13
>  800		0.9288	     511.360	~7.410*10^-13
> 1100		1.0063	     828.020	~7.434*10^-13
> 1400		1.0713	    1209.774	~7.530*10^-13
> 1700		1.1750	    1835.784	~7.822*10^-13
> 2000		1.2700	    2661.849	~8.252*10^-13
> 
> 
> But those values are way off for the DT, unless I multiply the d-p-coefficient with 10^15.
> 
> Assuming the Power value needs to be subtracted by a static component (power usage when idle), the results change as follows:
> 
> For the little cluster (A7):
> frequency(MHz)  Voltage(V)  P-dyn(mW)	Dynamic-power-coefficient
>  200		0.9175	    36,381 	~2,160*10^-13
>  400		0.9165	    73,438	~2,186*10^-13
>  600		0.9638	    122,470	~2,197*10^-13
>  800		1.0263	    184,135	~2,185*10^-13
> 1000		1.1000	    270,425	~2,234*10^-13
> 1200		1.1725	    367,121	~2,225*10^-13
> 1400		1.2713 	    513,989	~2,271*10^-13
> 
> For the big cluster (A15):
> frequency(MHz)  Voltage(V)  P-dyn(mW)	Dynamic-power-coefficient
>  200		0.9162	    99,834 	~5,945*10^-13
>  500		0.9138	    244,651 	~5,860*10^-13
>  800		0.9288	    401,986 	~5,825*10^-13
> 1100		1.0063	    664,565 	~5,966*10^-13
> 1400		1.0713	    985,268	~6,132*10^-13
> 1700		1.1750	    1494,173	~6,366*10^-13
> 2000		1.2700	    2086,273	~6,467*10^-13
> 
> 
> While looking for examples in the kernel that calculate the dynamic-power-coefficient, I found this patch [1] by Caesar Wang that introduced this value for the rk3399 big cluster.
> Unfortunately, I'm unable to reproduce the same results for the coefficient with the given values. My results are also with a 10^-13 factor and even when I scale them with 10^15, my results have a certain margin of error:
> 
> > frequency(MHz)  Voltage(V)  Current(mA) Dynamic-power-coefficient	(My) d-p-coefficient
> > 24              0.8         15			
> > 48              0.8         23          ~417				~598		
> > 96              0.8         40          ~443				~520
> > 216             0.8         82          ~438				~474
> > 312             0.8         115         ~430				~460
> > 408             0.8         150         ~455				~459

Hmm.  Let's take your 48MHz values.

Pdyn (mW) = 0.8 (V) * 23 (mA) = 18.4mW

dynamic-power-coefficient = Pdyn / (V^2 * f)
	= 18.4 (mW) / (800000 * 800000 * 48)
	= 5.99 * 10^-13

Seems, again, to me that there is something very wrong with the
binding documentation.

Now, let's dig into the code:

 * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
 * Return: voltage in micro volt corresponding to the opp, else
 * return 0

So this returns uV.

                voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;

This is mV.

                u32 freq_mhz = freq_table[i].frequency / 1000;

MHz.

                power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
                do_div(power, 1000000000);

                /* power is stored in mW */
                freq_table[i].power = power;

So we have:

	power(mW) = dynamic-power-coefficient * f(MHz) * V(mV)^2 / 10^9

That 10^9 can't come from the fact that the calculation is using mV
instead of uV.  Let's see what happens if we use this:

	dynamic-power-coefficient = power(mW) * 10^9 / (f(MHz) * V(mV)^2)
		= 18.4 * 10^9 / (48 * 800 * 800)
		= 599

which, given that dynamic-power-coefficient is an integer, is a damn
sight more sensible.  This is equivalent to:

	dynamic-power-coefficient = power(mW) * 10^15 / (f(MHz) * V(uV)^2)

which means the binding documentation is wrong.

Now, one of the things to bear in mind is that if you're measuring the
voltage and current, and wanting "dynamic power" then you don't get
that from multiplying the voltage and current - that includes the
_static_ consumption.

	total power = static power + dynamic power
		    = V * (Ileakage + Idynamic)

and Idynamic will be based upon the frequency.

Taking your table:

> > frequency(MHz)  Voltage(V)  Current(mA) dpc    Pdyn Ptot Pstatic
> > 24              0.8         15			
> > 48              0.8         23          ~417   12.8 18.4 5.6
> > 96              0.8         40          ~443   27.2 32   4.8
> > 216             0.8         82          ~438   60.5 65.6 5.1
> > 312             0.8         115         ~430   85.9 92   6.1
> > 408             0.8         150         ~455   119  120  1

Pdyn comes from the dynamic-power-coefficient calculation, Ptot from
the voltage and current figures, and Pstatic being the difference
between Ptot and Pdyn.

Apart from the last, it looks like there's a static power of an average
5.4mW.  Plugging that back in:

	dynamic-power-coefficient = power(mW) * 10^9 / (f(MHz) * V(mV)^2)
		= (18.4 - 5.4) * 10^9 / (48 * 800 * 800)  = 423
		= (32 - 5.4) * 10^9 / (96 * 800 * 800)    = 433
		= (65.6 - 5.4) * 10^9 / (216 * 800 * 800) = 435
		= (92 - 5.4) * 10^9 / (312 * 800 * 800)   = 434
		= (120 - 5.4) * 10^9 / (408 * 800 * 800)  = 439

which is a bit more believable (even compared to the original post
of the table.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
