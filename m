From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 12 Mar 2013 10:17:49 +0100
Subject: [PATCH 2/4] clk: samsung: remove np check in clock init
In-Reply-To: <201303121002.56535.heiko@sntech.de>
References: <201303120042.09633.heiko@sntech.de>
 <CAJuYYwSU_pFoyHkzt=sP6AfN03F9V1_Rx+3o1ekbLHD4jC5SpA@mail.gmail.com>
 <201303121002.56535.heiko@sntech.de>
Message-ID: <201303121017.49655.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 12. M?rz 2013, 10:02:55 schrieb Heiko St?bner:
> Am Dienstag, 12. M?rz 2013, 09:53:00 schrieb Thomas Abraham:
> > On 12 March 2013 05:14, Heiko St?bner <heiko@sntech.de> wrote:
> > > This let to the suspend init never being reached on non-DT platforms.
> > > 
> > > Signed-off-by: Heiko Stueber <heiko@sntech.de>
> > > ---
> > > 
> > >  drivers/clk/samsung/clk.c |    2 --
> > >  1 files changed, 0 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> > > index d36cdd5..1a5de69 100644
> > > --- a/drivers/clk/samsung/clk.c
> > > +++ b/drivers/clk/samsung/clk.c
> > > @@ -57,8 +57,6 @@ void __init samsung_clk_init(struct device_node *np,
> > > void __iomem *base,
> > > 
> > >                 unsigned long nr_rdump)
> > >  
> > >  {
> > >  
> > >         reg_base = base;
> > > 
> > > -       if (!np)
> > > -               return;
> > 
> > Hi Heiko,
> > 
> > Sorry, I did not understand the need for this. Could you please add
> > few more details on this change.
> 
> Hi Thomas,
> 
> On non-dt platforms the init would stop here, therefore never reaching the
> code that inits the syscore ops below to save the register values on
> suspend and restores them on resume.
> 
> I might be overlooking something, but I think we want to save/restore the
> register values on both dt and non-dt platforms.

ok, I did overlook something :-)

The register saving seems to be done separately on non-dt platforms (mach-
exynos/pm.c for example). So I probably need to redo patch 2 and 3.


Heiko


> > >  #ifdef CONFIG_OF
> > >  
> > >         clk_table = kzalloc(sizeof(struct clk *) * nr_clks,
> > >         GFP_KERNEL);
> > > 
> > > --
> > > 1.7.2.3
