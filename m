From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 16 Feb 2015 21:24:51 +0100 (CET)
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <CAOMZO5DJ82Yyq4Ch_kKR01-yYhjn53As7ZBt91Dd5sna9Z+wXg@mail.gmail.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
 <54DA0DE7.5050708@i2se.com>
 <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
 <462270270.419156.1423603473431.JavaMail.open-xchange@oxbaltgw02.schlund.de>
 <CAOMZO5B4mxP6RBkbsbj=wC6bZJgtreoo5S_NhYuki6kW=Y=QFw@mail.gmail.com>
 <1705379122.406018.1423686677196.JavaMail.open-xchange@oxbaltgw01.schlund.de>
 <CAOMZO5ChJiHiUBhrRf_qqi7gTLvPp08fsfRBK+GVzvrqimKinw@mail.gmail.com>
 <1378197784.470306.1423767540298.JavaMail.open-xchange@oxbaltgw01.schlund.de>
 <CAOMZO5DJ82Yyq4Ch_kKR01-yYhjn53As7ZBt91Dd5sna9Z+wXg@mail.gmail.com>
Message-ID: <235965536.675649.1424118291283.JavaMail.open-xchange@oxbaltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 12. Februar 2015 um 20:08
> geschrieben:
>
>
> Hi Stefan,
>
> On Thu, Feb 12, 2015 at 4:59 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Hi Fabio,
> >
> >> Fabio Estevam <festevam@gmail.com> hat am 11. Februar 2015 um 22:10
> >> geschrieben:
> >>
> >>
> >> On Wed, Feb 11, 2015 at 6:31 PM, Stefan Wahren <stefan.wahren@i2se.com>
> >> wrote:
> >>
> >> >> I always get 0x5e5b5513 with or without your patch.
> >> >
> >> > very strange. Do you have any idea why IO1_STABLE is permanent low?
> >>
> >> On my case it is always 1.
> >
> > i expected the same behavior on my hardware.
> >
> > Do you use u-boot as bootloader?
>
> Yes, I do.

i will try to test it with u-boot.

>
> >>
> >> > Can you confirm the behavior according to your flash issue?
> >>
> >> In my tests IO1_STABLE stays the same.
> >
> > This wasn't the intension of my second question. I wanted to know about the
> > state of the SPI NOR flash detection process.
> >
> > Does it sucessed if you apply the patch, but revert the changes in
> > clk_ref_set_rate() from clk-ref.c?
>
> I don't have my mx28evk setup available at the moment, but when I
> applied your patch and reverted all the changes in clk-ref.c, then the
> SPI flash detection works.
>
> I haven't tested to only reverting the changes inside
> clk_ref_set_rate(), but I can do it tomorrow.

I think the reason for the problem in the flash detection is caused by the
misaligned access on the frac register.

Maybe you want to try the following after the second patch is reverted.

Stefan

------------>8----------------------------------------------------------
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 9fc9359..87969e3 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -73,8 +73,10 @@ static void __init clk_misc_init(void)
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac to get a 288 MHz ref_io.
 	 */
-	writel_relaxed(0x3f << BP_FRAC_IOFRAC, FRAC + CLR);
-	writel_relaxed(30 << BP_FRAC_IOFRAC, FRAC + SET);
+	val = readl_relaxed(FRAC);
+	val &= ~(0x3f << BP_FRAC_IOFRAC);
+	val |= 30 << BP_FRAC_IOFRAC;
+	writel_relaxed(val, FRAC);
 }
 
 static const char *sel_pll[]  __initconst = { "pll", "ref_xtal", };
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index a6c3501..e47ad69 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -118,10 +118,15 @@ static void __init clk_misc_init(void)
 	/*
 	 * 480 MHz seems too high to be ssp clock source directly,
 	 * so set frac0 to get a 288 MHz ref_io0 and ref_io1.
+	 * According to reference manual we must modify frac bytewise.
 	 */
 	val = readl_relaxed(FRAC0);
-	val &= ~((0x3f << BP_FRAC0_IO0FRAC) | (0x3f << BP_FRAC0_IO1FRAC));
-	val |= (30 << BP_FRAC0_IO0FRAC) | (30 << BP_FRAC0_IO1FRAC);
+	val &= ~(0x3f << BP_FRAC0_IO0FRAC);
+	val |= 30 << BP_FRAC0_IO0FRAC;
+	writel_relaxed(val, FRAC0);
+	val = readl_relaxed(FRAC0);
+	val &= ~(0x3f << BP_FRAC0_IO1FRAC);
+	val |= 30 << BP_FRAC0_IO1FRAC;
 	writel_relaxed(val, FRAC0);
 }
