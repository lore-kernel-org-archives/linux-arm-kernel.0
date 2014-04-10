From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Apr 2014 09:21:42 +0800
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5AuwgVijZ_SMYZBOxbq8dVtvUzcQ06TFmmDtiaEQJrYRw@mail.gmail.com>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <20140409133422.GA2334@dragon>
 <CAOMZO5CO8ucya8qmVXBo5kgRmuLqKGtpub07o1DuE9yh5LmmPQ@mail.gmail.com>
 <20140409145936.GB2334@dragon>
 <CAOMZO5AuwgVijZ_SMYZBOxbq8dVtvUzcQ06TFmmDtiaEQJrYRw@mail.gmail.com>
Message-ID: <20140410012140.GC2334@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 12:28:50PM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Wed, Apr 9, 2014 at 11:59 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> > As long as you call clk_register_mux() to register a multiplexer, you
> > have to ensure that clk_set_parent() call always works properly on it,
> > no matter whether there is one actually calling into it right now.
> 
> clk_register_mux() is not called for the ldb_di_sels multiplexer:

Are you sure about that?  What are the following two calls in
clk-imx6q.c doing then?

	clk[ldb_di0_sel] = imx_clk_mux_flags(...);
	clk[ldb_di1_sel] = imx_clk_mux_flags(...);

> 
> **** Clk name is lvds1_sel
> ********* Calling clk_register_mux
> **** Clk name is lvds2_sel
> ********* Calling clk_register_mux
> **** Clk name is step
> ********* Calling clk_register_mux
> **** Clk name is pll1_sw
> ********* Calling clk_register_mux
> **** Clk name is periph_pre
> ********* Calling clk_register_mux
> **** Clk name is periph2_pre
> ********* Calling clk_register_mux
> **** Clk name is periph_clk2_sel
> ********* Calling clk_register_mux
> **** Clk name is periph2_clk2_sel
> ********* Calling clk_register_mux
> **** Clk name is axi_sel
> ********* Calling clk_register_mux
> **** Clk name is esai_sel
> ********* Calling clk_register_mux
> **** Clk name is asrc_sel
> ********* Calling clk_register_mux
> **** Clk name is spdif_sel
> ********* Calling clk_register_mux
> **** Clk name is gpu2d_axi
> ********* Calling clk_register_mux
> **** Clk name is gpu3d_axi
> ********* Calling clk_register_mux
> **** Clk name is gpu2d_core_sel
> ********* Calling clk_register_mux
> **** Clk name is gpu3d_core_sel
> ********* Calling clk_register_mux
> **** Clk name is gpu3d_shader_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu1_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu2_sel
> ********* Calling clk_register_mux
> ********* Calling clk_register_mux
> ********* Calling clk_register_mux

Oh, why clk_register_mux() is being called without a clock name in above
three?

> **** Clk name is ipu1_di0_pre_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu1_di1_pre_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu2_di0_pre_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu2_di1_pre_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu1_di0_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu1_di1_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu2_di0_sel
> ********* Calling clk_register_mux
> **** Clk name is ipu2_di1_sel
> ********* Calling clk_register_mux
> **** Clk name is hsi_tx_sel
> ********* Calling clk_register_mux
> **** Clk name is pcie_axi_sel
> ********* Calling clk_register_mux
> **** Clk name is enfc_sel
> ********* Calling clk_register_mux
> **** Clk name is vdo_axi_sel
> ********* Calling clk_register_mux
> **** Clk name is vpu_axi_sel
> ********* Calling clk_register_mux
> **** Clk name is cko1_sel
> ********* Calling clk_register_mux
> **** Clk name is cko2_sel
> ********* Calling clk_register_mux
> **** Clk name is cko
> ********* Calling clk_register_mux
> ********* doing ldb clock switch

For the record, here is my printk gives.

*** clk_register_mux: lvds1_sel
*** clk_register_mux: lvds2_sel
*** clk_register_mux: step
*** clk_register_mux: pll1_sw
*** clk_register_mux: periph_pre
*** clk_register_mux: periph2_pre
*** clk_register_mux: periph_clk2_sel
*** clk_register_mux: periph2_clk2_sel
*** clk_register_mux: axi_sel
*** clk_register_mux: esai_sel
*** clk_register_mux: asrc_sel
*** clk_register_mux: spdif_sel
*** clk_register_mux: gpu2d_axi
*** clk_register_mux: gpu3d_axi
*** clk_register_mux: gpu2d_core_sel
*** clk_register_mux: gpu3d_core_sel
*** clk_register_mux: gpu3d_shader_sel
*** clk_register_mux: ipu1_sel
*** clk_register_mux: ipu2_sel
*** clk_register_mux: ldb_di0_sel
*** clk_register_mux: ldb_di1_sel
*** clk_register_mux: ipu1_di0_pre_sel
*** clk_register_mux: ipu1_di1_pre_sel
*** clk_register_mux: ipu2_di0_pre_sel
*** clk_register_mux: ipu2_di1_pre_sel
*** clk_register_mux: ipu1_di0_sel
*** clk_register_mux: ipu1_di1_sel
*** clk_register_mux: ipu2_di0_sel
*** clk_register_mux: ipu2_di1_sel
*** clk_register_mux: hsi_tx_sel
*** clk_register_mux: pcie_axi_sel
*** clk_register_mux: enfc_sel
*** clk_register_mux: vdo_axi_sel
*** clk_register_mux: vpu_axi_sel
*** clk_register_mux: cko1_sel
*** clk_register_mux: cko2_sel
*** clk_register_mux: cko

> 
> >
> > Furthermore, some re-parenting happens in a way you may not be aware of.
> > See commit e366fdd (clk: clk-mux: implement remuxing on set_rate), for
> > example.
> 
> This commit does not affect us as we pass the CLK_SET_RATE_NO_REPARENT flag.

You did not get my point.  This is just an example, and we happen to set
this flag for now.  My point is that as long as you register a clk to
clock framework, you do not have a way to stop one from calling clk
API on the clock then.  This is how clk framework and API work, simple
as it is.

Shawn
