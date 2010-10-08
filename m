From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 15:22:07 +0900
Subject: missing definition of 's3c_gpio_getpull' function in
	'plat-samsung'
In-Reply-To: <000301cb66af$276b8960$76429c20$@com>
References: <000301cb66af$276b8960$76429c20$@com>
Message-ID: <00e201cb66b1$27f519d0$77df4d70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daein Moon wrote:
> 
> Hi Ben Dooks and Kukjin,
> 
Hi,

> I found an issue about s3c_gpio_getpull API.
> 
> The 'plat-samsung' provides 's3c_gpio_setpull' and 's3c_gpio_getpull'
> to set and get pull-{none|up|down} of GPIO. But there is no
> 's3c_gpio_getpull' definition in 'arch/arm/plat-samsung/gpio-config.c',
> and there is only declaration in the corresponding header file.
> 
> 's3c_gpio_getpull' isn't supported/used. So if providing this api, its
> definition should be inserted.
> 
> Otherwise, code that is used to provide s3c_gpio_getpull including
> following code should be removed.
> 
> arch/arm/plat-samsung/include/plat/gpio-cfg.h:
> 	extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
> 
> arch/arm/mach-{s3c*|s5p*}/gpiolib.c:
>         .get_pull       = s3c_gpio_getpull_updown,
> 
> 
> What do you think about that?:
> 

Hmm...
I found s3c_gpio_getpull_updown() in plat-samsung/gpio-config.c like below.

220 s3c_gpio_pull_t s3c_gpio_getpull_updown(struct s3c_gpio_chip *chip,
221                                         unsigned int off)
222 {
223         void __iomem *reg = chip->base + 0x08;
224         int shift = off * 2;
225         u32 pup = __raw_readl(reg);
226
227         pup >>= shift;
228         pup &= 0x3;
229         return (__force s3c_gpio_pull_t)pup;
230 }

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
