From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2011 11:13:22 +0200 (CEST)
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <4DB10AC0.2000709@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<4DB10AC0.2000709@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1104221107240.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Saravana Kannan wrote:

> On 04/21/2011 12:48 PM, Thomas Gleixner wrote:
> > On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > > From: Jeremy Kerr<jeremy.kerr@canonical.com>
> > > + * @get:	Called by the core clock code when a device driver acquires a
> > > + *		clock via clk_get(). Optional.
> > > + *
> > > + * @put:	Called by the core clock code when a devices driver releases a
> > > + *		clock via clk_put(). Optional.
> > 
> > These callbacks are completely pointless. There are only two non empty
> > implementations in tree:
> > 
> > One does a try_module_get(clk->owner), which should be done in generic
> > code. The other does special clock enabling magic which wants to go to
> > clk->prepare().
> 
> Aren't you kinda contradicting yourself? In the other thread you say that when
> we implement a generic framework, you will have to implement more than what a
> specific arch would need. This seems to be exactly one of those cases. What's
> wrong with it?

Errm, that's why the try_module_get() goes into generic code. Simply
because we can have loadable clock modules and we want proper module
refcounts on them.

The clock enabling magic in mach-u300/ is setting up some registers,
which can be done in the clk->prepare() callback as well. So there is
no point for having an extra step and an extra indirection.

So how am I contradicting myself? By moving useful stuff to the core
and moving hardware specific code to a different callback where it
actually belongs?

And yes a framework will always have more functionality than most
users need, but that's not an excuse to implement arbitrary and
pointless crap.

Thanks,

	tglx
