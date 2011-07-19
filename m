From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Jul 2011 16:56:05 +0800
Subject: [PATCH 1/2] Input: gpio-keys: do not reference platform_data
	after .probe exits
In-Reply-To: <20110719074841.GB26574@n2100.arm.linux.org.uk>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
	<1311007508-8096-2-git-send-email-shawn.guo@linaro.org>
	<201107181002.45170.dmitry.torokhov@gmail.com>
	<20110719011725.GB3838@S2100-06.ap.freescale.net>
	<20110719074841.GB26574@n2100.arm.linux.org.uk>
Message-ID: <20110719085604.GI3838@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 08:48:41AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 19, 2011 at 09:17:26AM +0800, Shawn Guo wrote:
> > On Mon, Jul 18, 2011 at 10:02:44AM -0700, Dmitry Torokhov wrote:
> > > On Monday, July 18, 2011 09:45:07 AM Shawn Guo wrote:
> > > > The patch makes a copy of platform data into driver data, so that any
> > > > reference to platform_data after .probe exits can be avoided.
> > > 
> > > And why is this beneficial? I am of the opinion that platform data should
> > > stay on (and be accessed through a const pointer to ensure that the driver
> > > will not alter it).
> > > 
> > To me, it's a common sense that platform data should not be referenced
> > after .probe exits, so that any platform code providing the data can
> > claim the data as __initconst.
> 
> That's totally buggered, and that's putting it kindly.
> 
Well, you can tell I'm an idiot, but I was not trying to do what you
say here.

> Consider a driver built as a module, vs built-in.  If you build it as a
> module, your driver data is stale by the time you insert the module.
> It's not much better with it built-in - if you have hotplug enabled, you
> can unbind and rebind the driver, which means that the .probe function
> can be called long after the .init sections have been discarded.
> 
> So no, this is no justification for the patch.
> 
> Don't *ever* make any platform devices or any data pointed to by a
> platform device discardable after init time.  It's an oops waiting to
> happen.
> 
Something learnt.  Thanks, Russell.

-- 
Regards,
Shawn
