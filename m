From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Oct 2010 15:52:24 -0700
Subject: [PATCH v2] Input: Make ADS7846 independent on regulator
In-Reply-To: <AANLkTimTW6v3N9aRA0h15SWXbBc_W0dhpf5rEeqBqGbf@mail.gmail.com>
References: <20100907125335.GD25830@sirena.org.uk>
	<201009091027.18176.marek.vasut@gmail.com>
	<20100909094120.GB1988@rakim.wolfsonmicro.main>
	<4CAACA63.6090202@compulab.co.il>
	<20101005161608.GD19730@core.coreip.homeip.net>
	<20101005164037.GA20555@opensource.wolfsonmicro.com>
	<20101005180703.GD21399@core.coreip.homeip.net>
	<20101005185942.GA22808@opensource.wolfsonmicro.com>
	<20101005203508.7df590db@lxorguk.ukuu.org.uk>
	<AANLkTimTW6v3N9aRA0h15SWXbBc_W0dhpf5rEeqBqGbf@mail.gmail.com>
Message-ID: <20101005225223.GC23315@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 12:09:39AM +0200, Linus Walleij wrote:

> This wrapper function will accept non-existing regulators and
> not treat them as errors. Consumers will have to NULL-check their
> regulators.

No, this is actively unhelpful.  If consumers can null check their
regulators then they can just as well do an IS_ERR() check and if we
just eat null pointers like this then the API doesn't degrade gracefully
when it can't implement things - for example, your regulator_set_voltage() 
will report success when it fails to set a voltage which is going to
upset any consumer that thinks it did actually change the current
voltage.

The existing dummy regulator support already does all this in a manner
which is much less invasive for the core.
