From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 18 Apr 2012 20:34:44 +0100 (BST)
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <87bomohpdl.fsf@free.fr>
Message-ID: <1334777684.34148.YahooMailClassic@web29014.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Wed, 18/4/12, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > Just to clarify, the generic pxa/gpio suspend/resume
> support does
> > seem to work OK; the hx4700 patches are platform
> specific, apart
> > from this SKIP_SET_WAKE patch to fix the Unbalanced IRQ
> warnings.
> 
> OK, I'll check.
> 
> My platform is mioa701. In my case, the suspend/resume is
> working for RTC
> wakeup, but not for GPIO0. This code was working before
> (that's vague, I know, I
> suspect 3.0 was working), and is not working anymore. The
> gpio_keys_button
> structure has still its 'wakeup' field ...
> 
> > Consequently it seems likely that your problem is also
> platform
> > specific.
> OK. So you confirm that on hx4700, pressing PowerButton
> while in suspend to ram
> brings back to life your device ?

Yes.

I had a quick look at arch/arm/mach-pxa/mioa701.c and
noticed that it didn't call gpio_set_wake() for GPIO0.
Does this help:

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 061d570..23190bf 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -726,6 +726,7 @@ static void __init mioa701_machine_init(void)
 
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(mioa701_pin_config));
+	gpio_set_wake(GPIO0_KEY_POWER, 1);
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);

Regards,
Paul
