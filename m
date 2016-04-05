From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 5 Apr 2016 09:49:28 +0800
Subject: [v14, 01/17] drm: bridge: analogix/dp: split exynos dp driver to
 bridge directory
In-Reply-To: <20160330203204.GA24156@roeck-us.net>
References: <1455534576-1486-1-git-send-email-ykk@rock-chips.com>
 <20160330203204.GA24156@roeck-us.net>
Message-ID: <570319A8.8080400@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter

On 03/31/2016 04:32 AM, Guenter Roeck wrote:
> Hi,
>
> On Mon, Feb 15, 2016 at 07:09:36PM +0800, Yakir Yang wrote:
>> Split the dp core driver from exynos directory to bridge directory,
>> and rename the core driver to analogix_dp_*, rename the platform
>> code to exynos_dp.
>>
>> Beside the new analogix_dp driver would export six hooks.
>> "analogix_dp_bind()" and "analogix_dp_unbind()"
>> "analogix_dp_suspned()" and "analogix_dp_resume()"
>> "analogix_dp_detect()" and "analogix_dp_get_modes()"
>>
>> The bind/unbind symbols is used for analogix platform driver to connect
>> with analogix_dp core driver. And the detect/get_modes is used for analogix
>> platform driver to init the connector.
>>
>> They reason why connector need register in helper driver is rockchip drm
>> haven't implement the atomic API, but Exynos drm have implement it, so
>> there would need two different connector helper functions, that's why we
>> leave the connector register in helper driver.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>>
> [ ... ]
>
>> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
>> new file mode 100644
>> index 0000000..9107b86
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp_core.o analogix_dp_reg.o
> This results in the following build errors if DRM_ANALOGIX_DP
> is configured as module.
>
> ERROR: "analogix_dp_start_video" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane0_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane1_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane2_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane3_link_training" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_lane_count" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
> ERROR: "analogix_dp_get_link_bandwidth" [drivers/gpu/drm/bridge/analogix/analogix_dp_core.ko] undefined!
>
> [ and so on ]
>
> It should probably be something like
>
> analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
> obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o

Thanks, good catch, will fix it now.

- Yakir
> Guenter
>
>
>
