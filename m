From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Mar 2012 02:07:27 -0600 (MDT)
Subject: [PATCH 5/5] ARM: OMAP2+: clean up some cppcheck warnings
In-Reply-To: <4F5EF2CA.70703@bitmer.com>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224257.4103.11096.stgit@dusk> <4F5EF2CA.70703@bitmer.com>
Message-ID: <alpine.DEB.2.00.1203130154120.22211@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Mar 2012, Jarkko Nikula wrote:

> On 03/13/2012 12:43 AM, Paul Walmsley wrote:
> > Resolve some warnings identified by cppcheck in arch/arm/mach-omap2:
> ...
> >     [arch/arm/mach-omap2/mcbsp.c:133]: (warning) scanf without field width limits can crash with huge input data
> ...
> > diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> > index fb4bcf8..efe59c7 100644
> 
> > --- a/arch/arm/mach-omap2/mcbsp.c
> > +++ b/arch/arm/mach-omap2/mcbsp.c
> > @@ -130,7 +130,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
> >  	struct omap_mcbsp_platform_data *pdata = NULL;
> >  	struct platform_device *pdev;
> >  
> > -	sscanf(oh->name, "mcbsp%d", &id);
> > +	sscanf(oh->name, "mcbsp%1d", &id);
> >  
> Correct if I'm wrong but is this a false alarm? Can %d scan more than
> sizeof(int)?
> 
> Anyway this shouldn't be fatal issue since name comes from kernel
> omap_hwmod data, i.e. only developer can hit it.

Yes, I wasn't too worried about this one.  At the time, I didn't audit the 
kernel sscanf(), so I wasn't sure what its behavior was here. Glancing at 
that code now, it seems to ignore the field width for %d anyway.  So this 
is probably a pointless change that can be dropped from the patch.

Thanks for the review.


- Paul
