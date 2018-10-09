From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 9 Oct 2018 02:38:22 +0000
Subject: [shawnguo:imx/drivers 9/10]
 drivers/firmware/imx/imx-scu.c:180:3-9: preceding lock on line 165 (fwd)
In-Reply-To: <20181008140344.GQ3587@dragon>
References: <alpine.DEB.2.20.1810081032450.2815@hadrien>
 <20181008140344.GQ3587@dragon>
Message-ID: <AM0PR04MB4211AA92D6F2415D544714F080E70@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, October 8, 2018 10:04 PM
> To: Julia Lawall <julia.lawall@lip6.fr>
> Cc: A.s. Dong <aisheng.dong@nxp.com>; Sascha Hauer
> <s.hauer@pengutronix.de>; linux-arm-kernel at lists.infradead.org;
> kbuild-all at 01.org
> Subject: Re: [shawnguo:imx/drivers 9/10]
> drivers/firmware/imx/imx-scu.c:180:3-9: preceding lock on line 165 (fwd)
> 
> Hi Julia,
> 
> On Mon, Oct 08, 2018 at 10:33:31AM +0200, Julia Lawall wrote:
> > Hello,
> >
> > It looks like an unlock is needed before line 180.
> 
> Ah, yes.  I just appended the following change to the original commit.
> 

Shawn,
Thanks for the change.

Julia,
Thanks for the report.

Regards
Dong Aisheng

