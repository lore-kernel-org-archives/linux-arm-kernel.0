From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Jul 2010 15:05:11 +0100
Subject: [PATCH 2/3] arm: s5pv210: Aquila: add support for MAX8998 PMIC
In-Reply-To: <000001cb1921$d75de060$8619a120$%szyprowski@samsung.com>
References: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
	<1277964466-23891-3-git-send-email-m.szyprowski@samsung.com>
	<20100701122451.GA17698@sirena.org.uk>
	<000001cb1921$d75de060$8619a120$%szyprowski@samsung.com>
Message-ID: <20100701140510.GB8742@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 03:32:17PM +0200, Marek Szyprowski wrote:

> One more question - should I enable the regulators in the driver itself
> or in the platform callback (like a "poweron()" callback)?

I don't understand what you mean by "platform callback".  Normally the
driver would unconditionally use the regulators.

> If I put regulator enabling into the driver how can one make it working
> on a board without regulators (chip powered all the time)? Should the
> driver ignore errors from regulator_get()?

No, check the errors.  The regulator API will stub itself out if it's
not enabled in Kconfig (which will happen on boards where it's not being
used at all), boards using a mixed configuration can use fixed voltage
regulators for static supplies and REGULATOR_DUMMY can also be used.

> What if one regulator needs enabling other to operate properly 
> (parent-child hierarchy)?

Set up supplies for the child regulators in their constraints.  This
isn't heavily tested at the minute but it should do the right thing for
you automatically in the core; if it doesn't work we can fix it up.
