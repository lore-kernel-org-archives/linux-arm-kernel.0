From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 23:07:35 +0200
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <CAD=GYpYwswOYGHRzZ6SeKD+sEfi-7s3HuqKr7G0OXQWFCA_EtQ@mail.gmail.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306242228.23297.arnd@arndb.de>
 <CAD=GYpYwswOYGHRzZ6SeKD+sEfi-7s3HuqKr7G0OXQWFCA_EtQ@mail.gmail.com>
Message-ID: <201306242307.35840.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013, Joel A Fernandes wrote:
> >> Yes sure, right now they are defined  as follows in include/linux/edma.h:
> >>
> >> #if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
> >> bool edma_filter_fn(struct dma_chan *, void *);
> >> #else
> >> static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
> >> {
> >> return false;
> >> }
> >> #endif
> >
> > It's best to just define the filter function in the platform
> > code and pass a pointer to it through platform data. The way you do
> > it above makes the slave drivers inherently nonportable.
> 
> But with DT-only platforms, can you really do that?

The nice thing about this is that with a DT-only platform, the
filter function will automatically go away: you have no
platform_data, which means that if you are using
dma_request_slave_channel_compat, you just pass NULL as the
filter and the filter-data, same as just calling
dma_request_slave_channel.

	Arnd
