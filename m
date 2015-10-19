From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 19 Oct 2015 16:07:46 +0100
Subject: [RFC PATCH v3 0/4] drm: Cleanup probe function for component based
 masters.
Message-ID: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v3: Removed the call to dma_set_coherent_mask() from the generic
    drm_of_component_probe(). Also changes to shorten lines over 80 chars long.
v2: Rebased the patchset on top of drm-next rather than Linus' latest -rc

A few drivers in drivers/gpu/drm are component-enabled and use quite similar
code sequences to probe for their encoder slaves at the remote end of the ports.
Move the code into a "generic" function and remove it from the drivers.

The end results is that drivers get a reference count fix (imx), more thorough
error checking (imx again) plus a decrease in the overall count of LoC.

I'm looking for comments and testing of the patchset (only compile tested from my
end as I don't have access to all the devices touched by the changes). My main
interest is in finding out if -EINVAL is the correct code to return if
dev->of_node == NULL (handy now, as it is different from the other possible error
codes and used in armada to trigger old platform_data support. Also looking for
thoughts on the correctness of the patch and if it possible to co-opt more drivers
into using the function.

Best regards,
Liviu

Liviu Dudau (4):
  drm: Introduce generic probe function for component based masters.
  drm/imx: Convert the probe function to the generic drm_of_component_probe()
  drm/rockchip: Convert the probe function to the generic drm_of_component_probe()
  drm/armada: Convert the probe function to the generic drm_of_component_probe()

 drivers/gpu/drm/armada/armada_drv.c         | 73 ++++++++----------------
 drivers/gpu/drm/drm_of.c                    | 88 +++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/imx-drm-core.c          | 55 ++----------------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 81 ++------------------------
 include/drm/drm_of.h                        | 13 +++++
 5 files changed, 133 insertions(+), 177 deletions(-)

-- 
2.6.0
