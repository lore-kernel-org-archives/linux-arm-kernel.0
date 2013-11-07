From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 06 Nov 2013 19:22:16 -0800 (PST)
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <1550251.naXFpxhfMk@avalon>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2775658.fxp7sbhy9u@avalon>
 <8738na1csg.wl%kuninori.morimoto.gx@renesas.com>
 <1550251.naXFpxhfMk@avalon>
Message-ID: <87zjpggalc.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent

> > Now, your [1/3] patch (= for MSTP) added renesas special property
> > as "renesas,clock-indices".
> > Is it impossible to add renesas special property like
> > "renesas,clock-custom-divider" which can specify custom divider values in
> > generic cpg driver ?
> > If we can have it, all Renesas SoC can use generic driver ?
> 
> The clocks supported by the SoC CPG driver are special in the sense that 
> they're not really standardized. Most of them are fixed-factor clocks with a 
> factor that depends on boot mode pins. The others are DIV4 clocks that vary 
> widely from SoC to SoC. Expressing all that information in DT would be much 
> more complex than expressing it in C code, which is why I've decided to go for 
> a per-SoC CPG driver, especially given that the amount of code isn't that 
> large.

In my SuperH experience, CPG clock divier has same pattern.
In H2's SDCKCR register, SDHFC and SD0FC looks different.
But, the real different is only enabled bit area,
the value is same.
You can find same pattern on FRQCRB register too,
and, you can find same pattern on M2.

I guess FRQCRB/SDHFC can share code if it has mask.
This idea was used on R-Mobile series on div4.
(ex clock-sh73a0.c :: div4_clks)

Do you think we can use this idea on DT?
like this ?

	div4_sdh {
                compatible = "renesas,cpg-clocks-1/x";
                renesas,clock-divider-mask = 0xdff;
                ...
	}

Best regards
---
Kuninori Morimoto
