From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 27 Apr 2010 11:16:44 +0800
Subject: [PATCH] pxa: Remove unused MFP LPM definition
In-Reply-To: <4BD64FF1.2090007@gmail.com>
References: <4BD64FF1.2090007@gmail.com>
Message-ID: <s2yf17812d71004262016xb120ea1j2d0d7dd14ebd3d28@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 27, 2010 at 10:46 AM, David Hunter <hunterd42@gmail.com> wrote:
> MFP_LPM_INPUT snuck in some time ago as part of "[PATCH] pxa: better
> MFP low power state support for pxa25x/pxa27x", but went unused in the
> final revision of said patch. Using it on PXA3xx would cause an
> out-of-bounds access of mfpr_table[]. Let's remove it before someone
> gets hurt.
>

Instead of removing this potentially useful low power mode pin status, what
about the following patch:

commit f5d406d50f924c82ddf469f120fa420f0499d901
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Tue Apr 27 11:14:24 2010 +0800

    [ARM] pxa: allow MFP_LPM_INPUT to be explicitly specified

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index e5b7921..1d1419b 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -81,6 +81,7 @@ static int __mfp_config_gpio(unsigned gpio, unsigned long c)
 		PGSR(bank) &= ~mask;
 		is_out = 1;
 		break;
+	case MFP_LPM_INPUT:
 	case MFP_LPM_DEFAULT:
 		break;
 	default:
diff --git a/arch/arm/plat-pxa/mfp.c b/arch/arm/plat-pxa/mfp.c
index be58f9f..b77e018 100644
--- a/arch/arm/plat-pxa/mfp.c
+++ b/arch/arm/plat-pxa/mfp.c
@@ -110,6 +110,7 @@ static const unsigned long mfpr_lpm[] = {
 	MFPR_LPM_PULL_LOW,
 	MFPR_LPM_PULL_HIGH,
 	MFPR_LPM_FLOAT,
+	MFPR_LPM_INPUT,
 };

 /* mapping of MFP_PULL_* definitions to MFPR_PULL_* register bits */
