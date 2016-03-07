From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 07 Mar 2016 16:37:03 +0800
Subject: [PATCH 1/2] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup()
 in error path
In-Reply-To: <20160305123942.GE19428@n2100.arm.linux.org.uk>
References: <1457133723-24869-1-git-send-email-dianders@chromium.org>
 <20160305121005.GA11966@serenity.lan>
 <20160305123942.GE19428@n2100.arm.linux.org.uk>
Message-ID: <56DD3DAF.8090700@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?05? 20:39, Russell King - ARM Linux wrote:
> On Sat, Mar 05, 2016 at 12:11:16PM +0000, John Keeping wrote:
>> On Fri, Mar 04, 2016 at 03:22:01PM -0800, Douglas Anderson wrote:
>>> The drm_encoder_cleanup() was missing both from the error path of
>>> dw_hdmi_rockchip_bind().  This caused a crash when slub_debug was
>>> enabled and we ended up deferring probe of HDMI at boot.
>>>
>>> This call isn't needed from unbind() because if dw_hdmi_bind() returns
>>> no error then it takes over the job of freeing the encoder (in
>>> dw_hdmi_unbind).
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>> Does dw_hdmi-imx need a similar change?  I wonder if it would be cleaner
>> to push this into dw_hdmi_bind() if it affects all of the platforms..
> I don't think moving it there would make sense - keep the initialisation
> and cleanup together in the same file so that it's contained together.
>

I don't like this patch too, initialisation and cleanup not in the same 
file looks bad,

How about:

drivers/gpu/drm/bridge/dw-hdmi.c
void dw_hdmi_unbind(struct device *dev, struct device *master, void *data)
         hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);

hdmi->connector.funcs->destroy(&hdmi->connector);
-       hdmi->encoder->funcs->destroy(hdmi->encoder);

drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,

-       return dw_hdmi_bind(dev, master, data, encoder, iores, irq, 
plat_data);
+       ret = dw_hdmi_bind(dev, master, data, encoder, iores, irq, 
plat_data);
+       if (ret)
+               drm_encoder_cleanup(encoder);
+
+       return ret;
  }

  static void dw_hdmi_rockchip_unbind(struct device *dev, struct device 
*master,
                                     void *data)
  {
+       drm_encoder_cleanup(...);
         return dw_hdmi_unbind(dev, master, data);
  }

Thanks.

-- 
?ark Yao
