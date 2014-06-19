From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jun 2014 12:29:55 +0200
Subject: [PATCH v2] clocksource: exynos-mct: Register the timer for stable
 udelay
In-Reply-To: <CADGdYn6YObHdRq6A9-L7qbD+EYiPrwhrKkLwyA5Z=0tDoWUzvA@mail.gmail.com>
References: <1403167145-5267-1-git-send-email-amit.daniel@samsung.com>
 <53A2A936.3070109@linaro.org>
 <CADGdYn6YObHdRq6A9-L7qbD+EYiPrwhrKkLwyA5Z=0tDoWUzvA@mail.gmail.com>
Message-ID: <4808230.DmzmRfAocp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 June 2014 15:51:58 amit daniel kachhap wrote:
> I also didn't want to use macros but used as a last option. you want
> me to put more comments here?
> Or something like below is also possible for checking the size of
> (unsigned long) in runtime.
> 
> unsigned long x;
> unsigned int size = (char *)(&x + 1) - (char *)(&x);

reimplementing "sizeof (long)"?

> if (size == 4)
>            return __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_L);

readl_relaxed(), certainly

> else
>            return exynos4_frc_read(&mct_frc);
> 
> But this involves extra computation which should not be used for time
> critical functions.

sizeof is a constant expression, the compiler will optimize this.

	Arnd
