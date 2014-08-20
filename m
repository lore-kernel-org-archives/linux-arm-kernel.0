From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Aug 2014 12:59:01 +0100
Subject: [PATCH] mfd: max77686: make interrupts support optional
In-Reply-To: <53F45C73.1030304@collabora.co.uk>
References: <1408516009-22106-1-git-send-email-m.szyprowski@samsung.com>
 <20140820081909.GH4266@lee--X1> <53F45C73.1030304@collabora.co.uk>
Message-ID: <20140820115901.GJ4266@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:

> Hello Lee, Marek,
> 
> On 08/20/2014 10:19 AM, Lee Jones wrote:
> > On Wed, 20 Aug 2014, Marek Szyprowski wrote:
> > 
> >> Commit 6f1c1e71d93 ("mfd: max77686: Convert to use regmap_irq") broke
> >> support for boards, which provide no irq for MAX 77686 PMIC. In such
> >> case, not all functions of PMIC are available, but the driver still
> >> should at least handle voltage regulators instead of failing to init.
> >> This patch restores previous behavior.
> >> 
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >> Hello,
> >> 
> >> This patch fixes booting issues with recently merged support for
> >> Exynos4412 based Odroid X2/U3 boards. See
> >> http://www.spinics.net/lists/linux-samsung-soc/msg35773.html
> >> thread for more details.
> >> 
> >> Best regards
> >> Marek Szyprowski
> >> Samsung R&D Institute Poland
> 
> I already gave my opinion about this patch on thread:
> 
> "[PATCH v2 0/4] Add Exynos4412 based Odroid X2 and U2/U3/U3+ support"
> 
> where the issue was reported by Olof but I'll add it here as well for
> completeness since I don't know if the same people are cc'ed on both threads.
> 
> Bartlomiej Zolnierkiewicz posted a similar patch [0] before but as I said
> on that thread, I'm not sure if is correct to make that DT property
> optional. Or rather, if we need to make it optional then we should also
> change the Documentation/devicetree/bindings/mfd/max77686.txt that list
> "interrupts" DT property as required.
> 
> It's true that before converting the max77686 to use the regmap irq API,
> the driver was loose on that regard but max77686_irq_init() in
> max77686-irq.c was returning -ENODEV when the IRQ was not provided and
> that error code was not checked in max77686_i2c_probe() (which was a bug
> IMHO).
> 
> More importantly I wonder if a design where a IRQ line is not connected to
> the max77686 PMIC makes even sense. If such a design is possible then the
> "interrupt" property should be made optional but if not then I think that
> the driver should fail to probe in that case. Yes, it is a regression but
> the Odroid DTS was not following the DT binding and was just lucky that
> the driver was not checking the required DT properties.
> 
> Daniel Drake posted the correct fix for the Odroid DTS [1]. So I tend to
> say that Daniel's fix should be added as a -rc fix and we should keep both
> the max77686 driver and its DT binding as it is now but as I said, if from
> a hardware point of view makes sense to leave that line unconnected then I
> don't oppose to this change.

I wasn't aware that this had already been discussed.

FWIW, I agree with everything you just said, so unless someone insists
that the device can be functional without an IRQ line, I'm going to
shelve (not accept) this patch.

> [0]: https://lkml.org/lkml/2014/8/7/374
> [1]:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272869.html

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
