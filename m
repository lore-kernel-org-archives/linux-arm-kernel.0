From: pc.liao@mediatek.com (PC Liao)
Date: Tue, 29 Mar 2016 21:28:23 +0800
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
In-Reply-To: <20160328191115.GE2350@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
Message-ID: <1459258103.3747.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2016-03-29 at 03:11 +0800, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 11:42:05AM +0800, PC Liao wrote:
> 
> > +Optional properties:
> > +- mediatek,rt5650_i2s: I2S mode of rt5650
> > +  0: using I2S1 on rt5650 for record
> > +  1: using I2S2 on rt5650 for record
> > +
> 
> I would expect the machine driver to have a reference to the DAI that is
> in use rather than a property like this.  This is the way pretty much
> all DT based machine drivers work...

Thanks for comment.
I think I need to comment more clearly.
This setting is different connection from MT8173 to rt5650 on hardware.

- mediatek,rt5650_i2s: I2S mode of rt5650
0: Default setting. Playback and record path use same set of I2S.
Playback/Record path using same I2S clock connect from MT8173 I2S1 to
rt5650 I2S1.
1: Playback and record path use different set of I2S. Playback path
connects from MT8173 I2S1 to rt5650 I2S1 and record path connects from
MT8173 I2S2 to rt5650 I2S2.

Because we use codec ASRC function and need to initialize on different
setting about this parts:
+	switch (mt8173_rt5650_priv.rt5650_i2s) {
+	case MT8173_RT5650_I2S1:
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER |
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+		break;
+	case MT8173_RT5650_I2S2:
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_DA_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S1_ASRC);
+		rt5645_sel_asrc_clk_src(codec,
+					RT5645_AD_STEREO_FILTER,
+					RT5645_CLK_SEL_I2S2_ASRC);
+		break;
+	default:
+		break;
+	}
, we use device tree to determine which connection we choose.
Does this explain can be accepted?
Thanks!
