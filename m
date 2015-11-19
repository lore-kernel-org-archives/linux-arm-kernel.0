From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Thu, 19 Nov 2015 16:56:42 +0300
Subject: imx6dl clock setup incorrectness
Message-ID: <564DD51A.8040100@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

While working with board with imx6s cpu, with kernel based on linux-imx
imx_3.14.28_1.0.0_ga branch, I noticed this message in boot log:

> failed to set parent of clk gpu2d_core_sel to pll2_pfd1_594m


I looked into it and found that:

- CCM_CBCMR register layout is different between imx6q/imx6d and
imc6dl/imx6s (at least manuals state that)

- clock setup in clk-imx6q.c (that is used both got imx6q/imx6d and
imx6dl/imx6s) creates gpu2d_core_sel clock object as described in imx6q
manual (i.e. using bits 18:19 of CCM_CBCMR register)

- however per imx6dl manual, these bits contain different field
(mlb_sys_sel) on imx6dl/imx6s, and gpu2d_core sel is in bits 8:9

- imx6q has different clock selector, gpu3d_shader_clk_sel, in bits 8:9,
and existing code unconditionally creates gpu3d_shader_clk_sel clock object

- per manual, gpu3d_shader_clk_sel does not exist on imx6qdl/imx6s

- however gpu driver (which also is common between imx6q/imx6d and
imc6dl/imx6s) does use gpu3d_shader_clk which is child of
gpu3d_shader_clk_sel. Which means that it is not possible to simply
change clock object creation code to match manuals.


I'm looking for advice how to fix this situation properly.


Btw situation is the same in mainline kernel - clock setup code in
mainline is moved to drivers/clk/imx/ but still has the same incorrectness.


Nikita
