From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Jan 2015 09:40:10 +0100
Subject: [PATCH v3 2/4] of: move of_dma_configure() to device,
 c to help re-use
In-Reply-To: <CAL_Jsq+pKeXuGnZV_NYHn6iZgeOs404OPhcUb0FJs=-7j2P1Ug@mail.gmail.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com>
 <1420656594-8908-3-git-send-email-m-karicheri2@ti.com>
 <CAL_Jsq+pKeXuGnZV_NYHn6iZgeOs404OPhcUb0FJs=-7j2P1Ug@mail.gmail.com>
Message-ID: <3861625.CJ6m15sZMh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 17:37:56 Rob Herring wrote:
> On Wed, Jan 7, 2015 at 12:49 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> 
> > +       ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> > +       if (ret < 0) {
> > +               dma_addr = offset = 0;
> > +               size = dev->coherent_dma_mask + 1;
> 
> If coherent_dma_mask is DMA_BIT_MASK(64), then you will overflow and
> have a size of 0. There may also be a problem when the mask is only
> 32-bit type.

The mask is always a 64-bit type, it's not optional. But you are right,
the 64-bit mask case is broken, so I guess we have to fix it differently
by always passing the smaller value into arch_setup_dma_ops and
adapting that function instead.

	Arnd
