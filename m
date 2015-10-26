From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Oct 2015 22:06:23 +0100
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151024104749.179dab64@OPI2>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151023181406.GK10947@lukather> <20151023212013.50bcbe4a@OPI2>
 <20151024071328.GQ10947@lukather> <20151024104749.179dab64@OPI2>
Message-ID: <20151026210623.GB10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 10:47:49AM +0200, Jean-Francois Moine wrote:
> On Sat, 24 Oct 2015 09:13:28 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Or simply
> > 
> > bus_gates {
> > 	clocks = <&ahb1>, <&ahb2>;
> > 	clock-indices = <5>, <6>, <8>, ...
> > 	clock-output-names = "bus_ce", "bus_dma", "bus_mmc0"
> > };
> 
> I don't understand: the apb1, apb2, ahb1 and ahb2 clocks may be
> programmed independently to different frequencies

I don't understand why you're talking about frequencies here.

> and you have to know which of them is the parent of each leaf clock.

Indeed, but that's also doable here. Just not in the DT.

> So, either you hard-code the parents as Jens did in a first proposal,
> or you define the full list of parents in the DT as in the last
> proposal, or you use a container per parent in the DT as I proposed.
> 
> There could be an other solution using the output clock name to define
> the parent clock:
> 
> bus_gates {
> 	clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
> 	clock-indices = <5>, <6>, <8>, ...
> 	clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0"
> };
> 
> with the documentation:
> 
> 	"the clocks MUST be defined in order: ahb1, ahb2, apb1, apb2."
> 
> and the code
> 
> 	if (strncmp(clock_name, "ahb1", 4) == 0)
> 		clk_parent = of_clk_get_parent_name(node, 0);
> 	else if (..)
> 
> but it seems a bit hacky.

It's exactly what I suggested, without the string comparison, but
relying on the ID instead.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151026/ee281511/attachment.sig>
