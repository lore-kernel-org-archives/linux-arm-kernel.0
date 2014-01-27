From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jan 2014 19:59:30 +0000
Subject: [PATCH v4 07/24] drm/i2c: tda998x: set the video mode from the
 adjusted value
In-Reply-To: <20140125181443.5c079d76@armhf>
References: <cover.1390646891.git.moinejf@free.fr>
 <20140125181443.5c079d76@armhf>
Message-ID: <20140127195930.GW15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 25, 2014 at 06:14:43PM +0100, Jean-Francois Moine wrote:
> @@ -896,9 +897,9 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
>  	 * TDA19988 requires high-active sync at input stage,
>  	 * so invert low-active sync provided by master encoder here
>  	 */
> -	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +	if (adj_mode->flags & DRM_MODE_FLAG_NHSYNC)
>  		reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_H_TGL);
> -	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +	if (adj_mode->flags & DRM_MODE_FLAG_NVSYNC)
>  		reg_set(priv, REG_VIP_CNTRL_3, VIP_CNTRL_3_V_TGL);
>  
>  	/*

It looks like this comment from Darren has not been addressed (or
commented on).  Can you discuss this with Darren and come to some sort
of solution please, otherwise applying this patch set is going to cause
a regression.  Thanks.

=8<
Using the adj_mode->flags breaks a workaround I had done on BeagleBone Black    
(tilcdc + tda998x) to resolve an issue with out of spec syncs from the          
tlcdc.  I invert the HSYNC in adj_mode->flags but don't want the tda998x to     
really know that I am doing that so I use adj_mode in the tilcdc driver, and    
mode here in the tda998x driver.  The theory being adj_mode contains whatever   
workarounds I need to do for the driving device and mode has the pristine       
values that I want to send to the monitor.  I would need to look if there is a  
different way to solve this as I am guessing you are actually using adj_mode in 
the manner it was intended.                                                     
                                                                                
Otherwise this patch series is working on BeagleBone Black - I have only tried  
video so far (not audio).                                                       
                                                                                
Darren                                                                          
=8<

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
