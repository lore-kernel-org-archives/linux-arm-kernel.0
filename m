From: wim@iguana.be (Wim Van Sebroeck)
Date: Wed, 23 Sep 2009 09:26:13 +0200
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090921145832.GA4211@avionic-design.de>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
	<20090824090407.GA24894@avionic-design.de>
	<20090827202314.GJ29382@infomag.iguana.be>
	<4A96ED32.7000108@billgatliff.com>
	<20090827204448.GL29382@infomag.iguana.be>
	<20090828061108.GA1649@avionic-design.de>
	<20090831115837.GL29382@infomag.iguana.be>
	<20090921145832.GA4211@avionic-design.de>
Message-ID: <20090923072613.GF3929@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

> > I'm still puzzled. I have seen a number of watchdog devices that have the option to either reboot the system or generate an interrupt.
> > They can be set via toggling the correct bits of some configuration register.
> > 
> > How does this hardware works? Is there a datasheet available somewhere?
> 
> It works exactly the same way. The bit defined by ADX_WDT_CONTROL_nRESET
> controls this behaviour. If set, the watchdog will only generate an
> interrupt, if cleared (the default) it will reboot the system.
> 
> There's currently no real datasheet available. The register definitions at
> the top of adx_wdt.c are pretty much all of the documentation we currently
> have, I'm afraid.

I looked at the register definitions and then searched in your code where
the ADX_WDT_CONTROL_nRESET bit of the watchdog device was initialized.
I didn't find it.

So to get this driver in line with how the other drivers work, we should still
do the following:
1) initialize the device at startup so that the ADX_WDT_CONTROL_nRESET is set correctly
(and the device should also be disabled if it isn't done yet).
2) we can get rid of the interrupt handling because we will use the reboot behaviour.

Can you adapt your code?

Thanks in advance,
Wim.
