From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 23 Jul 2018 17:29:56 +0200
Subject: [Eas-dev] Computing the dynamic-power-coefficient on Exynos5422
In-Reply-To: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
References: <8966420ddb4d4f40bbbc44b58da2881b@MSX-L106.msx.ad.zih.tu-dresden.de>
Message-ID: <d3d0ab5e-4841-6e21-ed0a-8a73486ba927@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

On 07/20/2018 04:15 PM, Oliver Effland wrote:
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
> 
> For the little cluster (A7):
> frequency(MHz)  Voltage(V)  Power(mW)	Dynamic-power-coefficient
>   200		0.9175	     49.470	~2.938*10^-13
>   400		0.9165	     91.892	~2.736*10^-13
>   600		0.9638	    149.454	~2.682*10^-13
>   800		1.0263	    223.453	~2.652*10^-13
> 1000		1.1000	    327.707	~2.708*10^-13
> 1200		1.1725	    445.899	~2.703*10^-13
> 1400		1.2713	    627.010	~2.771*10^-13
> 
> For the big cluster (A15):
> frequency(MHz)  Voltage(V)  Power(mW)	Dynamic-power-coefficient
>   200		0.9162	     159.676	~9.510*10^-13
>   500		0.9138	     325.480	~7.797*10^-13
>   800		0.9288	     511.360	~7.410*10^-13
> 1100		1.0063	     828.020	~7.434*10^-13
> 1400		1.0713	    1209.774	~7.530*10^-13
> 1700		1.1750	    1835.784	~7.822*10^-13
> 2000		1.2700	    2661.849	~8.252*10^-13

We do support Arm's TC2 platform (2xA15 and 3xA7) with the EAS project. 
The latest EAS mainline integration includes Quentin's "[RFC PATCH v4 
00/12] Energy Aware Scheduling" https://lkml.org/lkml/2018/6/28/301 .

You can find the appropriate patch for TC2 dynamic-power-coefficient 
integration "arm: dts: vexpress-v2p-ca15_a7: Add 
dynamic-power-coefficient properties" under 
https://developer.arm.com/open-source/energy-aware-scheduling/eas-mainline-development 
. Follow the 'eas/next/integration' link. The patch header has a little 
bit of documentation about how we did it. We used the build-in TC2 
Energy Meter.

This is all in sync with what Russel and Steve posted on this thread before.

Thanks for taking EAS for a spin on another Arm 32bit machine!

-- Dietmar

[...]
