From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 25 Aug 2017 09:50:07 +0900
Subject: [PATCH 03/14] resource: add walk_system_ram_res_rev()
In-Reply-To: <CAKv+Gu_UfeDf13RPUejVqz0y=QjSCGhPn6fTTCyLWHY=iu-4BA@mail.gmail.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-4-takahiro.akashi@linaro.org>
 <CAKv+Gu_UfeDf13RPUejVqz0y=QjSCGhPn6fTTCyLWHY=iu-4BA@mail.gmail.com>
Message-ID: <20170825005006.GB6434@akashi-kouhiroshi-no-MacBook-Air.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 10:06:28AM +0100, Ard Biesheuvel wrote:
> On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > +       /* create a list */
> > +       rams = vmalloc(sizeof(struct resource) * count);
> > +       if (!rams)
> > +               return ret;
> > +
> > +       res.start = start;
> > +       res.end = end;
> > +       res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +       orig_end = res.end;
> > +       i = 0;
> > +       while ((res.start < res.end) &&
> > +               (!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> > +               if (i >= count) {
> > +                       /* unlikely but */
> > +                       vfree(rams);
> > +                       count += 16;
> 
> If the count is likely to be < 16, why are we using vmalloc() here?

Ah, you're right :)

-Takahiro AKASHI
