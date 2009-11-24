From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 24 Nov 2009 06:05:08 +0530
Subject: [PATCH] ARM l2x0: check whether l2x0 already enabled
In-Reply-To: <f2235a630911240411x67ad7e05k218b32e8d732dd0c@mail.gmail.com>
References: <1259014663.2742.3.camel@vinay-desktop>
	<f2235a630911240411x67ad7e05k218b32e8d732dd0c@mail.gmail.com>
Message-ID: <1259022908.2742.9.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 13:11 +0100, Surinder P Singh wrote:
> On Tue, Nov 24, 2009 at 3:47 AM, srinidhi kasagar
> <srinidhi.kasagar@stericsson.com> wrote:
> > From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Date: Tue, 24 Nov 2009 13:59:20 +0530
> >
> > If running in non-secure mode, accessing
> > control and auxiliary registers of l2x0
> > will fault.
> >
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > ---
> >  arch/arm/mm/cache-l2x0.c |   24 +++++++++++++++---------
> >  1 files changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index b480f1d..7c0d056 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -99,18 +99,24 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> >
> >        l2x0_base = base;
> >
> > -       /* disable L2X0 */
> > -       writel(0, l2x0_base + L2X0_CTRL);
> > +       /* check if l2x0 controller is already enabled.
> > +        * if you are booting from non-secure mode
> > +        * accessing the below registers will fault.
> > +        */
> > +       if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
> 
> 2 points:
> 
> 1. Since this code is also valid for devices based on pre-ARMv6, maybe
> making this code conditional for >=ARMv6 would be cleaner ?
rather it depends on l2 controller being used. L210 controllers
do not have such restrictions whereas l220/pl310 have such kind
of secure/non-secure restrictions. So would it be better to keep
condition based on l2 controller being used?

Srinidhi
