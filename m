From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Mon, 15 Sep 2014 19:58:56 +0800
Subject: [PATCH V1 1/3] ARM: clk-imx6sl: refine clock tree for SSI
In-Reply-To: <CAOMZO5DJZHKAV4Y9aUwMNWZqhoLrKrsZdYnKqPem2ZSy=-oAYw@mail.gmail.com>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
 <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
 <CAOMZO5A4FLbA_+u4oMTqgAY69DaF93V=oLiy+op=tEHbagF1pg@mail.gmail.com>
 <CAOMZO5DJZHKAV4Y9aUwMNWZqhoLrKrsZdYnKqPem2ZSy=-oAYw@mail.gmail.com>
Message-ID: <20140915115855.GC23877@audiosh1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi fabio, shawn.

On Fri, Sep 12, 2014 at 01:43:39PM -0300, Fabio Estevam wrote:
> On Fri, Sep 12, 2014 at 1:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Tue, Sep 9, 2014 at 6:13 AM, Shengjiu Wang
> > <shengjiu.wang@freescale.com> wrote:
> >> Each SSI has "ssi", "ssi_ipg" clocks, and they share same gate bits.
> >>
> >> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> >
> > This patch breaks audio playback on imx6q-sabresd:
> >
> > root at freescale /$ aplay /home/clarinet.wav
> > Playing WAVE '/home/clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> > Mono
> > underrun!!! (at least -1585992.581 ms long)
> > underrun!!! (at least -1585992.585 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> > underrun!!! (at least -1585992.586 ms long)
> >
> > If I revert this commit, then I am able to play it well again.
> 
> Ops, I replied in the wrong patch.
> 
> The one that breaks imx6q-sabresd is:
> 
>    commit 48e1c2255 "ARM: clk-imx6q: refine clock tree for SSI"

I add IMX6QDL_CLK_SSIx in this patch, which use share count with 
IMX6QDL_CLK_SSIx_IPG. The SSI driver sound/soc/fsl/fsl_ssi.c will enable
IMX6QDL_CLK_SSIx_IPG clock in probe, but don't disable it. In the end of kernel
boot up, some one(it is not ssi driver, maybe is the clock tree) will disable
the IMX6QDL_CLK_SSIx clock, which is not enabled. IMX6QDL_CLK_SSIx_IPG share
the enable/disable bit with IMX6QDL_CLK_SSIx, So IMX6QDL_CLK_SSIx_IPG is 
disabled, the aplay will fail.

Is this the issue of imx_clk_gate2_shared()? When we want to disable IMX6QDL_CLK_SSIx,
but IMX6QDL_CLK_SSIx_IPG is enabled, can IMX6QDL_CLK_SSIx be disabled?


Shawn

   How do you think about this?

best regards
wang shengjiu
