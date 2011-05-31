From: dsd@laptop.org (Daniel Drake)
Date: Tue, 31 May 2011 22:52:57 +0100
Subject: [PATCH 0/2] sdio: make sdio_single_irq optional due to suprious
	IRQ
In-Reply-To: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTimRB8z16wjyH1fuXbiybQuaJL4Qug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2011 21:33, Per Forlin <per.forlin@linaro.org> wrote:
> Daniel Drake reported an issue in the libertas sdio client that was
> triggered by the sdio_single_irq functionality. His SDIO device seems to
> raise an interrupt even though there are no bits set in the CCCR_INTx
> register. This behaviour is not supported by the sdio_single_irq feature nor
> the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
> overhead of checking the CCCR_INTx registers, this result in no error
> handling of the case if there is a pending IRQ with none CCCR_INTx bits set.

Thanks a lot for diagnosing this and nice work on figuring out the
root cause presumably without even having access to the hardware!

I've looked further, based on your findings, and have found that you
are correct. During initialisation, exactly one interrupt is received
with CCCR_INTx=0. Previously the mmc stack threw this interrupt away,
after the optimization it now calls into libertas before it is ready
to handle interrupts, leading to the crash. From that point, all other
interrupts that come in are "normal".

This is definitely a weird hardware issue, and it would annoy me for
this hardware to cause a second generic mmc layer feature be disabled
by default! And actually it is not much work to harden up the libertas
driver to be able to accept that spurious IRQ, and during the process
of fixing that it actually made the spurious IRQ go away completely.

Patch attached.

So, I vote for that we work around this little hardware issue in the
libertas driver, and leave this optimization enabled by default until
we find a hardware issue that is more difficult to workaround. I can
take on submission of the libertas patch.

Thoughts?

Daniel
-------------- next part --------------
diff --git a/drivers/net/wireless/libertas/if_sdio.c b/drivers/net/wireless/libertas/if_sdio.c
index a7b5cb0..224e985 100644
--- a/drivers/net/wireless/libertas/if_sdio.c
+++ b/drivers/net/wireless/libertas/if_sdio.c
@@ -907,7 +907,7 @@ static void if_sdio_interrupt(struct sdio_func *func)
 	card = sdio_get_drvdata(func);
 
 	cause = sdio_readb(card->func, IF_SDIO_H_INT_STATUS, &ret);
-	if (ret)
+	if (ret || !cause)
 		goto out;
 
 	lbs_deb_sdio("interrupt: 0x%X\n", (unsigned)cause);
@@ -1008,10 +1008,6 @@ static int if_sdio_probe(struct sdio_func *func,
 	if (ret)
 		goto release;
 
-	ret = sdio_claim_irq(func, if_sdio_interrupt);
-	if (ret)
-		goto disable;
-
 	/* For 1-bit transfers to the 8686 model, we need to enable the
 	 * interrupt flag in the CCCR register. Set the MMC_QUIRK_LENIENT_FN0
 	 * bit to allow access to non-vendor registers. */
@@ -1083,6 +1079,21 @@ static int if_sdio_probe(struct sdio_func *func,
 		card->rx_unit = 0;
 
 	/*
+	 * Set up the interrupt handler late.
+	 *
+	 * If we set it up earlier, the (buggy) hardware generates a spurious
+	 * interrupt, even before the interrupt has been enabled, with
+	 * CCCR_INTx = 0.
+	 *
+	 * We register the interrupt handler late so that we can handle any
+	 * spurious interrupts, and also to avoid generation of that known
+	 * spurious interrupt in the first place.
+	 */
+	ret = sdio_claim_irq(func, if_sdio_interrupt);
+	if (ret)
+		goto disable;
+
+	/*
 	 * Enable interrupts now that everything is set up
 	 */
 	sdio_writeb(func, 0x0f, IF_SDIO_H_INT_MASK, &ret);
