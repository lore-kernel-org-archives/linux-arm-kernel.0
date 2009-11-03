From: roel.kluin@gmail.com (Roel Kluin)
Date: Tue, 03 Nov 2009 23:05:32 +0100
Subject: [PATCH] IXP4xx: Ensure index is positive
In-Reply-To: <m3eiofl2v8.fsf@intrepid.localdomain>
References: <4AF08014.4000704@gmail.com> <4AF0922B.3030701@hiramoto.org>
	<m3eiofl2v8.fsf@intrepid.localdomain>
Message-ID: <4AF0A92C.6050400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The indexes were signed, so negatives were possible.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Op 03-11-09 22:23, Krzysztof Halasa schreef:
> Karl Hiramoto <karl@hiramoto.org> writes:

>> changing npe_request() to unsigned would probably be better

> Right. Both files in fact.
> 
> Even the id < NPE_COUNT test is probably not needed but I can imagine
> someone lowering NPE_COUNT. Negative values are unreasonable (though
> unsigned type make this unrelevant, of course).

 arch/arm/mach-ixp4xx/common.c            |    2 +-
 arch/arm/mach-ixp4xx/include/mach/gpio.h |    2 +-
 arch/arm/mach-ixp4xx/include/mach/npe.h  |    2 +-
 arch/arm/mach-ixp4xx/ixp4xx_npe.c        |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Is this ok?

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index cfd52fb..3bbf40f 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -117,7 +117,7 @@ int gpio_to_irq(int gpio)
 }
 EXPORT_SYMBOL(gpio_to_irq);
 
-int irq_to_gpio(int irq)
+int irq_to_gpio(unsigned int irq)
 {
 	int gpio = (irq < 32) ? irq2gpio[irq] : -EINVAL;
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
index cd5aec2..a5f87de 100644
--- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
+++ b/arch/arm/mach-ixp4xx/include/mach/gpio.h
@@ -70,7 +70,7 @@ static inline void gpio_set_value(unsigned gpio, int value)
 #include <asm-generic/gpio.h>			/* cansleep wrappers */
 
 extern int gpio_to_irq(int gpio);
-extern int irq_to_gpio(int gpio);
+extern int irq_to_gpio(unsigned int irq);
 
 #endif
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/npe.h b/arch/arm/mach-ixp4xx/include/mach/npe.h
index 37d0511..e320db2 100644
--- a/arch/arm/mach-ixp4xx/include/mach/npe.h
+++ b/arch/arm/mach-ixp4xx/include/mach/npe.h
@@ -33,7 +33,7 @@ int npe_send_message(struct npe *npe, const void *msg, const char *what);
 int npe_recv_message(struct npe *npe, void *msg, const char *what);
 int npe_send_recv_message(struct npe *npe, void *msg, const char *what);
 int npe_load_firmware(struct npe *npe, const char *name, struct device *dev);
-struct npe *npe_request(int id);
+struct npe *npe_request(unsigned id);
 void npe_release(struct npe *npe);
 
 #endif /* __IXP4XX_NPE_H */
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
index 47ac69c..e8bb257 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_npe.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
@@ -665,7 +665,7 @@ err:
 }
 
 
-struct npe *npe_request(int id)
+struct npe *npe_request(unsigned id)
 {
 	if (id < NPE_COUNT)
 		if (npe_tab[id].valid)
