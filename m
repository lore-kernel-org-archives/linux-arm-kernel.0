From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 8 May 2014 14:33:39 -0600
Subject: [PATCH] of: Add of_device_destroy_children() function
In-Reply-To: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
References: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140508203339.GA542@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 06:37:49PM +0200, Sylwester Nawrocki wrote:
> This patch adds a helper function to unregister devices which
> were created by an of_platform_populate() call. The pattern
> used here can already be found in multiple drivers. This helper
> can now be used instead of repeating similar code in drivers.

I have a driver that does this as well, and what I found is that the
remove must be in reverse order from the create or things explode, and
that assumes the DT is topologically sorted according to dependency
(so no deferred probe).

AFAIK, there is no analog to deferred probe for removal, and
attempting to remove, say, a GPIO driver while an I2C bit bang is using
it just fails.

Jason
