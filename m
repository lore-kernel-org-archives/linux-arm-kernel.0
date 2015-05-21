From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 21 May 2015 22:49:38 +0800
Subject: [PATCH v2 4/6] soc: mediatek: Add SMI driver
In-Reply-To: <CAGS+omARc60i+8vO6V1ccnSnXkjAGNjMjRB1+5kg_EHrrS1NOw@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
 <1431683009-18158-5-git-send-email-yong.wu@mediatek.com>
 <CABuKBeJvh2PGi3i6O0uu-7ggdBzKMb3tPE_XKhT1i-+tkKc5gg@mail.gmail.com>
 <1432188990.5092.12.camel@mhfsdcap03>
 <CABuKBe+FmAzr_Cu=fUDwDHYzH4mW_2p4z1SYmp7+W=Tu-MLEuA@mail.gmail.com>
 <CAGS+omARc60i+8vO6V1ccnSnXkjAGNjMjRB1+5kg_EHrrS1NOw@mail.gmail.com>
Message-ID: <1432219778.5092.44.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-21 at 22:33 +0800, Daniel Kurtz wrote:
> On Thu, May 21, 2015 at 3:30 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> > 2015-05-21 8:16 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> >> Hi Matthias,
> >>      Thanks very much for your suggestion.
> >>      Abort the smi clock name, Could you help check below.
> >>      The others I will improve in next time.
> >>
> >> On Tue, 2015-05-19 at 13:14 +0200, Matthias Brugger wrote:
> >>> 2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> >>> >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> >>> > responsible to enable/disable iommu and control the clocks of each local arbiter.
> >>> >
> >> [snip]
> >>> > +
> >>> > +#define SMI_LARB_MMU_EN                (0xf00)
> >>> > +#define F_SMI_MMU_EN(port)     (1 << (port))
> >>> > +
> >>> > +enum {
> >>> > +       MTK_CLK_APB,
> >>> > +       MTK_CLK_SMI,
> >>> > +       MTK_CLK_MAX,
> >>>
> >>> Maybe add something like:
> >>> MTK_CLK_FIRST = MTK_CLK_APB,
> >>> to make the for loops better readable.
> >>>
> >> Then, Is it like this? :
> >>  enum {
> >>         MTK_CLK_FIRST = MTK_CLK_APB,
> >>         MTK_CLK_SMI,
> >>         MTK_CLK_MAX,
> >>  }
> >> or the CLK_SMI also need MTK_CLK_SECOND = MTK_CLK_SMI.
> >
> >
> > something like:
> > enum {
> >          MTK_CLK_FIRST,
> >          MTK_CLK_APB = MTK_CLK_FIRST,
> >          MTK_CLK_SMI,
> >          MTK_CLK_LAST,
> > }
> >
> > So you can rewrite the for loop:
> > if (i = MTK_CLK_FIRST; i < MTK_CLK_LAST; i++)
> 
> Actually, do we ever plan to add more clks per smi node?
No.
> If not, perhaps the whole driver would be simpler if you just
> explicitly handle the apb & smi clocks:
> 
> struct mtk_smi_larb {
>        void __iomem            *base;
>        spinlock_t              portlock; /* lock for config port */
>        struct device           *smi;
>        struct clk              *clk_apb;
>        struct clk              *clk_smi;
> };
> 
> And then all of the loops become just a pair of clock operations.
Thanks. I will try this and compare whether it will add many lines.
> 
> Best Regards,
> -Dan
> 
> >
> > Regards,
> > Matthias
> >
> >>> > +};
> >>> > +
> >>> > +struct mtk_smi_common {
> >>> > +       void __iomem            *base;
> >>>
> >>> That seems to be never used. Please delete it.
> >>>
> >>> > +       struct clk              *clk[MTK_CLK_MAX];
> >>> > +};
> >>> > +
> >>> > +struct mtk_smi_larb {
> >>> > +       void __iomem            *base;
> >>> > +       spinlock_t              portlock; /* lock for config port */
> >>> > +       struct clk              *clk[MTK_CLK_MAX];
> >>> > +       struct device           *smi;
> >>> > +};
> >>> > +
> >>> Thanks,
> >>> Matthias
> >>
> > --
> > motzblog.wordpress.com
