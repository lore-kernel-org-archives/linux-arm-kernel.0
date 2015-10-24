From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 24 Oct 2015 10:47:49 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151024071328.GQ10947@lukather>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151023181406.GK10947@lukather> <20151023212013.50bcbe4a@OPI2>
 <20151024071328.GQ10947@lukather>
Message-ID: <20151024104749.179dab64@OPI2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Oct 2015 09:13:28 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Or simply
> 
> bus_gates {
> 	clocks = <&ahb1>, <&ahb2>;
> 	clock-indices = <5>, <6>, <8>, ...
> 	clock-output-names = "bus_ce", "bus_dma", "bus_mmc0"
> };

I don't understand: the apb1, apb2, ahb1 and ahb2 clocks may be
programmed independently to different frequencies and you have to know
which of them is the parent of each leaf clock.

So, either you hard-code the parents as Jens did in a first proposal,
or you define the full list of parents in the DT as in the last
proposal, or you use a container per parent in the DT as I proposed.

There could be an other solution using the output clock name to define
the parent clock:

bus_gates {
	clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
	clock-indices = <5>, <6>, <8>, ...
	clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0"
};

with the documentation:

	"the clocks MUST be defined in order: ahb1, ahb2, apb1, apb2."

and the code

	if (strncmp(clock_name, "ahb1", 4) == 0)
		clk_parent = of_clk_get_parent_name(node, 0);
	else if (..)

but it seems a bit hacky.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
