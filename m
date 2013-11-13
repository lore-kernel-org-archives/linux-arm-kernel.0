From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Wed, 13 Nov 2013 09:31:16 +0100
Subject: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <20131112132441.GG30263@pengutronix.de>
 <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
Message-ID: <201311130931.16238.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On Tuesday 12 November 2013 21:17:34 Timur Tabi wrote:
> On Tue, Nov 12, 2013 at 7:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> > No, I don't have access on PowerPC hardware, so I didn't test it on
> > PowerPC.
>
> Can you change the code so that the interrupts are enabled only on
> i.MX?  On PowerPC, the interrupts are used only for debugging.

Hmm, you are right. My patch is partially bogus. It enables the
CCSR_SSI_SIER_TDMAE and CCSR_SSI_SIER_RDMAE bits on demand, but this setting
will be overwritten by the "write_ssi(sier_bits, &ssi->sier);" just a few
lines below. :(

But this patch works, because it removes the CCSR_SSI_SIER_TDMAE and
CCSR_SSI_SIER_RDMAE from the SIER_FLAGS macro. Its content is set
_unconditionally_ in lines 570 and 575 and is written to the register in line
607. This should hit PowerPC as well.

So, the real (and small) fix is to remove these bits from the SIER_FLAGS
macro:

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c6b7439..f176e34 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -107,10 +107,10 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 #endif
 
 /* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
+#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | \
 		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
 		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
+		    CCSR_SSI_SIER_RIE | \
 		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
 
 /**

@Markus: can you please test it on your hardware?

Thanks
jbe

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
