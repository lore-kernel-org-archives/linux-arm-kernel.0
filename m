From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Jun 2011 11:40:42 +0100
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <037201cc2046$f5cc53b0$e164fb10$@com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<037201cc2046$f5cc53b0$e164fb10$@com>
Message-ID: <20110601104042.GA15387@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 07:30:42PM +0900, Sangbeom Kim wrote:
> Hi, Mark

Don't top post.

> 800Mhz S3C6410 is only supplied by customer request.
> 800Mhz dvfs operation should be controlled carefully.
> (Stable VDD_ARM should be supplied)

The fact that the chip is only on limited distribution isn't really an
issue for supporting it in mainline - many CPUs currently supported in
Linux, including some Samsung ones, are only available to certain
customers.

Similarly, stable power supplies are a basic system design thing that
we shouldn't be worrying about here.

> To optimize s3c6410 dvfs operation, not only ARMCLK
> But also HCLK should do dvfs.
> In other words, VDD_INT, as well as VDD_ARM should be controlled.

I don't have any access to documentation on this part here and in any
case we've already got code in mainline which is doing DVFS on S3C6410
without varying VDD_INT so that's a bit of a moot point.  We need to add
the 800MHz support in order to have the existing code understand the
state the device boots up in on the system I'm currently working with,
never mind actually change anything at runtime.  

As things stand the system will boot and then immediately scale the
voltage down to 400MHz as it's the only supported rate for 800MHz (we're
only doing scaling by division of the ARM clock) so adding the operating
point for 800MHz at least means that the performance governor will do
the right thing.
