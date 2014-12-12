From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Dec 2014 10:50:35 -0800
Subject: CCF locking problems
In-Reply-To: <20141212173726.GV11285@n2100.arm.linux.org.uk>
References: <20141212173726.GV11285@n2100.arm.linux.org.uk>
Message-ID: <548B38FB.8060605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2014 09:37 AM, Russell King - ARM Linux wrote:
> CCF is causing lockdep problems elsewhere in the kernel...
>
> During kernel boot, the following lock chain is established via CCF when
> debugfs is enabled:
>
> 	clk_register()
> 	`-> __clk_init() (takes prepare_lock)
> 	    `-> clk_debug_register() (takes clk_debug_lock)
> 	        `-> debugfs_create_dir()
> 	            `-> __create_file() (takes i_mutex)
>
> So, prepare_lock ends up being a parent of the i_mutex class.
>
> Generic kernel code creates a dependency between i_mutex and mmap_sem:
>
> 	iterate_dir() (takes i_mutex)
> 	`-> dcache_readdir()
> 	    `-> filldir64()
> 	        `-> might_fault() (marks mmap_sem as potentially taken by
> 				   a fault)
>
> This means prepare_lock is also a parent lock of mmap_sem.
>
> The kernel mmap() implementation of takes the mmap_sem, before calling
> into drivers.  DRM's drm_gem_mmap() function which will be called as a
> result of a mmap() takes the dev->struct_mutex mutex - which ends up as
> a child of mmap_sem.
>
> Now, if a DRM driver _then_ wants to use runtime PM, it may need to
> call runtime PM functions beneath DRM's dev->struct_mutex (since, eg,
> it may be protecting other DRM data while deciding which GPU to forward
> to.)  This ends up creating a circular dependency between dev->struct_mutex
> and prepare_lock, involving all the above mentioned locks.
>
> I believe it is totally unreasonable for CCF to allow the prepare lock
> to depend on something as fundamental as core kernel locks - in fact,
> looking at __clk_init(), it looks like this fails in a very basic aspect
> of kernel programming: do setup first, then publish.  If it did follow
> that principle, it probably would not need to take the prepare lock
> while calling clk_debug_register(), which would mean that prepare_lock
> would not end up being a parent of potentially a lot of core kernel locks.
>
> When you consider what prepare_lock is supposed to be doing, it's quite
> clear that it should not be a parent to those.
>
> Another interesting point is that clk_debug_create_one() has a comment
> above it which is untrue:
>
> /* caller must hold prepare_lock */
>
> ... except when it's called by clk_debug_init().
>

Do you have a lockdep splat? What kernel version are you running? There
was an earlier report of this that I tried to fix with this commit:

commit 6314b6796e3c070d4c8086b08dfd453a0aeac4cf
Author: Stephen Boyd <sboyd@codeaurora.org>
Date:   Thu Sep 4 23:37:49 2014 -0700

    clk: Don't hold prepare_lock across debugfs creation


but I'm not sure if you have that patch or if more recent changes to the
framework have caused this problem to reoccur. I think I missed the part
where clk_debug_register() is called after clk_debug_init() though, so
perhaps you have clocks that are getting registered after late init?
Here's an untested patch.

----8<-----

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 44cdc47a6cc5..c9430653ddc9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -240,12 +240,13 @@ static const struct file_operations clk_dump_fops = {
 	.release	= single_release,
 };
 
-/* caller must hold prepare_lock */
 static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
 {
 	struct dentry *d;
 	int ret = -ENOMEM;
 
+	lockdep_assert_held(clk_debug_lock);
+
 	if (!clk || !pdentry) {
 		ret = -EINVAL;
 		goto out;
@@ -1944,7 +1945,6 @@ int __clk_init(struct device *dev, struct clk *clk)
 	else
 		clk->rate = 0;
 
-	clk_debug_register(clk);
 	/*
 	 * walk the list of orphan clocks and reparent any that are children of
 	 * this clock
@@ -1979,6 +1979,9 @@ int __clk_init(struct device *dev, struct clk *clk)
 out:
 	clk_prepare_unlock();
 
+	if (!ret)
+		clk_debug_register(clk);
+
 	return ret;
 }
 


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
