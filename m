From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 May 2014 11:53:23 +0200
Subject: [PATCH] of: Add of_device_destroy_children() function
In-Reply-To: <20140508203339.GA542@obsidianresearch.com>
References: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
 <20140508203339.GA542@obsidianresearch.com>
Message-ID: <536CA593.3070907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 22:33, Jason Gunthorpe wrote:
> On Thu, May 08, 2014 at 06:37:49PM +0200, Sylwester Nawrocki wrote:
>> This patch adds a helper function to unregister devices which
>> were created by an of_platform_populate() call. The pattern
>> used here can already be found in multiple drivers. This helper
>> can now be used instead of repeating similar code in drivers.
> 
> I have a driver that does this as well, and what I found is that the
> remove must be in reverse order from the create or things explode, and
> that assumes the DT is topologically sorted according to dependency
> (so no deferred probe).
> 
> AFAIK, there is no analog to deferred probe for removal, and
> attempting to remove, say, a GPIO driver while an I2C bit bang is using
> it just fails.

Thanks for the feedback, I knew I could be missing some of nasty
details like this. Looks like we need a complete implementation
of of_platform_unpopulate(). Since the are cases where the remove
order is insignificant, I'm wondering whether it still would be
useful to have a helper like device_unregister_children() which
would remove only direct children of a device ? At least this
solves my current problem.

Since the dependencies will likely never be fully described in DT
I guess we would need to create a list while actually creating
devices, to be able to walk in reverse order while destroying them.

--
Regards,
Sylwester
