From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Jun 2017 08:22:56 -0300
Subject: [PATCH v1] firmware: add sdma firmware for i.mx6/i.mx7d
In-Reply-To: <1497943490-13401-1-git-send-email-yibin.gong@nxp.com>
References: <1497943490-13401-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <CAOMZO5Cq4x-YiX4YG=J-h9PHB3Pf1t0sjzi2gRXZ_5bytx78rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Jun 20, 2017 at 4:24 AM, Robin Gong <yibin.gong@nxp.com> wrote:
> add sdma firmware for i.mx6 and i.mx7d family, this patch depends
> on the below:
>
>  commit 3123d78e09d2 ("imx: Add SDMA firmware for Freescale i.MX6/7 SoCs")
>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  firmware/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/firmware/Makefile b/firmware/Makefile
> index fa3e81c..edc86a0 100644
> --- a/firmware/Makefile
> +++ b/firmware/Makefile
> @@ -65,6 +65,7 @@ fw-shipped-$(CONFIG_DVB_AV7110) += av7110/bootcode.bin
>  fw-shipped-$(CONFIG_DVB_TTUSB_BUDGET) += ttusb-budget/dspbootcode.bin
>  fw-shipped-$(CONFIG_E100) += e100/d101m_ucode.bin e100/d101s_ucode.bin \
>                              e100/d102e_ucode.bin
> +fw-shipped-$(CONFIG_IMX_SDMA) += imx/sdma/sdma-imx6q.bin imx/sdma/sdma-imx7d.bin

You have just broken imx_v6_v7_defconfig:

  LD      drivers/base/built-in.o
make[1]: *** No rule to make target
'firmware/imx/sdma/sdma-imx6q.bin', needed by
'firmware/imx/sdma/sdma-imx6q.bin.gen.o'.  Stop.
make[1]: *** Waiting for unfinished jobs....
  MK_FW   firmware/imx/sdma/sdma-imx6q.bin.gen.S
/bin/sh: 1: cannot create firmware/imx/sdma/sdma-imx6q.bin.gen.S:
Directory nonexistent
/bin/sh: 1: cannot create firmware/imx/sdma/sdma-imx6q.bin.gen.S:
Directory nonexistent

This does not look correct. This Makefile refers to old firmware
present in the kernel tree.

For the i.MX SDMA firmware case it is located in linux-firmware git
tree, so you cannot assume it will always be built-in.
