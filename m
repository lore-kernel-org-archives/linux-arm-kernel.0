From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 05 Jun 2018 15:42:11 +0200
Subject: [PATCH v7 1/5] drm/rockchip: add transfer function for cdn-dp
In-Reply-To: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
References: <1527061353-16902-1-git-send-email-hl@rock-chips.com>
Message-ID: <2246202.0LhvmkcTbg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 23. Mai 2018, 09:42:29 CEST schrieb Lin Huang:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> We may support training outside firmware, so we need support
> dpcd read/write to get the message or do some setting with
> display.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-by: Enric Balletbo <enric.balletbo@collabora.com>

> @@ -1030,6 +1064,13 @@ static int cdn_dp_bind(struct device *dev, struct
> device *master, void *data) dp->active = false;
>  	dp->active_port = -1;
>  	dp->fw_loaded = false;
> +	dp->aux.name = "DP-AUX";
> +	dp->aux.transfer = cdn_dp_aux_transfer;
> +	dp->aux.dev = dev;
> +
> +	ret = drm_dp_aux_register(&dp->aux);
> +	if (ret)
> +		return ret;

this is missing matching drm_dp_aux_unregister calls both in the error path as 
well as in the unbind callback.

With the code as is, the kernel gives warnings about it trying to initialize 
an already initialized object ... in cases like probe-deferrals.


Heiko
