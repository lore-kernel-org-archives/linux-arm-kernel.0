From: benjamin.widawsky@intel.com (Ben Widawsky)
Date: Tue, 21 Jan 2014 11:05:20 -0800
Subject: [Intel-gfx] [PATCH 1/2] drm: share drm_add_fake_info_node
In-Reply-To: <20140115234222.GA4770@phenom.ffwll.local>
References: <1389708847-25038-1-git-send-email-benjamin.widawsky@intel.com>
 <20140114232510.GV4770@phenom.ffwll.local>
 <20140114234018.GK15937@n2100.arm.linux.org.uk>
 <CAKMK7uF0kFCsc=3Ny_BMPwDd1fqpY-D6baRRBe0Z8DBKcdGHhg@mail.gmail.com>
 <CAKMK7uE7CSh1gcs341ji6duRH_FgNDhoMfZNc=4hoYf-an1M=w@mail.gmail.com>
 <20140115200819.GB1210@bwidawsk.net>
 <20140115234222.GA4770@phenom.ffwll.local>
Message-ID: <20140121190520.GA10927@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:42:22AM +0100, Daniel Vetter wrote:
> On Wed, Jan 15, 2014 at 12:08:19PM -0800, Ben Widawsky wrote:
> > On Wed, Jan 15, 2014 at 09:45:28AM +0100, Daniel Vetter wrote:
> > > On Wed, Jan 15, 2014 at 9:39 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > On Wed, Jan 15, 2014 at 12:40 AM, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > >> On Wed, Jan 15, 2014 at 12:25:10AM +0100, Daniel Vetter wrote:
> > > >>> On Tue, Jan 14, 2014 at 06:14:06AM -0800, Ben Widawsky wrote:
> > > >>> > Both i915 and Armada had the exact same implementation. For an upcoming
> > > >>> > patch, I'd like to call this function from two different source files in
> > > >>> > i915, and having it available externally helps there too.
> > > >>> >
> > > >>> > While moving, add 'debugfs_' to the name in order to match the other drm
> > > >>> > debugfs helper functions.
> > > >>> >
> > > >>> > Cc: linux-arm-kernel at lists.infradead.org
> > > >>> > Cc: intel-gfx at lists.freedesktop.org
> > > >>> > Signed-off-by: Ben Widawsky <ben@bwidawsk.net>
> > > >>>
> > > >>> drm_debugfs_create_files in drm_debugfs.c has the almost same code again.
> > > >>> Now the problem here is that the interface is a bit botched up, since all
> > > >>> the users in i915 and armada actaully faile to clean up teh debugfs dentry
> > > >>> if drm_add_fake_info_node.
> > > >>
> > > >> That's not correct - armada does clean up these, I think you need to
> > > >> take a closer look at the code.
> > > >>
> > > >> We do this by setting node->info_ent to the file operations structure,
> > > >> which is a unique key to the file being registered.
> > > >>
> > > >> Upon failure to create the fake node, we appropriately call
> > > >> drm_debugfs_remove_files() with the first argument being a pointer to
> > > >> the file operations.  This causes drm_debugfs_remove_files() to match
> > > >> the fake entry, call debugfs_remove() on the dentry, and remove the
> > > >> node from the list, and free the node structure we allocated.
> > > >>
> > > >> Upon driver teardown, we also call drm_debugfs_remove_files() but with
> > > >> each fops which should be registered, thus cleaning up each fake node
> > > >> which was created.
> > > >>
> > > >> So, Armada does clean up these entries properly.
> > > >
> > > > Indeed I've missed that and it's just i915 that botches this. I still
> > > > think the helper would be saner if it cleans up all its leftovers in
> > > > the failure case.
> > > 
> > > Ok, now I've actually page all the stuff back in - if
> > > drm_add_fake_info_node fails we don't set up a drm_info_node structure
> > > and link it anywhere. Which means drm_debugfs_remove_files won't ever
> > > find it and hence can't possibly call debugfs_remove. Which means the
> > > debugfs dentry is leaked. So I think the semantics of that new debugfs
> > > helper should get fixed to also allocate and clean up the debugfs
> > > node.
> > > 
> > > I agree that i915 is even worse since it doesn't bother to clean up
> > > any debugfs files at all in the failure case.
> > > -Daniel
> > > -- 
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > 
> > Perhaps I don't understand what you want here. The only failure path in
> > the fake entry creation does already call debugfs_remove.
> > 
> >         if (node == NULL) {
> >                 debugfs_remove(ent);
> >                 return -ENOMEM;
> >         }
> > 
> > So long as the function succeeds, the node will be findable and removable.
> 
> Oh dear, I didn't see that. Still stand by my opinion though that we
> should shovel the debugfs_create_file into the helper - callers allocating
> something and then the helper freeing it (but only if it fails) is rather
> funky semantics.
> -Daniel

This actually falls apart for the one usage I originally cared about.
For CRC, we store our own info structure instead of fops as the key in
the drm debug list. Therefore, it doesn't align with the usage in ours
or other drivers. One option is to make the helper function take both a
fops as well as a key (an ugly interface if you ask me).

I've already written the patches as you wanted, so I can submit them -
it's just unfortunate that the duplication I was hoping to get rid of
will need to remain.

-- 
Ben Widawsky, Intel Open Source Technology Center
