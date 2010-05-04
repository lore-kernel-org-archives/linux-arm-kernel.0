From: chripell@fsfe.org (christian pellegrin)
Date: Tue, 4 May 2010 09:34:01 +0200
Subject: [PATCH v2.6.34-rc2] s3c: Fix GPIOs bank H and J not being
	preserved during suspend on S3C24XX
In-Reply-To: <20100504070111.GC26401@trinity.fluff.org>
References: <1269937386-7597-1-git-send-email-chripell@fsfe.org>
	<20100504070111.GC26401@trinity.fluff.org>
Message-ID: <i2lcabda6421005040034hf27d04f7m95ff2cda9333ff93@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 4, 2010 at 9:01 AM, Ben Dooks <ben-linux@fluff.org> wrote:

>
> could you send the gpio fix with the above change as a seperate patch
> please?
>

Yes, no problem, I'll just wait for the "up-comming s3c2410_gpio
fallout" patches so I can test everything with the new functions.

BTW there is a nastiness in mixing old-style s3c24xx gpios and gpiolib
ones for the J port found in the s3c2440. For the former you have to
use S3C241?_GPJ* macros in regs-gpioj.h, for the later S3C2410_GPJ().
The reason of this is the "hole" in GPIO registers address which
breaks S3C2410_GPIO_BASE. So I'm looking forward for your
reorganization of s3c24xx gpio to see if a patch is needed for this.
Right now I'm using:

diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
index ebc85c6..a2eab90 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
@@ -37,7 +37,16 @@
                                  S3C2400_BASEC2H(pin)+S3C24XX_VA_GPIO)


-#define S3C2410_GPIO_BASE(pin)   ((((pin) & ~31) >> 1) + S3C24XX_VA_GPIO)
+#if !defined(__ASSEMBLER__) && defined(S3C24XX_VA_GPIO)
+static inline void *S3C2410_GPIO_BASE(unsigned int pin)
+{
+	unsigned int off = (pin & ~31) >> 1;
+
+	if ((pin & ~31) == S3C2410_GPIO_J_START)
+		off += 0x50;
+	return S3C24XX_VA_GPIO + off;
+}
+#endif
 #define S3C2410_GPIO_OFFSET(pin) ((pin) & 31)

so if I use, by mistake, S3C2410_GPJ() in s3c2410_gpio_cfgpin I don't
shoot myself in the foot. If I understand you intentions S3C241?_GPJ*
will go away after the mentioned patch series. Anyway I wait for your
reorganization of s3c gpios to resubmit these patches if needed.

Thanks,

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
