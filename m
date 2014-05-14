From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 14 May 2014 11:25:49 +0100
Subject: [PATCH] of: Add of_device_destroy_children() function
In-Reply-To: <20140508203339.GA542@obsidianresearch.com>
References: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
 <20140508203339.GA542@obsidianresearch.com>
Message-ID: <20140514102549.EEEF9C4153D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 May 2014 14:33:39 -0600, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> On Thu, May 08, 2014 at 06:37:49PM +0200, Sylwester Nawrocki wrote:
> > This patch adds a helper function to unregister devices which
> > were created by an of_platform_populate() call. The pattern
> > used here can already be found in multiple drivers. This helper
> > can now be used instead of repeating similar code in drivers.
> 
> I have a driver that does this as well, and what I found is that the
> remove must be in reverse order from the create or things explode, and
> that assumes the DT is topologically sorted according to dependency
> (so no deferred probe).

That is the tip of a much larger problem that we don't have any good way
to solve. There is no dependency tracking beyond the nature Linux driver
model tree. For example, the removal of a GPIO driver has no way to
tell users that it is going away, and so there is no way to force a
driver remove when it happens.

If we created a managed api for requesting resource (ie.
devm_request_gpio()), then it would be possible for the gpio core to
force a remove event on any driver that doesn't have the ability to
gracefully handle a remove.

The exact same problem exists for IRQs, clocks, regulators, or pretty
much any cross-tree dependency.  :-(

> AFAIK, there is no analog to deferred probe for removal, and
> attempting to remove, say, a GPIO driver while an I2C bit bang is using
> it just fails.

Indeed, it is a completely different operation.

g.
