From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 30 Oct 2009 12:19:20 +0100
Subject: [PATCH] ARM: pxafb: Use the passed fb_var_screeninfo struct in
	pxafb_pan_display()
In-Reply-To: <20091029195156.GI22046@sci.fi>
References: <20091022063434.GQ14091@buzzloop.caiaq.de>
	<20091028001805.GC14091@buzzloop.caiaq.de>
	<f17812d70910271913l15950170we45290bb1892761a@mail.gmail.com>
	<20091029195156.GI22046@sci.fi>
Message-ID: <20091030111920.GC14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2009 at 09:51:56PM +0200, Ville Syrj?l? wrote:
> On Wed, Oct 28, 2009 at 10:13:17AM +0800, Eric Miao wrote:
> > I see no problem with this patch, applied to 'devel'.
> 
> This patch looks broken to me. The only fields of of the fb_var_screeninfo
> passed to pan_display that should be used are xoffset, yoffset and 
> vmode & FB_VMODE_YWRAP. The rest are not checked by the common code at
> all and depending on the hardware the pan operation may involve looking
> at any number of fields from fb_var_screeninfo so if other fields are
> taken from the passed fb_var_screeninfo the pan operation may end up doing
> a lot more than panning (eg. it could change the video mode). Even worse
> things could happen since the values are not checked at all.
> 
> To prevent driver authors' from shooting themselves in the foot it might
> make sense to change the common code to make a copy of info->var and
> merge those three fields from the passed fb_var_screeninfo into the copy,
> which would then be passed to the driver.

Agreed. See the fixup patch below. I did that locally now for pxafb to
fix the potential regression. Eventually code like this could go to some
more generic place.

Thanks for pointing this out!

Daniel
