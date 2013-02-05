From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 5 Feb 2013 10:00:27 +0000
Subject: [PATCH 2/3] mmc: davinci_mmc: add DT support
In-Reply-To: <20130204140616.GB28464@e106331-lin.cambridge.arm.com>
References: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
 <1359628387-14437-3-git-send-email-prakash.pm@ti.com>
 <20130131112303.GA7235@e106331-lin.cambridge.arm.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA46049@DBDE01.ent.ti.com>
 <20130204140616.GB28464@e106331-lin.cambridge.arm.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4618E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Feb 04, 2013 at 19:36:16, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 04, 2013 at 01:28:14PM +0000, Manjunathappa, Prakash wrote:
> > Hi Mark,
> > 
> > On Thu, Jan 31, 2013 at 16:53:03, Mark Rutland wrote:
> > > Hello,
> > >
> > > I have a few comments on the devicetree binding and the way it's parsed.
> > >
> > 
> > Thanks for review.
> > 
> > > On Thu, Jan 31, 2013 at 10:33:06AM +0000, Manjunathappa, Prakash wrote:
> 
> [...]
[...]
> [...]
> 
> > > > @@ -1156,16 +1157,75 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> > > >
> > > >     mmc_davinci_reset_ctrl(host, 0);
> > > >  }
> > > > +#ifdef CONFIG_OF
> > > > +static struct davinci_mmc_config
> > > > +   *mmc_of_get_pdata(struct platform_device *pdev)
> > > > +{
> > > > +   struct device_node *np;
> > > > +   struct davinci_mmc_config *pdata = NULL;
> > > > +   u32 data;
> > > > +   int ret;
> > > > +
> > > > +   pdata = pdev->dev.platform_data;
> > > > +   if (!pdata) {
> > > > +           pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> > > > +           if (!pdata) {
> > > > +                   dev_err(&pdev->dev, "Failed to allocate memory for struct davinci_mmc_config\n");
> > > > +                   goto nodata;
> > > > +           }
> > > > +   }
> > >
> > > Why do you need to conditionally allocate this? This only seems to be called
> > > once.
> > >
> > 
> > This is common function for DT and non-DT kernel(will be removing #ifdef CONFIG_OF),
> > So above check is necessary for to allocate pdata for DT kernel.
> 
> Ah. Am I right in thinking if you moved the check for pdev->dev.of_node above
> the pdata allocation, it wouldn't have to be done conditionally?
> 

Agreed. Will move below check up.

> > 
> > > > +
> > > > +   np = pdev->dev.of_node;
> > > > +   if (!np)
> > > > +           goto nodata;
> > >
> > > Why not just return immediately here? You do nothing special at nodata.
> > >
> > 
> > Following convention to not have more than 1 return from function and have
> > Common exit point. May not be necessary now since we have devm_* calls now.
> > Can I still prefer to keep this goto?
> 
> It just looks a little odd to me. I have no strong feelings here.
> 
> [...]
> 

After considering your inputs on moving above statement up, "return" makes sense.

Thanks,
Prakash

[...]
