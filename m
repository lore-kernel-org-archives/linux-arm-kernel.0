From: eric@anholt.net (Eric Anholt)
Date: Tue, 05 Sep 2017 12:43:18 -0700
Subject: [PATCH 2/2] RFC: drm/pl111: Support using the VGA bridge as
 fallback
In-Reply-To: <20170904074355.gjbf7he2dt5kszfg@phenom.ffwll.local>
References: <20170901094629.6566-1-linus.walleij@linaro.org>
 <20170904074355.gjbf7he2dt5kszfg@phenom.ffwll.local>
Message-ID: <87h8whq6cp.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Fri, Sep 01, 2017 at 11:46:29AM +0200, Linus Walleij wrote:
>> If we cannot find a panel, assume that the output from the
>> PL111 is connected directly to a "dumb" VGA connector,
>> so look up the connector from that bridge.
>> 
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> This is how the new API is used in the PL111.
>> ---
>>  drivers/gpu/drm/pl111/Kconfig     | 1 +
>>  drivers/gpu/drm/pl111/pl111_drv.c | 3 +++
>>  2 files changed, 4 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
>> index e5e2abd66491..82cb3e60ddc8 100644
>> --- a/drivers/gpu/drm/pl111/Kconfig
>> +++ b/drivers/gpu/drm/pl111/Kconfig
>> @@ -8,6 +8,7 @@ config DRM_PL111
>>  	select DRM_GEM_CMA_HELPER
>>  	select DRM_BRIDGE
>>  	select DRM_PANEL_BRIDGE
>> +	select DRM_DUMB_VGA_DAC
>>  	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>>  	help
>>  	  Choose this option for DRM support for the PL111 CLCD controller.
>> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
>> index f5bc6f160e60..6db423bbd84e 100644
>> --- a/drivers/gpu/drm/pl111/pl111_drv.c
>> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
>> @@ -67,6 +67,7 @@
>>  #include <drm/drm_of.h>
>>  #include <drm/drm_bridge.h>
>>  #include <drm/drm_panel.h>
>> +#include <drm/dumb_vga_dac.h>
>>  
>>  #include "pl111_drm.h"
>>  #include "pl111_versatile.h"
>> @@ -128,6 +129,8 @@ static int pl111_modeset_init(struct drm_device *dev)
>>  	if (panel) {
>>  		priv->panel = panel;
>>  		priv->connector = panel->connector;
>> +	} else {
>> +		priv->connector = drm_dumb_vga_get_connector(bridge);
>
> Why do you need to set this? The only code I could find tries to set
> polarity values from bus_flags, and for VGA I'd assume you want to instead
> key this off the mode?
>
> Wrt the more general problem: They way we solve this in the i915 atomic
> framework is that the various ->fixup calls fill out relevant fields in
> the drm_crtc_state. I guess we could add an ->atomic_check to bridges, add
> a bus_flags to drm_crtc_state (or maybe just let everyone patch up
> adjusted_mode->flags) instead?

It seems to me like the bus_flags/format should be specific to each link
in the display output chain, rather than global to it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170905/a7121552/attachment-0001.sig>
