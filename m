From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 28 Jan 2014 18:12:18 +0100
Subject: [PATCH v3 07/24] drm/i2c: tda998x: set the video mode from the
 adjusted value
In-Reply-To: <20140123232907.GA25988@ti.com>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195840.1ecab03b@armhf> <20140123232907.GA25988@ti.com>
Message-ID: <20140128181218.39d1d15e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jan 2014 17:29:07 -0600
Darren Etheridge <detheridge@ti.com> wrote:

> > @@ -896,9 +897,9 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
> >  	 * TDA19988 requires high-active sync at input stage,
> >  	 * so invert low-active sync provided by master encoder here
> >  	 */
> > -	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > +	if (adj_mode->flags & DRM_MODE_FLAG_NHSYNC)
> >  		reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_H_TGL);
> > -	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> > +	if (adj_mode->flags & DRM_MODE_FLAG_NVSYNC)
> >  		reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_V_TGL);
> >    
> 
> Using the adj_mode->flags breaks a workaround I had done on BeagleBone Black
> (tilcdc + tda998x) to resolve an issue with out of spec syncs from the
> tlcdc.  I invert the HSYNC in adj_mode->flags but don't want the tda998x to
> really know that I am doing that so I use adj_mode in the tilcdc driver, and
> mode here in the tda998x driver.  The theory being adj_mode contains whatever
> workarounds I need to do for the driving device and mode has the pristine
> values that I want to send to the monitor.  I would need to look if there is a
> different way to solve this as I am guessing you are actually using adj_mode in
> the manner it was intended.

No. In fact, I just wanted the function to use only one mode.

Looking at the other drivers, it seems that they don't touch the
adjusted_mode, so, for the Cubox, mode and adjusted_mode have same
values.

I will do an other patch so that you will not have to touch the tilcdc
driver.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
