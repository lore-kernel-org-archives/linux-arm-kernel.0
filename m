From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 6 Sep 2018 03:21:39 +0000
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <20180903114439.7y4zl63bpy26od23@pengutronix.de>
References: <AM0PR04MB4211F68CCD399243613F8D7B80320@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211F748DBD1FE64A2B2136980360@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180827083310.omqa3kpmj542fu3b@pengutronix.de>
 <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB42113BB0FA9E54629339F872800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180828062113.khmkvsj3ofc7muu6@pengutronix.de>
 <AM0PR04MB4211A6BC038A141BA25B638A800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180829065346.zi6v6me7ufft7ntt@pengutronix.de>
 <AM0PR04MB42110CB29DC190C9163B2FB580090@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211680A90724E089F5A1468800C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180903114439.7y4zl63bpy26od23@pengutronix.de>
Message-ID: <AM0PR04MB4211EB20F182FD13C8070CA880010@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sasha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Monday, September 3, 2018 7:45 PM
>
> On Mon, Sep 03, 2018 at 08:57:36AM +0000, A.s. Dong wrote:
> > Hi Sascha,
> >
> > > -----Original Message-----
> > > From: A.s. Dong
> > > Sent: Wednesday, August 29, 2018 4:35 PM
> > > To: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > [...]
> >
> > > > > The original point is to separate the SCU service API
> > > > > implementation from the client drivers. Client drivers don't
> > > > > have to know the internal details of the API implementation,
> > > > > they just use the service API provided by SCU firmware. API
> > > > > implementation and client users will be
> > > > maintained independently.
> > > >
> > > > I would buy this argument if the 'API implementation' was more
> > > > than a shim layer that directly translates between function
> > > > arguments and a
> > > message struct.
> > > > With this you effectively can't change the API implementation
> > > > without changing the API you provide to the client drivers.
> > > >
> > >
> > > In reality, the API implementation could change without changing the
> > > API prototype.
> > > The API is defined in a more generic way and less possible to change.
> > > But the internal implementation is allowed to change if the firmware
> updates.
> > > e.g. protocol params layout and size and etc.
> > >
> > > This way give us a clear separation between API internals and client
> > > users which are more like to be maintained independently.
> > > And it may also help if we want to support old firmware due to API
> > > internal implementation changes. (And note that SCU firmware
> > > supports many functions, distribute them into various drivers may
> > > cause a bit mess. Some of them may get troubles on finding a proper
> > > place to put.)
> 
> Examples?
> 

