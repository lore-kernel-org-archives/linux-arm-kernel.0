From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 12 Jun 2012 10:08:42 +0100
Subject: [PATCH 1/2] ARM: vexpress: Check master site in daughterboard's
 sysctl operations
In-Reply-To: <1339491487.3063.23.camel@linaro1.home>
References: <1339159835-32228-1-git-send-email-pawel.moll@arm.com>
 <1339491487.3063.23.camel@linaro1.home>
Message-ID: <1339492122.2894.14.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 09:58 +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2012-06-08 at 13:50 +0100, Pawel Moll wrote:
> > With recent enough motherboard firmware, core tile can be fitted
> > in either of the two daughterboard sites. The non-DT tile code for
> > V2P-CA9 did not check that when configuring DVI output nor setting
> > CLCD pixel clock.
> > 
> > Fixed now, providing "get master site" API in motherboard's code.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> This patch makes an Ubuntu boot always hang for me, about the time it
> would switch to GUI mode, it's not very consistent unfortunately.
> 
> If I modify ct_ca9x4_clcd_enable() to replace "v2m_get_master_site()"
> with "1" then boot is OK. Even though if I put code it to test the
> return value from v2m_get_master_site() it shows it gives 1.
> 
> I am running stock Version 3 firmware on my vexpress.

Thanks for testing, I'll try to reproduce your problem here.

> > diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
> > index 31a9289..f004ec9 100644
> > --- a/arch/arm/mach-vexpress/include/mach/motherboard.h
> > +++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
> > @@ -104,9 +104,10 @@
> >  #define SYS_CFG_REBOOT		(9 << 20)
> >  #define SYS_CFG_DVIMODE		(11 << 20)
> >  #define SYS_CFG_POWER		(12 << 20)
> > -#define SYS_CFG_SITE_MB		(0 << 16)
> > -#define SYS_CFG_SITE_DB1	(1 << 16)
> > -#define SYS_CFG_SITE_DB2	(2 << 16)
> > +#define SYS_CFG_SITE(n)		((n) << 16)
> > +#define SYS_CFG_SITE_MB		0
> 
> There are three uses of this latter macro you have left unaltered: in
> v2m_osc1_set(), v2m_power_off() and v2m_restart(). 

Good point. I did grep for _DBx, forgot to do the same for _MB.

Having said that - I have to rework this whole lot anyway, to get all
functionality we need from sysreg/ctl, so don't bother with carrying
this patch in your tree.

Cheers!

Pawe?
