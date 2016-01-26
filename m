From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 26 Jan 2016 07:24:44 +0100 (CET)
Subject: [PATCH] media: platform: exynos4-is: media-dev: Add missing
 of_node_put
In-Reply-To: <56A6BCC3.8040407@samsung.com>
References: <20160125152136.GA19484@amitoj-Inspiron-3542>
 <56A6BCC3.8040407@samsung.com>
Message-ID: <alpine.DEB.2.02.1601260723290.2004@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 26 Jan 2016, Krzysztof Kozlowski wrote:

> On 26.01.2016 00:21, Amitoj Kaur Chawla wrote:
> > for_each_available_child_of_node and for_each_child_of_node perform an
> > of_node_get on each iteration, so to break out of the loop an of_node_put is
> > required.
> > 
> > Found using Coccinelle. The simplified version of the semantic patch
> > that is used for this is as follows:
> > 
> > // <smpl>
> > @@
> > local idexpression n;
> > expression e,r;
> > @@
> > 
> >  for_each_available_child_of_node(r,n) {
> >    ...
> > (
> >    of_node_put(n);
> > |
> >    e = n
> > |
> > +  of_node_put(n);
> > ?  break;
> > )
> >    ...
> >  }
> > ... when != n
> > // </smpl>
> 
> Patch iselft looks correct but why are you pasting coccinelle script
> into the message?
> 
> The script is already present in Linux kernel:
> scripts/coccinelle/iterators/device_node_continue.cocci

I don't think so.  The continue one takes care of the case where there is 
an extraneous of_node_put before a continue, not a missing one before a 
break.  But OK to drop it if it doesn't seem useful.

julia

> This just extends the commit message without any meaningful data so with
> removal of coccinelle script above:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Best regards,
> Krzysztof
> 
> > 
> > Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> > ---
> >  drivers/media/platform/exynos4-is/media-dev.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
> > index 4f5586a..09f6e54 100644
> > --- a/drivers/media/platform/exynos4-is/media-dev.c
> > +++ b/drivers/media/platform/exynos4-is/media-dev.c
> > @@ -430,8 +430,10 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
> >  			continue;
> >  
> >  		ret = fimc_md_parse_port_node(fmd, port, index);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(node);
> >  			goto rpm_put;
> > +		}
> >  		index++;
> >  	}
> >  
> > @@ -442,8 +444,10 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
> >  
> >  	for_each_child_of_node(ports, node) {
> >  		ret = fimc_md_parse_port_node(fmd, node, index);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(node);
> >  			break;
> > +		}
> >  		index++;
> >  	}
> >  rpm_put:
> > @@ -651,8 +655,10 @@ static int fimc_md_register_platform_entities(struct fimc_md *fmd,
> >  			ret = fimc_md_register_platform_entity(fmd, pdev,
> >  							plat_entity);
> >  		put_device(&pdev->dev);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(node);
> >  			break;
> > +		}
> >  	}
> >  
> >  	return ret;
> > 
> 
> 
