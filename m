From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 12 Jul 2016 09:52:01 +0800
Subject: [PATCH v7 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <57839AE3.2070103@gmail.com>
References: <1463390894-32062-1-git-send-email-jamesjj.liao@mediatek.com>
 <1463390894-32062-2-git-send-email-jamesjj.liao@mediatek.com>
 <6762e420-0d68-0376-b584-bfc878b5e95f@gmail.com>
 <1467783564.26485.22.camel@mtksdaap41> <577E3AE9.5080202@gmail.com>
 <1468227390.31247.20.camel@mtksdaap41> <57839AE3.2070103@gmail.com>
Message-ID: <1468288321.21217.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-07-11 at 15:10 +0200, Matthias Brugger wrote:
> 
> On 11/07/16 10:56, James Liao wrote:
> 
> [...]
> 
> >>>>> @@ -467,28 +386,54 @@ static int scpsys_probe(struct platform_device *pdev)
> >>>>>    			if (PTR_ERR(scpd->supply) == -ENODEV)
> >>>>>    				scpd->supply = NULL;
> >>>>>    			else
> >>>>> -				return PTR_ERR(scpd->supply);
> >>>>> +				return ERR_CAST(scpd->supply);
> >>>>>    		}
> >>>>>    	}
> >>>>>
> >>>>> -	pd_data->num_domains = NUM_DOMAINS;
> >>>>> +	pd_data->num_domains = num;
> >>>>>
> >>>>> -	for (i = 0; i < NUM_DOMAINS; i++) {
> >>>>> +	init_clks(pdev, clk);
> >>>>> +
> >>>>> +	for (i = 0; i < num; i++) {
> >>>>>    		struct scp_domain *scpd = &scp->domains[i];
> >>>>>    		struct generic_pm_domain *genpd = &scpd->genpd;
> >>>>>    		const struct scp_domain_data *data = &scp_domain_data[i];
> >>>>>
> >>>>> +		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> >>>>> +			struct clk *c = clk[data->clk_id[j]];
> >>>>> +
> >>>>> +			if (IS_ERR(c)) {
> >>>>> +				dev_err(&pdev->dev, "%s: clk unavailable\n",
> >>>>> +					data->name);
> >>>>> +				return ERR_CAST(c);
> >>>>> +			}
> >>>>> +
> >>>>> +			scpd->clk[j] = c;
> >>>>
> >>>> Put this in the else branch. Apart from that is there any reason you
> >>>
> >>> Do you mean to change like this?
> >>>
> >>> 	if (IS_ERR(c)) {
> >>> 		...
> >>> 		return ERR_CAST(c);
> >>> 	} else {
> >>> 		scpd->clk[j] = c;
> >>> 	}
> >>>
> >>> checkpatch.pl will warn for above code due to it returns in 'if' branch.
> >>>
> >>
> >> I tried that on top of next-20160706 and it checkpatch didn't throw any
> >> warning. Which kernel version are based on?
> >
> > I don't remember which version of checkpatch warn on this pattern. This
> > patch series develop across several kernel versions.
> 
> We as the kernel community develop against master or linux-next. We only 
> care about older kernel version in the sense that we intent hard not to 
> break any userspace/kernel or firmware/kernel interfaces. Apart from 
> that it's up to every individual to backport patches from mainline 
> kernel to his respective version. But that's nothing the community as a 
> hole can take care of.
> 
> >
> > So do you prefer to put "scpd->clk[j] = c;" into 'else' branch?
> >
> 
> Yes please :)


Hi,

I just got next-20160711 and change this chunk to:

+		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
+			struct clk *c = clk[data->clk_id[j]];
+
+			if (IS_ERR(c)) {
+				dev_err(&pdev->dev, "%s: clk unavailable\n",
+					data->name);
+				return ERR_CAST(c);
+			} else {
+				scpd->clk[j] = c;
+			}
+		}
+


and checkpatch give me this warning:

WARNING: else is not generally useful after a break or return
#313: FILE: drivers/soc/mediatek/mtk-scpsys.c:409:
+                               return ERR_CAST(c);
+                       } else {

Joe.C
