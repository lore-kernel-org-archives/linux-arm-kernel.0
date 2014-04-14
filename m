From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Apr 2014 18:00:04 +0200
Subject: [PATCH] pata_arasan_cf: fix ata_host_activate() failure handling
In-Reply-To: <CAOh2x=n8PGuykczfpi0T1-WwVmakURyX+RuuOQiFVhpYPmrS6A@mail.gmail.com>
References: <7093981.6c4k98qyGh@amdc1032>
 <CAOh2x=n8PGuykczfpi0T1-WwVmakURyX+RuuOQiFVhpYPmrS6A@mail.gmail.com>
Message-ID: <1861056.i4MLEJ6v1d@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, April 01, 2014 09:50:42 AM Viresh Kumar wrote:
> On Mon, Mar 31, 2014 at 11:19 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Add missing cf_exit() and clk_put() calls to ata_host_activate()
> > failure path.
> >
> > Cc: Viresh Kumar <viresh.linux@gmail.com>
> > Cc: Shiraz Hashim <shiraz.hashim@st.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/ata/pata_arasan_cf.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > Index: b/drivers/ata/pata_arasan_cf.c
> > ===================================================================
> > --- a/drivers/ata/pata_arasan_cf.c      2014-03-31 16:57:47.443727785 +0200
> > +++ b/drivers/ata/pata_arasan_cf.c      2014-03-31 17:09:48.171715498 +0200
> > @@ -898,9 +898,15 @@ static int arasan_cf_probe(struct platfo
> >
> >         cf_card_detect(acdev, 0);
> >
> > -       return ata_host_activate(host, acdev->irq, irq_handler, 0,
> > -                       &arasan_cf_sht);
> > +       ret = ata_host_activate(host, acdev->irq, irq_handler, 0,
> > +                               &arasan_cf_sht);
> > +       if (ret)
> > +               goto exit_cf;
> >
> > +       return 0;
> 
> Probably this would be better:
> 
> if (!ret)
>     return 0
> 
> and then no need of a goto..

I considered doing it this way initially but decided that code consistency
with other host drivers is more important.  However if this is what you
prefer I'll re-do the patch and post it as v2.

> > +
> > +exit_cf:
> > +       cf_exit(acdev);
> >  free_clk:
> >         clk_put(acdev->clk);
> >         return ret;
> >

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
