From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 21:15:20 -0600
Subject: [RFC PATCH 3/3] Enable BCM2835 mailbox support
In-Reply-To: <5232F7D8.6080307@yahoo.com.au>
References: <5232F7D8.6080307@yahoo.com.au>
Message-ID: <524B8FC8.20603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 05:32 AM, Craig McGeachie wrote:
> Implement BCM2835 CPU thermal sensor support.
> 
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> ---
> 
> Beyond the usual reviews of rubbish code, there are two points
> here that I'm looking for feedback on.
> 
> First is the placement of the mailbox directory make target in
> drivers/Makefile.  I placed it as early as I did in anticipation of
> implemented a frame buffer driver, which needs mailbox support at
> probe time. Another option would be to initialise the driver at
> architecture initialisation time, but I'm unfamiliar with good
> practice about when to initialise different bits and pieces.
> Especially with generic mailbox support looking kinda new.

These days, all drivers should support deferred probe, so that if they
get probe()d and find that resources they need aren't yet available,
they return -EPROBE_DEFER from probe(), and the driver core will call
their probe() again later, when hopefully the resources actually will be
available. Once this works, most drivers will simply use
module_initcall(). This all avoids having to play games with link order
or initcall ordering.
