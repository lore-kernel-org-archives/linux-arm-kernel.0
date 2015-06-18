From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jun 2015 10:57:54 +0100
Subject: [PATCH 00/13] Discover and probe dependencies
In-Reply-To: <55829269.2090309@samsung.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <55829269.2090309@samsung.com>
Message-ID: <20150618095754.GI7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 11:42:01AM +0200, Andrzej Hajda wrote:
> 2. Provider create/register their resources only during probe.
>     It is not always the case - for example componentized drivers in
> probe often
>     calls only component_add, the real initialization is performed in
> bind callback.

bind is called in _a_ probe callback, but it may not be the probe callback
associated with the device.  (It'll be the final component's callback.)

I'm willing to be less critical of componentised drivers claiming their
resources in ->probe _iff_ they separate their data structures, like:

	struct foo_priv {
		void *base;
		struct clk *clk;
		struct dma_chan *chan;
		... other resource data ...;
		struct foo_runtime {
			... runtime data ...
		} rt;
	};

and then, in their bind callback, they memset the foo_runtime structure
to zero, to ensure that the driver always re-binds in the same state as
the first bind.

I've seen too many lax drivers over the years that this is a point I'm
very insistant on: either componentised drivers don't do any resource
claiming in their probe function, or they take steps to ensure non-
resource struct members are properly separated such that they can
guarantee that they aren't going to accidentally use something from a
previous binding.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
