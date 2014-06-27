From: detheridge@ti.com (Darren Etheridge)
Date: Fri, 27 Jun 2014 17:08:51 -0500
Subject: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <53ADEB73.8090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guido,

On 06/17/2014 09:17 AM, Guido Mart?nez wrote:
> The tilcdc driver could be compiled as a module, but was severely broken
> and could not be used as such. This patchset attempts to fix the issues
> preventing a proper load/unload of the module.
>
> Issues included dangling sysfs nodes, dangling devices, memory leaks and
> a double kfree.
>
> It now seems to be working ok. We have tested this by loading and
> unloading the driver repeteadly, with both panel and slave connectors
> and found no flaws.
>
> There is still one warning left on tilcdc_crtc_destroy, caused by
> destroying the connector while still in an ON status. We don't know why
> this happens or why it's an issue, so we did not fix it.
>

Yes I see what you mean, it triggers the WARN_ON in tilcdc_crtc_destroy 
because DRM_MODE_DPMS_ON is still set.  This WARN_ON does make some 
sense because DPMS_OFF would have the effect of turning off clocks and 
putting the monitor to sleep which seems logical considering we have 
torn down the display.  Adding a tilcdc_crtc_dpms(DPMS_OFF) right before 
the WARN_ON confirms this, but it seems strange that this hasn't 
happened automatically (+ Russell doesn't need to do it in his Armada 
driver) - so I suspect there is a better way.

Otherwise I think this is a good and useful patch series.

Darren

> The first 7 patches are bug fixes which and should probably be applied
> in the stable trees. The last two are clean-ups.
>
>
> Resending this since I got no replies.
>
>
> Guido Mart?nez (9):
>    drm/i2c: tda998x: move drm_i2c_encoder_destroy call
>    drm/tilcdc: panel: fix dangling sysfs connector node
>    drm/tilcdc: slave: fix dangling sysfs connector node
>    drm/tilcdc: tfp410: fix dangling sysfs connector node
>    drm/tilcdc: panel: fix leak when unloading the module
>    drm/tilcdc: fix release order on exit
>    drm/tilcdc: fix double kfree
>    drm/tilcdc: remove submodule destroy calls
>    drm/tilcdc: replace late_initcall with module_init
>
>   drivers/gpu/drm/i2c/tda998x_drv.c      |  2 +-
>   drivers/gpu/drm/tilcdc/Module.symvers  |  0
>   drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 15 +++++--------
>   drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
>   drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 39 +++++++++++++++++-----------------
>   drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 27 +++++++++++++----------
>   drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 35 +++++++++++++++---------------
>   7 files changed, 59 insertions(+), 60 deletions(-)
>   create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers
>
