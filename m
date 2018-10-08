From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 8 Oct 2018 10:33:31 +0200 (CEST)
Subject: [shawnguo:imx/drivers 9/10] drivers/firmware/imx/imx-scu.c:180:3-9:
 preceding lock on line 165 (fwd)
Message-ID: <alpine.DEB.2.20.1810081032450.2815@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

It looks like an unlock is needed before line 180.

julia

---------- Forwarded message ----------
Date: Mon, 8 Oct 2018 15:25:21 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild at 01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [shawnguo:imx/drivers 9/10] drivers/firmware/imx/imx-scu.c:180:3-9:
    preceding lock on line 165

CC: kbuild-all at 01.org
CC: linux-arm-kernel at lists.infradead.org
TO: Dong Aisheng <aisheng.dong@nxp.com>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/drivers
head:   a8b96789a795af1127f722c3b1cd243ea16270ae
commit: d41a5a155f7b716941583cab7db703a2e4c6172c [9/10] firmware: imx: add SCU firmware driver support
:::::: branch date: 8 days ago
:::::: commit date: 8 days ago

>> drivers/firmware/imx/imx-scu.c:180:3-9: preceding lock on line 165

# https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?id=d41a5a155f7b716941583cab7db703a2e4c6172c
git remote add shawnguo https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
git remote update shawnguo
git checkout d41a5a155f7b716941583cab7db703a2e4c6172c
vim +180 drivers/firmware/imx/imx-scu.c

d41a5a15 Dong Aisheng 2018-09-30  153
d41a5a15 Dong Aisheng 2018-09-30  154  /*
d41a5a15 Dong Aisheng 2018-09-30  155   * RPC command/response
d41a5a15 Dong Aisheng 2018-09-30  156   */
d41a5a15 Dong Aisheng 2018-09-30  157  int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
d41a5a15 Dong Aisheng 2018-09-30  158  {
d41a5a15 Dong Aisheng 2018-09-30  159  	struct imx_sc_rpc_msg *hdr;
d41a5a15 Dong Aisheng 2018-09-30  160  	int ret;
d41a5a15 Dong Aisheng 2018-09-30  161
d41a5a15 Dong Aisheng 2018-09-30  162  	if (WARN_ON(!sc_ipc || !msg))
d41a5a15 Dong Aisheng 2018-09-30  163  		return -EINVAL;
d41a5a15 Dong Aisheng 2018-09-30  164
d41a5a15 Dong Aisheng 2018-09-30 @165  	mutex_lock(&sc_ipc->lock);
d41a5a15 Dong Aisheng 2018-09-30  166  	reinit_completion(&sc_ipc->done);
d41a5a15 Dong Aisheng 2018-09-30  167
d41a5a15 Dong Aisheng 2018-09-30  168  	sc_ipc->msg = msg;
d41a5a15 Dong Aisheng 2018-09-30  169  	sc_ipc->count = 0;
d41a5a15 Dong Aisheng 2018-09-30  170  	ret = imx_scu_ipc_write(sc_ipc, msg);
d41a5a15 Dong Aisheng 2018-09-30  171  	if (ret < 0) {
d41a5a15 Dong Aisheng 2018-09-30  172  		dev_err(sc_ipc->dev, "RPC send msg failed: %d\n", ret);
d41a5a15 Dong Aisheng 2018-09-30  173  		goto out;
d41a5a15 Dong Aisheng 2018-09-30  174  	}
d41a5a15 Dong Aisheng 2018-09-30  175
d41a5a15 Dong Aisheng 2018-09-30  176  	if (have_resp) {
d41a5a15 Dong Aisheng 2018-09-30  177  		if (!wait_for_completion_timeout(&sc_ipc->done,
d41a5a15 Dong Aisheng 2018-09-30  178  						 MAX_RX_TIMEOUT)) {
d41a5a15 Dong Aisheng 2018-09-30  179  			dev_err(sc_ipc->dev, "RPC send msg timeout\n");
d41a5a15 Dong Aisheng 2018-09-30 @180  			return -ETIMEDOUT;
d41a5a15 Dong Aisheng 2018-09-30  181  		}
d41a5a15 Dong Aisheng 2018-09-30  182
d41a5a15 Dong Aisheng 2018-09-30  183  		/* response status is stored in hdr->func field */
d41a5a15 Dong Aisheng 2018-09-30  184  		hdr = msg;
d41a5a15 Dong Aisheng 2018-09-30  185  		ret = hdr->func;
d41a5a15 Dong Aisheng 2018-09-30  186  	}
d41a5a15 Dong Aisheng 2018-09-30  187
d41a5a15 Dong Aisheng 2018-09-30  188  out:
d41a5a15 Dong Aisheng 2018-09-30  189  	mutex_unlock(&sc_ipc->lock);
d41a5a15 Dong Aisheng 2018-09-30  190
d41a5a15 Dong Aisheng 2018-09-30  191  	dev_dbg(sc_ipc->dev, "RPC SVC done\n");
d41a5a15 Dong Aisheng 2018-09-30  192
d41a5a15 Dong Aisheng 2018-09-30  193  	return imx_sc_to_linux_errno(ret);
d41a5a15 Dong Aisheng 2018-09-30  194  }
d41a5a15 Dong Aisheng 2018-09-30  195  EXPORT_SYMBOL(imx_scu_call_rpc);
d41a5a15 Dong Aisheng 2018-09-30  196

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
