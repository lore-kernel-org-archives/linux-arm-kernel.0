From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Aug 2012 21:14:34 +0000
Subject: [PATCH 02/14] at91: regroup gpio and pinctrl under a simple-bus
In-Reply-To: <1344603731-32667-2-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <201208182114.35063.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 August 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> -                       pioA: gpio at fffff400 {
> -                               compatible = "atmel,at91rm9200-gpio";
> -                               reg = <0xfffff400 0x100>;
> -                               interrupts = <2 4 1>;
> -                               #gpio-cells = <2>;
> -                               gpio-controller;
> -                               interrupt-controller;
> -                       };
> +                       pinctrl at fffff400 {
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges;
> +                               compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +                               reg = <0xfffff400 0x600>;
> +
> +                               pioA: gpio at fffff400 {
> +                                       compatible = "atmel,at91rm9200-gpio";
> +                                       reg = <0xfffff400 0x200>;
> +                                       interrupts = <2 4 1>;
> +                                       #gpio-cells = <2>;
> +                                       gpio-controller;
> +                                       interrupt-controller;
> +                               };

Hmm, If the node declares itself to be an interrupt-controller, it should
normally have an #interrupt-cells property as well.

Also, I think you should not list the same registers in both the parent
and the children. It's probably better to remove the registers in the
parent node and just refer to the children from the pinctrl driver.
Since the pinctrl device is not really a bus in the sense that devices
connected to it see the same address space, you could have the
registers translated like 

	ranges = <0xfffff400 0 0x600>;


	Arnd
