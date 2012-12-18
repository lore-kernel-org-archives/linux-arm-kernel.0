From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 18 Dec 2012 12:41:52 +0000
Subject: [PATCH] ARM: OMAP2: hwmod: Fix "register offset NULL check" bug
In-Reply-To: <20121218123106.GB30971@arwen.pp.htv.fi>
References: <1355833929-25387-1-git-send-email-gururaja.hebbar@ti.com>
 <20121218123106.GB30971@arwen.pp.htv.fi>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB0B593@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 18:01:43, Balbi, Felipe wrote:
> Hi,
> 
> On Tue, Dec 18, 2012 at 06:02:09PM +0530, Hebbar Gururaja wrote:
> > From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> > 
> > omap4_cminst_wait_module_ready() checks if register offset is NULL.
> > 
> > int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> > 				   u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, not all clock domains have CLKSTCTRL at 0x00. An
> > example of this would be the RTC clock domain. In such cases the
> > module ready check is skipped which leads to a data abort during bootup
> > when RTC registers is accessed.
> > 
> > Since the actual base address is verified in
> > omap4_cminst_read_inst_reg(), this check here is not required at all
> > and hence can be removed.
> > 
> > Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> > ---
> > :100644 100644 7f9a464... 40545ff... M	arch/arm/mach-omap2/cminst44xx.c
> >  arch/arm/mach-omap2/cminst44xx.c |    3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
> > index 7f9a464..40545ff 100644
> > --- a/arch/arm/mach-omap2/cminst44xx.c
> > +++ b/arch/arm/mach-omap2/cminst44xx.c
> > @@ -271,9 +271,6 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> >  {
> >  	int i = 0;
> >  
> > -	if (!clkctrl_offs)
> > -		return 0;
> 
> looks like commit log has the wrong argument. I believe you meant to say
> that AM33xx has CLKSTCTRL exactly at 0x00 and that's why this check has
> to be removed. No ?

Correct. Thanks for the correction. V2 on the way.

> 
> -- 
> balbi
> 


Regards, 
Gururaja
