From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Oct 2010 00:00:35 +0900
Subject: [PATCH 4/7] ARM: oprofile: Move non-ARM code into separate
	init/exit
In-Reply-To: <20101006145903.GR13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<74092b0d162aafc21e408033cec6146e227363b5.1286222593.git.matt@console-pimps.org>
	<20101006133309.GP13563@erda.amd.com>
	<20101006144921.GQ13563@erda.amd.com>
	<20101006145311.GA3754@linux-sh.org>
	<20101006145903.GR13563@erda.amd.com>
Message-ID: <20101006150035.GB3754@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 04:59:03PM +0200, Robert Richter wrote:
> On 06.10.10 10:53:11, Paul Mundt wrote:
> > On Wed, Oct 06, 2010 at 04:49:21PM +0200, Robert Richter wrote:
> > > On 06.10.10 15:33:09, Robert Richter wrote:
> > > > On 04.10.10 16:44:22, Matt Fleming wrote:
> > > > > -void __exit oprofile_arch_exit(void)
> > > > > +int __init oprofile_arch_init(struct oprofile_operations *ops)
> > > > > +{
> > > > 
> > > > We should do here a:
> > > > 
> > > > 	memset(ops, 0, sizeof(*ops));
> > > 
> > > Matt,
> > > 
> > > an alternative would be to move this to oprofile_perf_init() and
> > > modify ops->backtrace afterwards, but then we will lose the function's
> > > tail call. Not sure that is better. Paul, what do you think?
> > > 
> > I'm a bit confused as to why we just don't do:
> > 
> > ---
> > 
> > diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
> > index b336cd9..76d97a5 100644
> > --- a/drivers/oprofile/oprof.c
> > +++ b/drivers/oprofile/oprof.c
> > @@ -252,6 +252,8 @@ static int __init oprofile_init(void)
> >  {
> >  	int err;
> >  
> > +	memset(&oprofile_ops, 0, sizeof(struct oprofile_operations));
> > +
> 
> Yes, this looks much better. Thanks Paul.
> 
> 
In which case, if you want to take it:

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
