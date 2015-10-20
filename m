From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 20 Oct 2015 11:18:39 +0100
Subject: [PATCH v4 0/4] drm: Cleanup probe function for component based
 masters.
In-Reply-To: <20151020100233.GW13786@phenom.ffwll.local>
References: <1445332995-11212-1-git-send-email-Liviu.Dudau@arm.com>
 <20151020100233.GW13786@phenom.ffwll.local>
Message-ID: <20151020101839.GB3394@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 12:02:33PM +0200, Daniel Vetter wrote:
> On Tue, Oct 20, 2015 at 10:23:11AM +0100, Liviu Dudau wrote:
> > Changelog:
> > v4: Fixed a bug where the wrong pointer was sent to component_match_add() and
> >     component_master_add_with_match() in the armada_drv.c file that was flagged
> >     by kbuild test robot. Dropped the RFC tag and added Acked-bys received from
> >     Russell King.
> > v3: Removed the call to dma_set_coherent_mask() from the generic
> >     drm_of_component_probe(). Also changes to shorten lines over 80 chars long.
> > v2: Rebased the patchset on top of drm-next rather than Linus' latest -rc
> > 
> > A few drivers in drivers/gpu/drm are component-enabled and use quite similar
> > code sequences to probe for their encoder slaves at the remote end of the ports.
> > Move the code into a "generic" function and remove it from the drivers.
> > 
> > The end results is that drivers get a reference count fix (imx), more thorough
> > error checking (imx again) plus a decrease in the overall count of LoC.
> > 
> > I'm looking for comments and testing of the patchset (only compile tested from my
> > end as I don't have access to all the devices touched by the changes). My main
> > interest is in finding out if -EINVAL is the correct code to return if
> > dev->of_node == NULL (handy now, as it is different from the other possible error
> > codes and used in armada to trigger old platform_data support. Also looking for
> > thoughts on the correctness of the patch and if it possible to co-opt more drivers
> > into using the function.
> 
> Merged all four to drm-misc, thanks.
> -Daniel

Thanks!

Liviu

> 
> > 
> > Best regards,
> > Liviu
> > 
> > Liviu Dudau (4):
> >   drm: Introduce generic probe function for component based masters.
> >   drm/imx: Convert the probe function to the generic drm_of_component_probe()
> >   drm/rockchip: Convert the probe function to the generic drm_of_component_probe()
> >   drm/armada: Convert the probe function to the generic drm_of_component_probe()
> > 
> >  drivers/gpu/drm/armada/armada_drv.c         | 68 +++++++---------------
> >  drivers/gpu/drm/drm_of.c                    | 88 +++++++++++++++++++++++++++++
> >  drivers/gpu/drm/imx/imx-drm-core.c          | 55 ++----------------
> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 81 ++------------------------
> >  include/drm/drm_of.h                        | 13 +++++
> >  5 files changed, 130 insertions(+), 175 deletions(-)
> > 
> > -- 
> > 2.6.0
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
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
