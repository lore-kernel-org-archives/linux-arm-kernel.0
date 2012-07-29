From: miki600@gmail.com (=?utf-8?b?TWlrb8WCYWo=?= Siuda)
Date: Sun, 29 Jul 2012 06:42:28 +0000 (UTC)
Subject: PXA 26x GPIO possible regression in kernel 3.3 and newer
References: <loom.20120728T185108-140@post.gmane.org>
 <1343506998.34469.YahooMailClassic@web171606.mail.ir2.yahoo.com>
Message-ID: <loom.20120729T083200-889@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance <at> yahoo.com> writes:

> 
> Hello Damian,
> 
> oops, although my notes say that the number of PXA builtin
> GPIOs increased from 128 to 192 in 3.3, in fact the change
> was much earlier. It was in 3.3 that ARCH_NR_GPIO was added,
> allowing me to fix the hx4700 GPIO values that had been
> broken since 2.6.32. Apologies for the misleading advice.
> 
> That said, your HTC Blue Angel sounds very similar to the
> PXA270 based iPAQ hx4700. For example both include the asic3.
> But the kernel sources make only one mention of the HTC Blue
> Angel, so I'm wondering if it is a fully supported platform.
>


Hello. This is a funny coincidence, because I also have a BA and I'm from 
Poland, like Damian.

This is an easy fix, and I think it should go mainline.

just add lines to /arch/arm/mach-pxa/pxa25x.c :

static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
	.gpio_set_wake = gpio_set_wake,
};

above pxa25x_devices[] declaration

and add 
pxa_register_device(&pxa_device_gpio, &pxa25x_gpio_info);
in pxa25x_init() before adding devices.

This should fix it. It's interesting that it wasn't there.

And Paul, yes, the Blue Angel is very similiar to iPAQ hx4700.
It has PXA CPU, ASIC3, W100, gpio-keys, etc...
And no, it is not fully supported platform in the kernel.

Have a good day.
