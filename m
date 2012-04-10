From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 09:14:26 -0600
Subject: [PATCH] pinctrl: fix build failure on PPC
In-Reply-To: <1334044357-14486-1-git-send-email-linus.walleij@stericsson.com>
References: <1334044357-14486-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F844E52.3080902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2012 01:52 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> commit 23289e6ecc6d ("pinctrl: core device tree mapping table
> parsing support") caused a build failure on PPC:
> 
> drivers/pinctrl/devicetree.c: In function 'dt_free_map':
> drivers/pinctrl/devicetree.c:44:42: error: dereferencing pointer to incomplete type
> drivers/pinctrl/devicetree.c:45:6: error: dereferencing pointer to incomplete type
> drivers/pinctrl/devicetree.c: In function 'dt_to_map_one_config':
> drivers/pinctrl/devicetree.c:140:21: error: dereferencing pointer to incomplete type
> drivers/pinctrl/devicetree.c:141:10: error: dereferencing pointer to incomplete type
> drivers/pinctrl/devicetree.c:146:11: error: dereferencing pointer to incomplete type
> 
> This is probably because the Makefile for pinctrl contains this,
> that makes a small piece of the implementation build and link
> in isolation:
> 
> obj-$(CONFIG_OF)                += devicetree.o
> 
> So let's use some local Kconfig option that depends on both OF
> and PINCTRL so that this file is only compiled if you have
> both enabled.

It seems simpler to just fix the Makefile to only compile the file when
its needed directly, without introducing a new Kconfig option. See
https://lkml.org/lkml/2012/4/3/445.
