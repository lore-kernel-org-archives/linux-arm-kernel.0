From: jdelvare@suse.de (Jean Delvare)
Date: Thu, 19 Feb 2015 09:09:17 +0100
Subject: [PATCH v5 59/61] dmaengine: Add a warning for drivers not using
 the generic slave caps retrieval
In-Reply-To: <CAOh2x=n1SC+s3hyFaOpREwVuzvqDUwb5vsTBN0As+O2h6eXbMw@mail.gmail.com>
References: <1416231775-31252-1-git-send-email-maxime.ripard@free-electrons.com>
 <1416231775-31252-60-git-send-email-maxime.ripard@free-electrons.com>
 <CAOh2x=n1SC+s3hyFaOpREwVuzvqDUwb5vsTBN0As+O2h6eXbMw@mail.gmail.com>
Message-ID: <20150219090917.159d3d2f@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Thu, 19 Feb 2015 15:57:27 +0800, Viresh Kumar wrote:
> On Mon, Nov 17, 2014 at 9:42 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > For the slave caps retrieval to be really useful, most drivers need to
> > implement it.
> >
> > Hence, we need to be slightly more aggressive, and trigger a warning at
> > registration time for drivers that don't fill their caps infos in order to
> > encourage them to implement it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/dma/dmaengine.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 98e9431f85ec..300c8cd2786c 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -827,6 +827,9 @@ int dma_async_device_register(struct dma_device *device)
> >         BUG_ON(!device->device_issue_pending);
> >         BUG_ON(!device->dev);
> >
> > +       WARN(dma_has_cap(DMA_SLAVE, device->cap_mask) && !device->directions,
> > +            "this driver doesn't support generic slave capabilities reporting\n");
> > +
> >         /* note: this only matters in the
> >          * CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=n case
> >          */
> 
> Probably you need to fix this ?
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=90801

My understanding is that the warning message is here on purpose to
instruct DMA driver authors to fix their code. So if anyone need to fix
anything, that would be you and Andy. That being said, I suspect Andy
already did that:

commit 029a40e97d0db269f4a7fc02b0f29f627f628309
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Jan 2 16:17:24 2015 +0200

    dmaengine: dw: provide DMA capabilities
    
Brian, can you please try the latest Linus or linux-next kernel (or
backport the above commit to your current kernel) and confirm that the
backtraces are no longer printed?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
