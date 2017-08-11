From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Fri, 11 Aug 2017 10:15:16 +0800
Subject: [PATCH 3/3] drm/rockchip: Add support for Rockchip Soc LVDS
In-Reply-To: <20170810180519.ezndiczwpheac4ih@art_vandelay>
References: <1502272846-63941-1-git-send-email-hjc@rock-chips.com>
 <1502272861-64226-1-git-send-email-hjc@rock-chips.com>
 <20170809195812.vtndofimdiojb4cr@art_vandelay>
 <d24020c6-ef7f-6c7d-b655-99e56c8760d5@rock-chips.com>
 <20170810180519.ezndiczwpheac4ih@art_vandelay>
Message-ID: <78abe787-c7f1-d8e4-3fcd-e08ea092be6f@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/8/11 2:05, Sean Paul ??:
> On Thu, Aug 10, 2017 at 05:35:52PM +0800, Sandy Huang wrote:
>> Hi Sean Paul,
>>      Thanks for your review.
>>
>> ? 2017/8/10 3:58, Sean Paul ??:
>>> On Wed, Aug 09, 2017 at 06:00:59PM +0800, Sandy Huang wrote:
>>>> This adds support for Rockchip soc lvds found on rk3288
>>>> Based on the patches from Mark yao and Heiko Stuebner
>>>>
>>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>>> Signed-off-by: Mark yao <mark.yao@rock-chips.com>
>>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>>> ---
>>>>    drivers/gpu/drm/rockchip/Kconfig         |   9 +
>>>>    drivers/gpu/drm/rockchip/Makefile        |   1 +
>>>>    drivers/gpu/drm/rockchip/rockchip_lvds.c | 734 +++++++++++++++++++++++++++++++
>>>>    drivers/gpu/drm/rockchip/rockchip_lvds.h | 112 +++++
>>>>    4 files changed, 856 insertions(+)
>>>>    create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.c
>>>>    create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.h
>>>>
> 
> <snip />
> 
>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
>>>> new file mode 100644
>>>> index 0000000..a4ad3f0
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> 
> <snip />
> 
>>>> +	lvds->drm_dev = drm_dev;
>>>> +	port = of_graph_get_port_by_id(dev->of_node, 1);
>>>> +	if (!port) {
>>>> +		dev_err(dev, "can't found port point, please init lvds panel port!\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	for_each_child_of_node(port, endpoint) {
>>>> +		remote = of_graph_get_remote_port_parent(endpoint);
>>>> +		if (!remote) {
>>>> +			dev_err(dev, "can't found panel node, please init!\n");
>>>> +			ret = -EINVAL;
>>>> +			goto err_put_port;
>>>> +		}
>>>> +		if (!of_device_is_available(remote)) {
>>>> +			of_node_put(remote);
>>>> +			remote = NULL;
>>>> +			continue;
>>>> +		}
>>>> +		break;
>>>> +	}
>>>> +	if (!remote) {
>>>> +		dev_err(dev, "can't found remote node, please init!\n");
>>>> +		ret = -EINVAL;
>>>> +		goto err_put_port;
>>>> +	}
>>>> +
>>>> +	lvds->panel = of_drm_find_panel(remote);
>>>> +	if (!lvds->panel)
>>>> +		lvds->bridge = of_drm_find_bridge(remote);
>>>
>>> drm_of_find_panel_or_bridge()
>>>
>>
>> because the lvds ports maybe connect to lvds-panel or connect to
>> rk1000(which is convert RGB to CVBS output), so i have to get the remote
>> port parent and check the status, and final get the active remote point.
>>
> 
> 
> 
>> lvds_panel: lvds-panel {
>> 	status = "disabled";
>> 	ports {
>> 		panel_in_lvds: endpoint {
>> 			remote-endpoint = <&lvds_out_panel>;
>> 		};
>> 	};
>> };
>>
>> rk1000: rk1000 at 0xff000000 {
>> 	status = "okay";
>> 	ports {
>> 		rk1000_in_lvds: endpoint {
>> 			remote-endpoint = <&lvds_out_panel>;
>> 		};
>> 	};
>> };
>>
>> &lvds {
>> 	status = "okay";
>> 	ports {
>> 		lvds_out: port at 1 {
>> 			reg = <1>;
>> 			lvds_out_panel: endpoint at 0 {
>> 				reg = <0>;
>> 				remote-endpoint = <&panel_in_lvds>;
>> 			};
>> 			lvds_out_rk1000: endpoint at 1 {
>> 				reg = <1>;
>> 				remote-endpoint = <&rk1000_in_lvds>;
>> 			};
>> 		};
>>
>> 	};
>> };
> 
> Hi Sandy,
> Forgive me, this is probably a stupid question. I don't see how this usecase is
> unique from the other users of drm_of_find_panel_or_bridge. Couldn't you change
> your devicetree bindings to conform to something drm_of_find_panel_or_bridge()
> can work with?
> 
> Thank you,
> 
Hi sean,
     Maybe i can use the following method to use 
drm_of_find_panel_or_bridge() and no need to change my DT, but there is 
another question:
     The LVDS output format(rockchip,output?rockchip,data-mapping etc.)
depend on different panel, so it should be put under remote panel point.
If use drm_of_find_panel_or_bridge?), this just return panel or bridge, 
so i have to back to get remote panel point and get the output format.

ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &lvds->panel,
                                   &lvds->bridge);
if (ret)
     ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 1, &lvds->panel,
                                       &lvds->bridge);
if (ret) {
     DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
     ret  = -EPROBE_DEFER;
     goto err_put_remote;
}
	
