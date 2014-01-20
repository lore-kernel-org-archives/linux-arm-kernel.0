From: tj@kernel.org (Tejun Heo)
Date: Mon, 20 Jan 2014 07:26:25 -0500
Subject: [RFC v3 03/13] ahci-platform: Fix clk enable/disable unbalance
 on suspend/resume
In-Reply-To: <52DC2CF5.5080109@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
 <20140119111412.GA11123@htj.dyndns.org>
 <52DC1DAA.3010403@redhat.com>
 <20140119191554.GB32165@mtj.dyndns.org>
 <52DC2CF5.5080109@redhat.com>
Message-ID: <20140120122625.GB17155@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Sun, Jan 19, 2014 at 08:52:21PM +0100, Hans de Goede wrote:
> And having ahci_resume in ahci_platform.c still doing the clk and power enabling
> before calling into ahci_platform_resume, and drivers overriding the resume method
> need to do their own clk + regulator + whatever setup
> before calling into ahci_platform_resume_controller ?

If the use cases are significant enough, split the base function to
two parts?  The thing which gets really messy down the road is when
common code and callbacks intertwine arbitrarily.  A driver wants an
early exit after overriding a subpart, so if that callback exists,
it's an early exit.  The next driver wants to override something at
slightly different point but still want to proceed with the rest of
the common code, so it adds a new callback which doesn't do early
exit, and so on.  Pretty soon, when you're looking at a driver, it
becomes really difficult what it actually does.  We *HAD* this problem
over and over again with ide and it was a nightmare.

Providing larger, logical overriding points while providing common lib
routines makes understanding what a given driver does a lot easier.
Also, it forces people to think about how the overall API looks and
whether a split of an existing library which require giving the splits
sensible names and semantics is justifiable or if the case at hand is
an one-off thing which can be better served by just open coding it.

> Will get exported from ahci_platform.c and drivers needing to override any of them
> will provide their own platform_driver struct, pointing either to their overrides,
> or for driver methods they don't need to override to the exported function from
> ahci_platform.c ?

Yeah, makes sense to me.

Thanks.

-- 
tejun
