From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 17:19:01 -0700
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <1429735986-18592-1-git-send-email-heiko@sntech.de>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
Message-ID: <20150501001901.GC32407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22, Heiko Stuebner wrote:
> Using orphan clocks can introduce strange behaviour as they don't have
> rate information at all and also of course don't track 
> 
> This v2/v3 takes into account suggestions from Stephen Boyd to not try to
> walk the clock tree at runtime but instead keep track of orphan states
> on clock tree changes and making it mandatory for everybody from the
> start as orphaned clocks should not be used at all.
> 
> 
> This fixes an issue on most rk3288 platforms, where some soc-clocks
> are supplied by a 32khz clock from an external i2c-chip which often
> is only probed later in the boot process and maybe even after the
> drivers using these soc-clocks like the tsadc temperature sensor.
> In this case the driver using the clock should of course defer probing
> until the clock is actually usable.
> 
> 
> As this changes the behaviour for orphan clocks, it would of course
> benefit from more testing than on my Rockchip boards. To keep the
> recipent-list reasonable and not spam to much I selected one (the topmost)
> from the get_maintainer output of each drivers/clk entry.
> Hopefully some will provide Tested-by-tags :-)
> 

<grumble> I don't see any Tested-by: tags yet </grumble>. I've
put these two patches on a separate branch "defer-orphans" and
pushed it to clk-next so we can give it some more exposure.

Unfortunately this doesn't solve the orphan problem for non-OF
providers. What if we did the orphan check in __clk_create_clk()
instead and returned an error pointer for orphans? I suspect that
will solve all cases, right?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
