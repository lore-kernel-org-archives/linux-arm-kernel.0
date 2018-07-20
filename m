From: s5770874@msx.tu-dresden.de (Oliver Effland)
Date: Fri, 20 Jul 2018 16:15:30 +0200
Subject: Computing the dynamic-power-coefficient on Exynos5422
Message-ID: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I hope this is the right place to ask, otherwise please just point me in the right direction.

I'm currently testing the EAS patches [v4] on an ODROID-XU3 board, which has an Exynos5422 SoC. However, the corresponding DT is missing the "dynamic-power-coefficient" that is needed for an appropriate EM.
So I'm trying to compute the dynamic-power-coefficient according to the formula:

Pdyn = dynamic-power-coefficient * V^2 * f

The frequency f is given by the DT.The actual Voltage and Power are determined by means of the on-chip sensors (returns the values for the specific cluster). When using the Voltage given in the DT, the differences for the d-p-coefficient are negligible.

So I'm calculating the d-p-coefficient (mW/MHz/uV^2) by reading out the following SoC sensor values.

For the little cluster (A7):
frequency(MHz)  Voltage(V)  Power(mW)	Dynamic-power-coefficient
 200		0.9175	     49.470	~2.938*10^-13
 400		0.9165	     91.892	~2.736*10^-13
 600		0.9638	    149.454	~2.682*10^-13
 800		1.0263	    223.453	~2.652*10^-13
1000		1.1000	    327.707	~2.708*10^-13
1200		1.1725	    445.899	~2.703*10^-13
1400		1.2713	    627.010	~2.771*10^-13

For the big cluster (A15):
frequency(MHz)  Voltage(V)  Power(mW)	Dynamic-power-coefficient
 200		0.9162	     159.676	~9.510*10^-13
 500		0.9138	     325.480	~7.797*10^-13
 800		0.9288	     511.360	~7.410*10^-13
1100		1.0063	     828.020	~7.434*10^-13
1400		1.0713	    1209.774	~7.530*10^-13
1700		1.1750	    1835.784	~7.822*10^-13
2000		1.2700	    2661.849	~8.252*10^-13


But those values are way off for the DT, unless I multiply the d-p-coefficient with 10^15.

Assuming the Power value needs to be subtracted by a static component (power usage when idle), the results change as follows:

For the little cluster (A7):
frequency(MHz)  Voltage(V)  P-dyn(mW)	Dynamic-power-coefficient
 200		0.9175	    36,381 	~2,160*10^-13
 400		0.9165	    73,438	~2,186*10^-13
 600		0.9638	    122,470	~2,197*10^-13
 800		1.0263	    184,135	~2,185*10^-13
1000		1.1000	    270,425	~2,234*10^-13
1200		1.1725	    367,121	~2,225*10^-13
1400		1.2713 	    513,989	~2,271*10^-13

For the big cluster (A15):
frequency(MHz)  Voltage(V)  P-dyn(mW)	Dynamic-power-coefficient
 200		0.9162	    99,834 	~5,945*10^-13
 500		0.9138	    244,651 	~5,860*10^-13
 800		0.9288	    401,986 	~5,825*10^-13
1100		1.0063	    664,565 	~5,966*10^-13
1400		1.0713	    985,268	~6,132*10^-13
1700		1.1750	    1494,173	~6,366*10^-13
2000		1.2700	    2086,273	~6,467*10^-13


While looking for examples in the kernel that calculate the dynamic-power-coefficient, I found this patch [1] by Caesar Wang that introduced this value for the rk3399 big cluster.
Unfortunately, I'm unable to reproduce the same results for the coefficient with the given values. My results are also with a 10^-13 factor and even when I scale them with 10^15, my results have a certain margin of error:

> frequency(MHz)  Voltage(V)  Current(mA) Dynamic-power-coefficient	(My) d-p-coefficient
> 24              0.8         15			
> 48              0.8         23          ~417				~598		
> 96              0.8         40          ~443				~520
> 216             0.8         82          ~438				~474
> 312             0.8         115         ~430				~460
> 408             0.8         150         ~455				~459


Is this the right approach, or am I missing something?
Hope someone can help me out.

Thanks in advance,
Oliver Effland

[1] https://patchwork.kernel.org/patch/9861505/
