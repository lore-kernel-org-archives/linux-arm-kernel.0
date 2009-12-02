From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 2 Dec 2009 13:46:46 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <20091202112043.GA15126@pengutronix.de>
References: <1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
	<20091130121017.GN27548@pengutronix.de>
	<eedb5540911300425n374af9f0k5346d85fdb79eb11@mail.gmail.com>
	<20091130123412.GP27548@pengutronix.de>
	<eedb5540911300509t11cc783cr8e97eda66ee382a@mail.gmail.com>
	<20091130160356.GT27548@pengutronix.de>
	<eedb5540911300815u5cf60634jd58918f454269028@mail.gmail.com>
	<20091202112043.GA15126@pengutronix.de>
Message-ID: <eedb5540912020446n1da36bb0h229205ca8d73a030@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From 4c8b581dd28588940a328632e406baab574e0ce5 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 30 Nov 2009 13:31:29 +0100
> Subject: [PATCH] i.MX27 audmux: Fix register offsets
>
> We have two holes in the register space. The driver did not
> handle this. Fix it.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/audmux-v1.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
> index 70ab5af..da6387d 100644
> --- a/arch/arm/plat-mxc/audmux-v1.c
> +++ b/arch/arm/plat-mxc/audmux-v1.c
> @@ -28,7 +28,9 @@
>
>  static void __iomem *audmux_base;
>
> -#define MXC_AUDMUX_V1_PCR(x)   ((x) * 4)
> +static unsigned char port_mapping[] = {
> +       0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
> +};
>
>  int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
>  {
> @@ -37,7 +39,10 @@ int mxc_audmux_v1_configure_port(unsigned int port,
> unsigned int pcr)
>                return -ENOSYS;
>        }
>
> -       writel(pcr, audmux_base + MXC_AUDMUX_V1_PCR(port));
> +       if (port >= ARRAY_SIZE(port_mapping))
> +               return -EINVAL;
> +
> +       writel(pcr, audmux_base + port_mapping[port]);
>
>        return 0;
>  }
> --
> 1.6.5.2
>

Yes,
it works now. Thank you for your patience with this.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091202/f10ccfe5/attachment-0001.htm>
