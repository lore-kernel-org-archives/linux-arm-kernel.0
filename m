From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Jun 2015 18:29:13 -0300
Subject: L2 Cache enable on i.MX5
In-Reply-To: <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
References: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
 <20150624172900.GN7557@n2100.arm.linux.org.uk>
 <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
Message-ID: <CAOMZO5A6B+m_HXZXeyWOWs2GAOXmhLunTgaOsQQL-OwSC8597w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 7:53 PM, Robert Daniels
<robert.daniels@vantagecontrols.com> wrote:

> I see - so the boot loader is not supposed to enable the L2 cache and it should
> not be enabled until after the decompressor runs.
>
> In that case, where should the kernel be enabling the L2 cache? I'm using the
> 3.14 kernel for this i.MX53 product and the L2 cache is definitely not enabled.
>
> I see that there is a imx_init_l2cache defined which is being called by the imx6
> and imx35 platform code but it is not being called for the i.mx5... should it?

Should we enable the L2 cache like it is done in Barebox?

--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -25,7 +25,13 @@

 static void __init imx53_init_early(void)
 {
+    unsigned int r;
+
     mxc_set_cpu_type(MXC_CPU_MX53);
+
+    __asm__ __volatile__("mrc 15, 0, %0, c1, c0, 1":"=r"(r));
+    r |= 1 << 1;     /* enable L2 cache */
+    __asm__ __volatile__("mcr 15, 0, %0, c1, c0, 1" : : "r"(r));
 }

 static void __init imx53_dt_init(void)

Regards,

Fabio Estevam
