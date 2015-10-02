From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 2 Oct 2015 18:37:00 +0800
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <CAGS+omBQLVGeWrNoD+8L_J0C9DjzkXO_cfph2tQgMGiPBJq2vw@mail.gmail.com>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
 <1443604022.3185.17.camel@pengutronix.de>
 <1443683750.1714.25.camel@mtksdaap41>
 <CAGS+omCpWqtKPKoyjFb=q4BxmfUGGsfvQGEZas8g8VLZKPtKbQ@mail.gmail.com>
 <1443691590.1714.73.camel@mtksdaap41>
 <CAGS+omCm2pKczooGkMf75HjQL=oF7Ufo6DsRCvvikt0QA1jx-g@mail.gmail.com>
 <1443754838.1714.94.camel@mtksdaap41>
 <CAGS+omBQLVGeWrNoD+8L_J0C9DjzkXO_cfph2tQgMGiPBJq2vw@mail.gmail.com>
Message-ID: <1443782220.1714.102.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Daniel,

On Fri, 2015-10-02 at 17:25 +0800, Daniel Kurtz wrote:
> Actually, I should have proposed adding prepare / unprepare callbacks
> to mtk_clk_gate_ops in which we prepare_enable/disable_unprepare
> venc_sel (& mm_sel).
> This should correctly track all of the clk reference counting needed
> to access the venc clock control registers.
> 
> 
> However, this would not actually solve the issue that this patch is
> trying to fix, since nobody would have called the
> prepare_clk(venc_cke0) before clk_disable_unused_subtree(venc_cke0).
> Bummer.

Hmm... it's true.

> I think the crux of the original issue is that the mediatek/clk-gate.c
> is_enabled() callbacks may be called at a point in time when venc_sel
> is disabled but VENC PD is enabled.
> So, perhaps an easier, but still a little hacky way out is to keep the
> clk & PD problems separate, and just check __clk_is_enabled(venc_sel)
> before reading the venc clk status register.
> 
> WDYT?

This may be a way to resolve this issue, but model the prerequisite
clock of subsystem clocks is not straightforward. And once we model the
prerequisite clocks, someone may suggest us to enable prerequisite
clocks before operate subsystem clocks, which may have concerns on
overhead and complexity.

> By the way, I'm not really opposed to your current implementation
> either, I was just helping Matthias & Lucas understand in enough
> detail that they can help review.

I know and many thanks for your suggestion on this patch.


Best regards,

James
