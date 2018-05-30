From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 30 May 2018 10:27:46 +0200
Subject: [PATCH 08/12] drm/bridge: tc358764: Add DSI to LVDS bridge driver
In-Reply-To: <201805301553.AcTypuC4%fengguang.wu@intel.com>
References: <1527500833-16005-9-git-send-email-m.purski@samsung.com>
 <CGME20180530074642epcas1p31772422454439c0a4ed636f620a3c4bc@epcas1p3.samsung.com>
 <201805301553.AcTypuC4%fengguang.wu@intel.com>
Message-ID: <20180530082748eucas1p1eede54cce4a257bf2795ac8474f9a9d3~zXr4CtkHD0946509465eucas1p1J@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,


On 30.05.2018 09:45, kbuild test robot wrote:
> Hi Maciej,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20180517]
> [cannot apply to drm-exynos/exynos-drm/for-next robh/for-next drm/drm-next v4.17-rc6 v4.17-rc5 v4.17-rc4 v4.17-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/Add-TOSHIBA-TC358764-DSI-LVDS-bridge-driver/20180530-011258
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/gpu/drm/bridge/tc358764.c:193:14: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [addressable] [usertype] addr @@    got ed] [addressable] [usertype] addr @@
>    drivers/gpu/drm/bridge/tc358764.c:193:14:    expected unsigned short [unsigned] [addressable] [usertype] addr
>    drivers/gpu/drm/bridge/tc358764.c:193:14:    got restricted __le16 [usertype] <noident>
>>> drivers/gpu/drm/bridge/tc358764.c:197:24: sparse: cast to restricted __le32
>>> drivers/gpu/drm/bridge/tc358764.c:175:5: sparse: symbol 'tc358764_read' was not declared. Should it be static?
>>> drivers/gpu/drm/bridge/tc358764.c:204:5: sparse: symbol 'tc358764_write' was not declared. Should it be static?
> vim +193 drivers/gpu/drm/bridge/tc358764.c
>
>    174	
>  > 175	int tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)

add static

>    176	{
>    177		struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>    178		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
>    179		struct mipi_dsi_msg msg = {
>    180			.type = MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM,
>    181			.channel = dsi->channel,
>    182			.flags = MIPI_DSI_MSG_USE_LPM,
>    183			.tx_buf = &addr,
>    184			.tx_len = 2,
>    185			.rx_buf = val,
>    186			.rx_len = 4
>    187		};
>    188		ssize_t ret;
>    189	
>    190		if (!ops || !ops->transfer)
>    191			return -EINVAL;
>    192	
>  > 193		addr = cpu_to_le16(addr);

It should be changed to:

cpu_to_le16s(&addr);

>    194	
>    195		ret = ops->transfer(dsi->host, &msg);
>    196		if (ret >= 0)
>  > 197			*val = le32_to_cpu(*val);

le32_to_cpus(val);

>    198	
>    199		dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
>    200	
>    201		return ret;
>    202	}
>    203	
>  > 204	int tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)

add static


Regards
Andrzej

>    205	{
>    206		struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>    207		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
>    208		u8 data[6];
>    209		int ret;
>    210		struct mipi_dsi_msg msg = {
>    211			.type = MIPI_DSI_GENERIC_LONG_WRITE,
>    212			.channel = dsi->channel,
>    213			.flags = MIPI_DSI_MSG_USE_LPM | MIPI_DSI_MSG_REQ_ACK,
>    214			.tx_buf = data,
>    215			.tx_len = 6
>    216		};
>    217	
>    218		if (!ops || !ops->transfer)
>    219			return -EINVAL;
>    220	
>    221		data[0] = addr;
>    222		data[1] = addr >> 8;
>    223		data[2] = val;
>    224		data[3] = val >> 8;
>    225		data[4] = val >> 16;
>    226		data[5] = val >> 24;
>    227	
>    228		ret = ops->transfer(dsi->host, &msg);
>    229	
>    230		return ret;
>    231	}
>    232	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>