> Thanks for the report.
> 
> Shawn
> 
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 06c9b8e01a8c..2bb1a19c413f 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -176,6 +176,7 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void
> *msg, bool have_resp)
>                 if (!wait_for_completion_timeout(&sc_ipc->done,
>                                                  MAX_RX_TIMEOUT))
> {
>                         dev_err(sc_ipc->dev, "RPC send msg timeout\n");
> +                       mutex_unlock(&sc_ipc->lock);
>                         return -ETIMEDOUT;
>                 }
> 
> 
> 
> >
> > julia
> >
> > ---------- Forwarded message ----------
> > Date: Mon, 8 Oct 2018 15:25:21 +0800
> > From: kbuild test robot <lkp@intel.com>
> > To: kbuild at 01.org
> > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > Subject: [shawnguo:imx/drivers 9/10]
> drivers/firmware/imx/imx-scu.c:180:3-9:
> >     preceding lock on line 165
> >
> > CC: kbuild-all at 01.org
> > CC: linux-arm-kernel at lists.infradead.org
> > TO: Dong Aisheng <aisheng.dong@nxp.com>
> > CC: Shawn Guo <shawnguo@kernel.org>
> > CC: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > tree:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ke
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git&
> amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Cab375197b905451892f
> e08d62d26ea99%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 6746042526127632&amp;sdata=TPqf6Nii5H4qap9aq7kAq3dHcU03FFdpISVY
> NVNl6QU%3D&amp;reserved=0 imx/drivers
> > head:   a8b96789a795af1127f722c3b1cd243ea16270ae
> > commit: d41a5a155f7b716941583cab7db703a2e4c6172c [9/10] firmware:
> imx:
> > add SCU firmware driver support
> > :::::: branch date: 8 days ago
> > :::::: commit date: 8 days ago
> >
> > >> drivers/firmware/imx/imx-scu.c:180:3-9: preceding lock on line 165
> >
> > #
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.
> git%
> >
> 2Fcommit%2F%3Fid%3Dd41a5a155f7b716941583cab7db703a2e4c6172c&a
> mp;data=0
> >
> 2%7C01%7Caisheng.dong%40nxp.com%7Cab375197b905451892fe08d62d26
> ea99%7C6
> >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636746042526137637&
> amp;sdata
> > =A7MgLV5IgT68DrG85ejuPjiXNxhn2ILojs4PXtQOKWQ%3D&amp;reserved=0
> > git remote add shawnguo
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
> > .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.
> git&
> >
> amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Cab375197b905451892f
> e08d62d
> >
> 26ea99%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636746042
> 526137637
> >
> &amp;sdata=hCoJSx3HbDh3FVc4qgE3MTN0AFqgqkAemhn%2FEhMpMJs%3D
> &amp;reserv
> > ed=0
> > git remote update shawnguo
> > git checkout d41a5a155f7b716941583cab7db703a2e4c6172c
> > vim +180 drivers/firmware/imx/imx-scu.c
> >
> > d41a5a15 Dong Aisheng 2018-09-30  153
> > d41a5a15 Dong Aisheng 2018-09-30  154  /*
> > d41a5a15 Dong Aisheng 2018-09-30  155   * RPC command/response
> > d41a5a15 Dong Aisheng 2018-09-30  156   */
> > d41a5a15 Dong Aisheng 2018-09-30  157  int imx_scu_call_rpc(struct
> > imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
> > d41a5a15 Dong Aisheng 2018-09-30  158  {
> > d41a5a15 Dong Aisheng 2018-09-30  159  	struct imx_sc_rpc_msg *hdr;
> > d41a5a15 Dong Aisheng 2018-09-30  160  	int ret;
> > d41a5a15 Dong Aisheng 2018-09-30  161
> > d41a5a15 Dong Aisheng 2018-09-30  162  	if (WARN_ON(!sc_ipc
> || !msg))
> > d41a5a15 Dong Aisheng 2018-09-30  163  		return -EINVAL;
> > d41a5a15 Dong Aisheng 2018-09-30  164
> > d41a5a15 Dong Aisheng 2018-09-30 @165  	mutex_lock(&sc_ipc->lock);
> > d41a5a15 Dong Aisheng 2018-09-30  166
> 	reinit_completion(&sc_ipc->done);
> > d41a5a15 Dong Aisheng 2018-09-30  167
> > d41a5a15 Dong Aisheng 2018-09-30  168  	sc_ipc->msg = msg;
> > d41a5a15 Dong Aisheng 2018-09-30  169  	sc_ipc->count = 0;
> > d41a5a15 Dong Aisheng 2018-09-30  170  	ret =
> imx_scu_ipc_write(sc_ipc, msg);
> > d41a5a15 Dong Aisheng 2018-09-30  171  	if (ret < 0) {
> > d41a5a15 Dong Aisheng 2018-09-30  172  		dev_err(sc_ipc->dev,
> "RPC send msg failed: %d\n", ret);
> > d41a5a15 Dong Aisheng 2018-09-30  173  		goto out;
> > d41a5a15 Dong Aisheng 2018-09-30  174  	}
> > d41a5a15 Dong Aisheng 2018-09-30  175
> > d41a5a15 Dong Aisheng 2018-09-30  176  	if (have_resp) {
> > d41a5a15 Dong Aisheng 2018-09-30  177  		if
> (!wait_for_completion_timeout(&sc_ipc->done,
> > d41a5a15 Dong Aisheng 2018-09-30  178
> MAX_RX_TIMEOUT)) {
> > d41a5a15 Dong Aisheng 2018-09-30  179  			dev_err(sc_ipc->dev,
> "RPC send msg timeout\n");
> > d41a5a15 Dong Aisheng 2018-09-30 @180  			return
> -ETIMEDOUT;
> > d41a5a15 Dong Aisheng 2018-09-30  181  		}
> > d41a5a15 Dong Aisheng 2018-09-30  182
> > d41a5a15 Dong Aisheng 2018-09-30  183  		/* response status is
> stored in hdr->func field */
> > d41a5a15 Dong Aisheng 2018-09-30  184  		hdr = msg;
> > d41a5a15 Dong Aisheng 2018-09-30  185  		ret = hdr->func;
> > d41a5a15 Dong Aisheng 2018-09-30  186  	}
> > d41a5a15 Dong Aisheng 2018-09-30  187
> > d41a5a15 Dong Aisheng 2018-09-30  188  out:
> > d41a5a15 Dong Aisheng 2018-09-30  189
> 	mutex_unlock(&sc_ipc->lock);
> > d41a5a15 Dong Aisheng 2018-09-30  190
> > d41a5a15 Dong Aisheng 2018-09-30  191  	dev_dbg(sc_ipc->dev, "RPC
> SVC done\n");
> > d41a5a15 Dong Aisheng 2018-09-30  192
> > d41a5a15 Dong Aisheng 2018-09-30  193  	return
> imx_sc_to_linux_errno(ret);
> > d41a5a15 Dong Aisheng 2018-09-30  194  }
> > d41a5a15 Dong Aisheng 2018-09-30  195
> > EXPORT_SYMBOL(imx_scu_call_rpc);
> > d41a5a15 Dong Aisheng 2018-09-30  196
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology
> Center
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.0
> 1.org%2Fpipermail%2Fkbuild-all&amp;data=02%7C01%7Caisheng.dong%40nx
> p.com%7Cab375197b905451892fe08d62d26ea99%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C636746042526137637&amp;sdata=kFIkXanllJ
> YfAie3xzsWvMcaylyTAbYpwYvUP23N5jA%3D&amp;reserved=0
> Intel Corporation
