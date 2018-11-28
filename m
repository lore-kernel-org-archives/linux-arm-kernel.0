From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 28 Nov 2018 17:41:09 +0800
Subject: [V2] usb/mtu3: power down device ip at setup
In-Reply-To: <20181128092953.41541-1-hsinyi@chromium.org>
References: <20181128060412.630-1-hsinyi@chromium.org>
 <20181128092953.41541-1-hsinyi@chromium.org>
Message-ID: <1543398069.32173.112.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hsin-Yi,

On Wed, 2018-11-28 at 17:29 +0800, Hsin-Yi, Wang wrote:
> Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> so host ip sleep will fail at ssusb_host_disable.
> 
> Power down device ip at ssusb_host_setup.
need modify it, not in ssusb_host_setup now
> 
> 
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> ---
>  drivers/usb/mtu3/mtu3_plat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 46551f6d16fd..cdef66141e20 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -200,6 +200,12 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
>  	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
>  	udelay(1);
>  	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> +
> +	/*
> +	 * device ip is default power-on in fact
change as: device ip maybe poweron in LK/BROM stage before enter kernel
stage;
> +	 * power down device ip, otherwise ip-sleep will fail
power down device ip, otherwise ip-sleep will fail when works as host
only mode
> +	 */
> +	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
>  }
>  
>  /* ignore the error if the clock does not exist */

Thanks a lot
