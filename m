From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 16 Nov 2015 16:50:24 +0000
Subject: [PATCH 0/2] Improve drm_of_component_probe() and move rockchip
 to use it
In-Reply-To: <2290660.pLIRHdxPYF@diego>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
 <2290660.pLIRHdxPYF@diego>
Message-ID: <20151116165024.GB4158@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 05:07:17PM +0100, Heiko St?bner wrote:
> Hi Liviu,
> 
> Am Montag, 16. November 2015, 14:44:51 schrieb Liviu Dudau:
> > When I have introduced the drm_of_component_probe() function I have managed
> > to break rockchip's DRM driver as the compare_of() function had to match
> > both local crtc ports and remote encoder ones. As suggested by Russell
> > King, I have now enhanced the drm_of_component_probe() function to take two
> > comparison functions, and converted (again) rockchip driver to use it.
> > 
> > I would really like to get some Tested-By this time if possible from IMX,
> > Armada and Rockchip developers as I lack hardware to do that myself.
> > 
> > The only thing not implemented from Russell's suggestion list is the
> > renaming of the function into drm_kms_component_probe().
> 
>  with these patches applied I loose the display on my rk3288. A bit of dumb
> debug-output shows that the compare function does seem to do strange things:
> 
> [    1.020476] [drm] Initialized drm 1.1.0 20060810
> [    1.025943] drm_of_component_probe: adding port /vop at ff940000/port
> [    1.032225] drm_of_component_probe: adding port /vop at ff930000/port
> [    1.038421] drm_of_component_probe: adding encoder /hdmi at ff980000
> [    1.044535] drm_of_component_probe: adding encoder /edp at ff970000
> [    1.050562] drm_of_component_probe: adding encoder /hdmi at ff980000
> [    1.056663] drm_of_component_probe: adding encoder /edp at ff970000
> 
> ---- Columns:	dev->parent / dev	comparing	dev->parent->of_node	with	np
> 
> [    1.062683] compare_port: platform/ff980000.hdmi comparing NULL with /vop at ff940000/port
> [    1.071017] compare_port: platform/ff980000.hdmi comparing NULL with /vop at ff940000/port
> [    1.079024] compare_port: platform/ff930000.vop comparing NULL with /vop at ff940000/port
> [    1.087117] compare_port: platform/ff980000.hdmi comparing NULL with /vop at ff940000/port
> [    1.095130] compare_port: platform/ff930000.vop comparing NULL with /vop at ff940000/port
> [    1.103054] compare_port: platform/ff940000.vop comparing NULL with /vop at ff940000/port
> [    1.111553] panel_regulator: supplied by vcc33_sys
> 
> 
> I need to dig deeper to find out what's happening there, but maybe you
> already have some idea in the meantime :-)

Did I got the content of the compare_{port,encoder}() functions the wrong way around?

Best regards,
Liviu

> 
> 
> Thanks
> Heiko
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
