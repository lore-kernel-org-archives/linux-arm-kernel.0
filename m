From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Dec 2011 14:33:19 +0000
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <008101ccb40f$4385c0d0$ca914270$%szyprowski@samsung.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112042156.59990.rjw@sisk.pl>
 <20111204231005.GA4255@opensource.wolfsonmicro.com>
 <201112050115.18489.rjw@sisk.pl>
 <20111205001500.GA10173@opensource.wolfsonmicro.com>
 <02d601ccb400$a19380e0$e4ba82a0$%kim@samsung.com>
 <008101ccb40f$4385c0d0$ca914270$%szyprowski@samsung.com>
Message-ID: <20111206143319.GF17731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 01:04:53PM +0100, Marek Szyprowski wrote:

Please fix your mailer to word wrap at less than 80 columns, I've
reflowed your text for legibility.

> What about similar patches for S5PV210/S5PC110 series and Exynos4?

I don't really have access to these systems (well, I have a Nexus S I
can use but that doesn't boot mainline) and I don't have datasheets so
it's hard for me to actively work on them myself.

> gen_pd based power domain code for Exynos4 have been rejected in favor
> of custom platform-device based power domain drivers. It would be much

Oh, that's very surprising to me - looking at the code it appeared that
it just predated gen_pd, I didn't see anything in there that suggested
an active decision to avoid using it.  What was then thinking there?  Is
this something we can fix by enhancing gen_pd?

> easier to have only one type of the drivers across different Samsung
> SoCs. This will also help to hide some differences between the series
> from the device drivers (clock gating, power management). 

When I looked at the code I'd expected the other SoCs to also transition
over to gen_pd and then start pulling things out from there.

Looking at what you can do on s3c64xx the power domain code looked very
small once you use the gen_pd stuff (which is very nice to use, it
really makes the whole thing very easy) so I'm not sure how much win it
is immediately.  How much win it is long term will depend on where
things get implemented - a lot of the stuff I could tink of doing seemed
like it might be more of a fit for the opp or PM QoS stuff than for the
power domains, with the power domains staying pretty thin and just
providing inputs but perhaps that's not a sensible approach.

The main trick is going to be actually putting the devices into the
power domains which is entertaining as currently every board directly
registers platform devices so it's hard for core code to work out what
Linux knows about.

In terms of the drivers I wasn't expecting to see much impact as the
power domain and runtime PM APIs provide a pretty good abstraction
already - the actual implementation of things is totally transparent to
them.  The only device actively able to use the power domains on the
S3C6410 is the framebuffer and the driver there just worked with the
existing runtime PM code.
