From: nm@ti.com (Nishanth Menon)
Date: Thu, 14 Jun 2018 08:04:35 -0500
Subject: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
In-Reply-To: <20180614123805.GF112168@atomide.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <20180607233853.p7iw7nlxxuyi66og@kahuna>
 <20180614123805.GF112168@atomide.com>
Message-ID: <20180614130435.j2bmzam6corrjylx@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:38-20180614, Tony Lindgren wrote:
> Some comments on the ranges below.

Thanks for reviewing in detail (I understand we are in the middle of
merge window, so thanks for the extra effort).

> 
> * Nishanth Menon <nm@ti.com> [180607 16:41]:
> > +	soc0: soc0 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> 
> I suggest you leave out the soc0, that's not real. Just make

Why is that so, on a more complex board representation with multiple
SoCs, this is a clear node indicating what the main SoC is in the final
dtb representation.

> the cbass at 0 the top level interconnect. It can then provide
> ranges to mcu interconnect which can provide ranges to the wkup
> interconnect. So just model it after what's in the hardware :)

That might blow up things quite a bit - it is like the comment in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/dra7.dtsi#n141

The trees are pretty deep with many interconnections (example main does
have direct connections to wkup as well, which is simplified off in
top level diagram) - basically it is not a direct one dimensional
relationship. But then, the same is the case for other SoCs..

we can represent NAVSS as a bus segment as well.

> 
> I found the following ranges based on a quick look at the TRM,
> they could be split further if needed for power domains for
> genpd for example.

genpd is not really an issue, since it is handled in system firmware and
OSes dont have a visibility into the permitted ranges that the OS is
allowed to use.

I think it is just how accurate a representation is it worth.

> 
> main covers
> 0x0000000000 - 0x5402000000
> 
> main provides at least the following ranges for mcu
> 0x0028380000 - 0x002bc00000
> 0x0040080000 - 0x0041c80000
> 0x0045100000 - 0x0045180000
> 0x0045600000 - 0x0045640000
> 0x0045810000 - 0x0045860000
> 0x0045950000 - 0x0045950400
> 0x0045a50000 - 0x0045a50400
> 0x0045b04000 - 0x0045b06400
> 0x0045d10000 - 0x0045d24000
> 0x0046000000 - 0x0060000000
> 0x0400000000 - 0x0800000000
> 0x4c3c020000 - 0x4c3c030000
> 0x4c3e000000 - 0x4c3e040000
> 0x5400000000 - 0x5402000000
> 
> then mcu provides the following ranges for wkup
> 0x0042000000 - 0x0044410020
> 0x0045000000 - 0x0045030000
> 0x0045080000 - 0x00450a0000
> 0x0045808000 - 0x0045808800
> 0x0045b00000 - 0x0045b02400
> 
> This based on looking at "figure 1-1. device top-level
> block diagram" and the memory map in TRM.

Thanks for researching. I did debate something like:

>From A53 view, a more accurate view might be  - from an interconnect
view of the world (still simplified - i have ignored the sub bus
segments in the representations below):

msmc {
	navss_main {
		cbass_main{
			cbass_mcu {
				navss_mcu {
				};
				cbass_wkup{
				};
			};
		};
	};
};

>From R5 view, the view will be very different ofcourse:
view of the world (still simplified):

cbass_mcu {
	navss_mcu {
	};
	cbass_wkup{
	};
	cbass_main{
		navss_main {
			msmc {
			};
		};
	};
};


Do we really need this level of representation, I am not sure I had seen
this detailed a representation in other aarch64 SoCs (I am sure they are
as complex as TI SoCs as well).

I am trying to understand the direction and logic why we'd want to have
such a detailed representation.

A more flatter representation of just the main segments allow for dts
reuse between r5 and a53 as well (but that is minor).


Thoughts?
-- 
Regards,
Nishanth Menon
