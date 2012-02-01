From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 1 Feb 2012 15:59:02 +0000 (GMT)
Subject: reboot/suspend regression: hx4700 freezes under linux-3.3-rc1
In-Reply-To: <20120131175905.GA8338@n2100.arm.linux.org.uk>
Message-ID: <1328111942.20825.YahooMailClassic@web29005.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Tue, 31/1/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Jan 31, 2012 at 05:28:10PM
> +0000, Paul Parsons wrote:
> > Both reboot (via reboot(RB_AUTOBOOT)) and suspend (via
> apm --suspend)
> > freeze my hx4700 under linux-3.3-rc1. They both worked
> under linux-3.2.
> > 
> > I presume that at least the reboot freeze is related to
> the restart
> > changes back in November. Can anyone suggest anything
> obvious I
> > should check? If not I'll attempt to get console output
> on to the
> > screen, which may or may not help.
> 
> I'd also suggest trying to bisect them to find out exactly
> which
> commit caused the problem.

OK, I found the reboot bug:

register_syscore_ops(&pxa_gpio_syscore_ops);

is called in two different places. This corrupts syscore_ops_list and
causes syscore_shutdown() to enter an infinite loop.

The fix is to remove the extra call added since 3.2:

--- clean-3.3-rc1/drivers/gpio/gpio-pxa.c	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/drivers/gpio/gpio-pxa.c	2012-02-01 15:37:39.060989857 +0000
@@ -606,10 +606,3 @@
 	.suspend	= pxa_gpio_suspend,
 	.resume		= pxa_gpio_resume,
 };
-
-static int __init pxa_gpio_sysinit(void)
-{
-	register_syscore_ops(&pxa_gpio_syscore_ops);
-	return 0;
-}
-postcore_initcall(pxa_gpio_sysinit);

The suspend bug is alas unrelated.
