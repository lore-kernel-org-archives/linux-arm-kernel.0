From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jun 2018 05:38:05 -0700
Subject: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
In-Reply-To: <20180607233853.p7iw7nlxxuyi66og@kahuna>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <20180607233853.p7iw7nlxxuyi66og@kahuna>
Message-ID: <20180614123805.GF112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some comments on the ranges below.

* Nishanth Menon <nm@ti.com> [180607 16:41]:
> +	soc0: soc0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

I suggest you leave out the soc0, that's not real. Just make
the cbass at 0 the top level interconnect. It can then provide
ranges to mcu interconnect which can provide ranges to the wkup
interconnect. So just model it after what's in the hardware :)

I found the following ranges based on a quick look at the TRM,
they could be split further if needed for power domains for
genpd for example.

main covers
0x0000000000 - 0x5402000000

main provides at least the following ranges for mcu
0x0028380000 - 0x002bc00000
0x0040080000 - 0x0041c80000
0x0045100000 - 0x0045180000
0x0045600000 - 0x0045640000
0x0045810000 - 0x0045860000
0x0045950000 - 0x0045950400
0x0045a50000 - 0x0045a50400
0x0045b04000 - 0x0045b06400
0x0045d10000 - 0x0045d24000
0x0046000000 - 0x0060000000
0x0400000000 - 0x0800000000
0x4c3c020000 - 0x4c3c030000
0x4c3e000000 - 0x4c3e040000
0x5400000000 - 0x5402000000

then mcu provides the following ranges for wkup
0x0042000000 - 0x0044410020
0x0045000000 - 0x0045030000
0x0045080000 - 0x00450a0000
0x0045808000 - 0x0045808800
0x0045b00000 - 0x0045b02400

This based on looking at "figure 1-1. device top-level
block diagram" and the memory map in TRM.

Regards,

Tony
