From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Apr 2015 11:56:38 +0200
Subject: [PATCH v3] dmaengine: xgene-dma: Fix sparse wannings and
 coccinelle warnings
In-Reply-To: <CAFd313widYjOzLbKd=BantviCK9O4ZhwN92QuZgipng2A0Ys0w@mail.gmail.com>
References: <1429212673-22254-1-git-send-email-rsahu@apm.com>
 <2380806.YAnOxsf686@wuerfel>
 <CAFd313widYjOzLbKd=BantviCK9O4ZhwN92QuZgipng2A0Ys0w@mail.gmail.com>
Message-ID: <3598557.qxzZhd2MFW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 April 2015 14:41:02 Rameshwar Sahu wrote:
> >>
> >> -static void *xgene_dma_lookup_ext8(u64 *desc, int idx)
> >> +static __le64 *xgene_dma_lookup_ext8(struct xgene_dma_desc_hw *desc, int idx)
> >>  {
> >> -     return (idx % 2) ? (desc + idx - 1) : (desc + idx + 1);
> >> +     switch (idx) {
> >> +     case 0:
> >> +             return &desc->m1;
> >> +     case 1:
> >> +             return &desc->m0;
> >> +     case 2:
> >> +             return &desc->m3;
> >> +     case 3:
> >> +             return &desc->m2;
> >> +     default:
> >> +             pr_err("Invalid dma descriptor index\n");
> >> +     }
> >> +
> >> +     return NULL;
> >>  }
> >>
> > ...
> >
> >>       /* Set 1st to 5th source addresses */
> >>       for (i = 0; i < src_cnt; i++) {
> >>               len = *nbytes;
> >> -             xgene_dma_set_src_buffer((i == 0) ? (desc1 + 8) :
> >> +             xgene_dma_set_src_buffer((i == 0) ? &desc1->m1 :
> >>                                        xgene_dma_lookup_ext8(desc2, i - 1),
> >>                                        &len, &src[i]);
> >> -             XGENE_DMA_DESC_MULTI_SET(desc1, scf[i], i);
> >> +             desc1->m2 |= cpu_to_le64((scf[i] << ((i + 1) * 8)));
> >>       }
> >
> > If you just unroll this loop, you get code that is smaller and easier to
> > understand:
> >
> >         /* Set 1st to 5th source addresses */
> >         xgene_dma_set_src_buffer(&desc1->m1, &len, &src[0]);
> >         xgene_dma_set_src_buffer(&desc2->m0, &len, &src[1]);
> >         xgene_dma_set_src_buffer(&desc2->m3, &len, &src[2]);
> >         xgene_dma_set_src_buffer(&desc2->m2, &len, &src[3]);
> >         desc1->m2 |= cpu_to_le64(scf[0] | scf[1] << 8 | scf[2] << 16 | scf[3] << 24);
> 
> Actually here, in run time src_cnt value can be 2 or 3 upto 5, so we
> can't unroll it.

I see, sorry for misreading the code. The patch is good then as it is.

	Arnd
