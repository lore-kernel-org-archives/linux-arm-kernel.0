From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 19 May 2011 19:38:27 +0800
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTi=poU17RqAzp28CPjWHrN_+aFiyag@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=poU17RqAzp28CPjWHrN_+aFiyag@mail.gmail.com>
Message-ID: <BANLkTindee6UMez8HyBUwd2H6mN-DknzPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -arch_initcall(u300_gpio_init);
> -module_exit(u300_gpio_exit);
>
looks like the driver can't be a real module, is the module_exit
suitable? it looks strange module_exit plays together with
arch_initcall.
guess symbol u300_gpio_exit will finally lose in the last vmlinux
since it is in exit section and built-in kernel.

another problem i see is after moving gpio/pinmux to drivers as
platform device, codes in arch/arm/plat(mach) can't  call gpio/pinmux
api before the related platform devices registerred. that will
required these platform devices enter system earlier.