Take sc_misc_set_control as example which is widely used by various client drivers.
Encoding message in driver may cause many duplicated code. 
Cscope tag: sc_misc_set_control
   #   line  filename / context / line
   1    206  drivers/clk/imx/clk-divider-scu.c <<clk_divider3_scu_set_rate>>
             sci_err = sc_misc_set_control(ccm_ipc_handle, clk->rsrc_id,
   2    372  drivers/clk/imx/clk-gate-scu.c <<clk_gate3_scu_prepare>>
             return sc_misc_set_control(ccm_ipc_handle,
   4    319  drivers/clk/imx/clk-mux-scu.c <<clk_mux_gpr_scu_set_parent>>
             sc_misc_set_control(ccm_ipc_handle,
   5    128  drivers/gpu/drm/imx/hdp/imx-hdp.c <<imx8qm_pixel_link_validate>>
             sciErr = sc_misc_set_control(hdp->ipcHndl, SC_R_DC_0,
  10    432  drivers/gpu/drm/imx/hdp/imx-hdp.c <<imx8qm_dp_pixel_clock_set_rate>>
             sc_misc_set_control(ipc_handle, SC_R_HDMI, SC_C_MODE, 1);
  11    339  drivers/gpu/drm/imx/imx-ldb.c <<dpu_pixel_link_validate>>
             sciErr = sc_misc_set_control(ipcHndl, SC_R_DC_0,
  30    271  drivers/gpu/drm/imx/nwl_dsi-imx.c <<imx8q_dsi_poweron>>
             sci_err = sc_misc_set_control(ipc_handle,
  41   1544  drivers/gpu/imx/dpu/dpu-common.c <<dpu_pixel_link_init>>
             sciErr = sc_misc_set_control(ipcHndl, SC_R_DC_0, SC_C_KACHUNK_CNT, 32);
  58   1612  drivers/gpu/imx/dpu/dpu-common.c <<dpu_pixel_link_init>>
             sciErr = sc_misc_set_control(ipcHndl, SC_R_DC_1, SC_C_SYNC_CTRL1, 0);
  59    147  drivers/gpu/imx/dpu/dpu-framegen.c <<dpu_pixel_link_enable>>
             sciErr = sc_misc_set_control(ipcHndl, SC_R_DC_0,
  65    312  drivers/gpu/imx/imx8_dprc.c <<dprc_dpu_gpr_configure>>
             sciErr = sc_misc_set_control(ipcHndl, dprc->sc_resource,
  67    573  drivers/media/platform/imx8/hdmi/mxc-hdmi-rx.c <<imx8qm_hdmi_phy_reset>>
             sciErr = sc_misc_set_control(hdmi_rx->ipcHndl, SC_R_HDMI_RX, SC_C_PHY_RESET, reset);
  68    139  drivers/media/platform/imx8/mxc-mipi-csi2.c <<mipi_sc_fw_init>>
             sciErr = sc_misc_set_control(ipcHndl, rsrc_id, SC_C_MIPI_RESET, enable);
  69   1261  drivers/mxc/gpu-viv/hal/os/linux/kernel/platform/freescale/gc_hal_kernel_platform_imx.c <<set_power>>
             sc_err_t sciErr = sc_misc_set_control(gpu_ipcHandle, priv->sc_gpu_pid[gpu], SC_C_ID, gpu);
  72    230  drivers/net/ethernet/freescale/fec_fixup.c <<imx8qm_ipg_stop_enable>>
             sc_err = sc_misc_set_control(ipc_handle, rsrc_id, SC_C_IPG_STOP, val);
  73    187  drivers/phy/phy-mixel-mipi-dsi.c <<mixel_mipi_phy_enable>>
             sci_err = sc_misc_set_control(ipc_handle,
  74    794  sound/soc/fsl/fsl_dsp.c <<fsl_dsp_probe>>
             sciErr = sc_misc_set_control(dsp_priv->dsp_ipcHandle, SC_R_DSP,
...

> > >
> > > So aren't those more valuable comparing to move SCU APIs into client
> drivers?
> > > And current kernel users (arm scpi/scmi, ti sci) already do like
> > > this... why not i.MX?
> > >
> > > Sorry if I still not get your point.
> > > Please help clarify a bit more if I missed something..
> >
> > Please let me know if you still believe moving SCU API implementation
> > into each client driver is a more reasonable way to go, then i will do
> > it as I trust your professionality.
> 
> Yes, I still think that. I still think the 1:1 mapping between messages and
> function calls is an unnecessary overhead.
> 

Okay, let's do that way first if you still think it's proper.
BTW, do you have any comment about the MU usage in Patch 2/5 ?
[V5,2/5] soc: imx: add SC firmware IPC and APIs
https://patchwork.kernel.org/patch/10570551/

As this patch may not change much even changing to new approach, except moving
drivers/soc/imx/sc/main/rpc.h under include/soc/imx to allow drivers to touch
the internal details of SCU API implementation. So I guess this version
does not affect review process.

Regards
Dong Aisheng

> Sascha
> 
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Ca0
> 3cf22e3f194f921f2d08d61192a293%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C636715718821871337&amp;sdata=usMYj5iYuKFhqBU2HMHI
> gGL8w0FTMQ632a6HiTotNoc%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
