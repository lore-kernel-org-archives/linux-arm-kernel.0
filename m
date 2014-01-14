From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jan 2014 23:40:19 +0000
Subject: [Intel-gfx] [PATCH 1/2] drm: share drm_add_fake_info_node
In-Reply-To: <20140114232510.GV4770@phenom.ffwll.local>
References: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
 <20140114232510.GV4770@phenom.ffwll.local>
Message-ID: <20140114234018.GK15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 12:25:10AM +0100, Daniel Vetter wrote:
> On Tue, Jan 14, 2014 at 06:14:06AM -0800, Ben Widawsky wrote:
> > Both i915 and Armada had the exact same implementation. For an upcoming
> > patch, I'd like to call this function from two different source files in
> > i915, and having it available externally helps there too.
> > 
> > While moving, add 'debugfs_' to the name in order to match the other drm
> > debugfs helper functions.
> > 
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: intel-gfx at lists.freedesktop.org
> > Signed-off-by: Ben Widawsky <ben@bwidawsk.net>
> 
> drm_debugfs_create_files in drm_debugfs.c has the almost same code again.
> Now the problem here is that the interface is a bit botched up, since all
> the users in i915 and armada actaully faile to clean up teh debugfs dentry
> if drm_add_fake_info_node.

That's not correct - armada does clean up these, I think you need to
take a closer look at the code.

We do this by setting node->info_ent to the file operations structure,
which is a unique key to the file being registered.

Upon failure to create the fake node, we appropriately call
drm_debugfs_remove_files() with the first argument being a pointer to
the file operations.  This causes drm_debugfs_remove_files() to match
the fake entry, call debugfs_remove() on the dentry, and remove the
node from the list, and free the node structure we allocated.

Upon driver teardown, we also call drm_debugfs_remove_files() but with
each fops which should be registered, thus cleaning up each fake node
which was created.

So, Armada does clean up these entries properly.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
