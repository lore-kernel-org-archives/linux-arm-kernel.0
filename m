From: viktorin@rehivetech.com (Jan Viktorin)
Date: Fri, 15 Jul 2016 14:02:08 +0200
Subject: [PATCH 5/8] uio: fix dmem_region_start computation
In-Reply-To: <20160715113224.GA26029@kroah.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
 <1468573443-4670-6-git-send-email-anup.patel@broadcom.com>
 <20160715113224.GA26029@kroah.com>
Message-ID: <20160715140208.49d020f3@pcviktorin.fit.vutbr.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jul 2016 20:32:24 +0900
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Jul 15, 2016 at 02:34:00PM +0530, Anup Patel wrote:
> > From: Jan Viktorin <viktorin@rehivetech.com>
> > 
> > The variable i contains a total number of resources (including
> > IORESOURCE_IRQ). However, we want the dmem_region_start to point
> > after the last resource of type IORESOURCE_MEM. The original behaviour
> > leads (very likely) to skipping several UIO mapping regions and makes
> > them useless. Fix this by computing dmem_region_start from the uiomem
> > which points to the last used UIO mapping.
> > 
> > Fixes: 0a0c3b5a24bd ("Add new uio device for dynamic memory allocation")
> > 
> > Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
> > ---
> >  drivers/uio/uio_dmem_genirq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Why isn't this patch first in the series, with a stable marking, and
> your signed off on it (you are forwarding it on to me, so you need to
> add your mark to it as well, I can't take it otherwise.)
> 
> > diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
> > index 915facb..e1134a4 100644
> > --- a/drivers/uio/uio_dmem_genirq.c
> > +++ b/drivers/uio/uio_dmem_genirq.c
> > @@ -229,7 +229,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
> >  		++uiomem;
> >  	}
> >  
> > -	priv->dmem_region_start = i;
> > +	priv->dmem_region_start = uiomem - &uioinfo->mem[0];  
> 
> Are you sure about this?  It doesn't look correct at first glance, I'm

The loop over resources counts all resources in _i_ and mem resources in _uiomem_
pointer. Thus, the dmem_region_start cannot be derived from _i_ but from _uiomem_.

> loath to take this without a bunch of testing.  Were you able to test
> this out to verify it doesn't break working hardware?

This is a good point, however, what is the working hardware? I could not find
any application of the uio_dmem_genirq anywhere online. Any example, nothing.

I am afraid that nobody is using more then 1 memory resource with this driver
and so nobody could discover this to be a bug. I was working with more then 2
resources.

I'd be glad if somebody else can test it on any other working setup.

Regards
Jan

> 
> thanks,
> 
> greg k-h
