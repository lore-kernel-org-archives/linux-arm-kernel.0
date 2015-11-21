From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 21 Nov 2015 17:23:27 -0200
Subject: imx6dl clock setup incorrectness
In-Reply-To: <564DD51A.8040100@dev.rtsoft.ru>
References: <564DD51A.8040100@dev.rtsoft.ru>
Message-ID: <CAOMZO5DOwy1oDbNsEDmQ+a4EcCo7QOv0ZYsJ93gj=4oNUNqANA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 11:56 AM, Nikita Yushchenko
<nyushchenko@dev.rtsoft.ru> wrote:
> Hi
>
> While working with board with imx6s cpu, with kernel based on linux-imx
> imx_3.14.28_1.0.0_ga branch, I noticed this message in boot log:
>
>> failed to set parent of clk gpu2d_core_sel to pll2_pfd1_594m
>
>
> I looked into it and found that:
>
> - CCM_CBCMR register layout is different between imx6q/imx6d and
> imc6dl/imx6s (at least manuals state that)
>
> - clock setup in clk-imx6q.c (that is used both got imx6q/imx6d and
> imx6dl/imx6s) creates gpu2d_core_sel clock object as described in imx6q
> manual (i.e. using bits 18:19 of CCM_CBCMR register)
>
> - however per imx6dl manual, these bits contain different field
> (mlb_sys_sel) on imx6dl/imx6s, and gpu2d_core sel is in bits 8:9
>
> - imx6q has different clock selector, gpu3d_shader_clk_sel, in bits 8:9,
> and existing code unconditionally creates gpu3d_shader_clk_sel clock object
>
> - per manual, gpu3d_shader_clk_sel does not exist on imx6qdl/imx6s
>
> - however gpu driver (which also is common between imx6q/imx6d and
> imc6dl/imx6s) does use gpu3d_shader_clk which is child of
> gpu3d_shader_clk_sel. Which means that it is not possible to simply
> change clock object creation code to match manuals.
>
>
> I'm looking for advice how to fix this situation properly.
>
>
> Btw situation is the same in mainline kernel - clock setup code in
> mainline is moved to drivers/clk/imx/ but still has the same incorrectness.

Isn't this handled by the following commit?

commit 2e603ad98460fd0efab71e618d49a2ffc9aef67b
Author: Dirk Behme <dirk.behme@de.bosch.com>
Date:   Fri May 3 11:08:45 2013 +0200

    ARM: i.MX6: clk: add i.MX6 DualLite differences

    The CCM_CBCMR register (address 0x02C4018) has different meaning
    between the i.MX6 Quad/Dual and the i.MX6 Solo/DualLite.

    Compared to the i.MX6 Quad/Dual, the CCM_CBCMR register in the
    i.MX6 Solo/DualLite doesn't have a gpu3d_shader configuration and
    moves the gpu2_core configuration at that place.

    Handle these i.MX6 Quad/Dual vs. i.MX6 Solo/DualLite clock differences
    by using cpu_is_mx6dl().

    Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
