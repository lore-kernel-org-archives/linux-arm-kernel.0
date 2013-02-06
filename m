From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Feb 2013 11:52:19 +0000
Subject: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
In-Reply-To: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130206115219.GE17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 07:47:14PM +0800, Haojian Zhuang wrote:
> If uart driver is probed defer, console_setup will be called later
> after __init && __initdata sections destroyed. And amba_console isn't
> defined in __init or __initdata section. So we needn't define
> pl011_console_setup() && pl011_console_get_options() in __init section.

It sounds like there's a deeper problem here - if this driver being
deferred, why isn't it being retried after the pinctrl stuff gets
its driver registered?

We've had bugs in this deferred probing before, I wouldn't be surprised
if there's more... and we should not be "fixing" drivers because of bugs
elsewhere.
