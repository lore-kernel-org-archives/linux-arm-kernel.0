From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 09 Mar 2012 10:11:58 +0200
Subject: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
In-Reply-To: <20120308204607.GX12083@atomide.com>
References: <20120308204328.GW12083@atomide.com>
 <20120308204607.GX12083@atomide.com>
Message-ID: <1331280718.1927.10.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-08 at 12:46 -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120308 12:11]:
> > Otherwise we will get:
> > 
> > arch/arm/plat-omap/fb.c:101: error: expected ?)? before ?*? token
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > Tomi, you need something like this for what you have in for-next.
> > 
> > --- a/arch/arm/plat-omap/fb.c
> > +++ b/arch/arm/plat-omap/fb.c
> > @@ -98,6 +98,8 @@ arch_initcall(omap_init_fb);
> >  
> >  #else
> >  
> > -void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
> > +void __init omapfb_set_lcd_config(const struct omap_lcd_config *config)
> > +{
> > +}
> >  
> >  #endif
> 
> Also now seeing the following with what you have in for-next:
> 
> drivers/video/omap2/displays/panel-taal.c: In function ?taal_num_errors_show?:
> drivers/video/omap2/displays/panel-taal.c:605: warning: ?errors? may be used uninitialized in this function

Hmm, my compiler doesn't complain (codesourcery 2010.09-50), so I didn't
notice that. Which compiler version reports the warning?

I'm not 100% sure, but I think it's a false warning, the code path that
uses "errors" should only be ran when "errors" has been set.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/bf151e56/attachment-0001.sig>
