From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 19:42:27 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308175023.GE4094@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303081541.29410.arnd@arndb.de>
 <20130308175023.GE4094@obsidianresearch.com>
Message-ID: <201303081942.27233.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013, Jason Gunthorpe wrote:
> Right, so taking these two paragraphs together - if you have an absent
> ranges you are imagining that the mbus driver would write out a new
> fully populated ranges to the DTB? That would be necessary to keep
> of_address_translate working.
> 
> If so we are talking about exactly the same thing - the in memory DTB
> would still have working address translation.
> 
> An absent ranges makes some sense from a spec perspective - however do we
> have the kernel infrastructure to grow an in memory DTB node?

I don't think it's necessary to amend the flattened DT in the DTB form,
although that could be done if necessary. Once we have the live DT data
structures, after calling unflatten_device_tree(), we can trivially call
of_add_property() to add the ranges.

I think the nicest boot sequence here would be to have an early driver
bind of the MBUS, which assigns all the windows, adds the ranges property
and then calls of_platform_populate to create all the child platform
devices from the tree. If we need any of the MBUS children before
initcalls, we can also move that stage earlier and set up the mbus
windows from the machine_init callback.

	Arnd
