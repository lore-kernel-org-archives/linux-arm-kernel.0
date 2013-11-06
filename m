From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Nov 2013 13:41:09 +0100
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <8738na1csg.wl%kuninori.morimoto.gx@renesas.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2775658.fxp7sbhy9u@avalon> <8738na1csg.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <1550251.naXFpxhfMk@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

On Tuesday 05 November 2013 18:31:31 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > Please correct me if my understanding was wrong.
> > > Does your "of_clk_get_parent_name()" means "case R8A7790_CLK_MAIN"'s one
> > > ?
> > > If Yes, it is needed on "parent" clock side, not here ?
> > > If No,  who need/call of_clk_get_parent_name() for this ?
> > > does "qspi", "sdh", "sd0", "sd1" can be parent clock for some device ??
> > 
> > All those clocks are parents of other clocks (DIV6, MSTP or fixed-factor
> > clocks). The DIV6, MSTP and fixed-factor clock drivers call
> > of_clk_get_parent_name() to get the name of their parent clock, which is
> > required to register the clocks with CCF. See of_fixed_factor_clk_setup()
> > for instance.
> 
> Ahh... OK, I understand.
> 
> Hmm...
> I guesss We can use [1/3] and [2/3] patches for all Renesas SoC as generic
> driver, but, all SoC needs clk/shmobile/clk-xxxx.c like [3/3].
> Because it has SoC special divider values.
> Is this correct ?

That's correct.

> Now, your [1/3] patch (= for MSTP) added renesas special property
> as "renesas,clock-indices".
> Is it impossible to add renesas special property like
> "renesas,clock-custom-divider" which can specify custom divider values in
> generic cpg driver ?
> If we can have it, all Renesas SoC can use generic driver ?

The clocks supported by the SoC CPG driver are special in the sense that 
they're not really standardized. Most of them are fixed-factor clocks with a 
factor that depends on boot mode pins. The others are DIV4 clocks that vary 
widely from SoC to SoC. Expressing all that information in DT would be much 
more complex than expressing it in C code, which is why I've decided to go for 
a per-SoC CPG driver, especially given that the amount of code isn't that 
large.

-- 
Regards,

Laurent Pinchart
