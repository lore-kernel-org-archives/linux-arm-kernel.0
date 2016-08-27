From: jamesjj.liao@mediatek.com (James Liao)
Date: Sat, 27 Aug 2016 12:21:12 +0800
Subject: [PATCH v12 2/4] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <20160824175049.GC19826@codeaurora.org>
References: <1471854565-19810-1-git-send-email-erin.lo@mediatek.com>
 <1471854565-19810-3-git-send-email-erin.lo@mediatek.com>
 <20160824175049.GC19826@codeaurora.org>
Message-ID: <1472271672.21203.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-24 at 10:50 -0700, Stephen Boyd wrote:
> On 08/22, Erin Lo wrote:
> > diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
> > index 18b4ab5..702fd74 100644
> > --- a/drivers/clk/mediatek/clk-mt2701-hif.c
> > +++ b/drivers/clk/mediatek/clk-mt2701-hif.c
> > @@ -52,11 +52,15 @@ static int mtk_hifsys_init(struct device_node *node)
> >  						clk_data);
> >  
> >  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > -	if (r)
> > +	if (r) {
> >  		pr_err("%s(): could not register clock provider: %d\n",
> >  			__func__, r);
> > +		return r;
> > +	}
> > +
> > +	mtk_register_reset_controller(node, 1, 0x34);
> 
> The cleanup here isn't great. mtk_register_reset_controller()
> should really return an error so that we can properly cleanup if
> needed. Fixing that in a later patch would be a good idea.

Hi Stephen,

I think so. This function returns void because it was invoked in
CLK_OF_DECLARE() in previous SoC's drivers. I'll investigate how to make
it return an error code without breaking backward compatibility.


Best regards,

James
