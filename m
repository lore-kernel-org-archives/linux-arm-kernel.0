From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 27 Aug 2013 14:37:14 +0300
Subject: trinity: kernel warning at
 drivers/video/omap2/dss/manager-sysfs.c:290
 manager_alpha_blending_enabled_show+0x3c/0x60()
In-Reply-To: <20130821223340.GE25647@n2100.arm.linux.org.uk>
References: <20130821223340.GE25647@n2100.arm.linux.org.uk>
Message-ID: <521C8F6A.5020804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/13 01:33, Russell King - ARM Linux wrote:
> Trinity found this error on OMAP4430SDP using 3.11-rc4:
> 
> WARNING: CPU: 1 PID: 3395 at /home/rmk/git/linux-rmk/drivers/video/omap2/dss/manager-sysfs.c:290 manager_alpha_blending_enabled_show+0x3c/0x60()
> Modules linked in:
> CPU: 1 PID: 3395 Comm: trinity-child1 Not tainted 3.11.0-rc4+ #487
> Backtrace:
> [<c0016ca8>] (dump_backtrace+0x0/0x110) from [<c0016e44>] (show_stack+0x18/0x1c)
>  r6:c03dc0d4 r5:00000009 r4:00000000 r3:00400040
> [<c0016e2c>] (show_stack+0x0/0x1c) from [<c03949ec>] (dump_stack+0x74/0x90)
> [<c0394978>] (dump_stack+0x0/0x90) from [<c0037a68>] (warn_slowpath_common+0x6c/0x8c)
>  r4:00000000 r3:deaef800
> [<c00379fc>] (warn_slowpath_common+0x0/0x8c) from [<c0037aac>] (warn_slowpath_null+0x24/0x2c)
>  r8:dd4eb718 r7:c03dc2a0 r6:dd629f70 r5:dd4eb700 r4:dd4af000
> [<c0037a88>] (warn_slowpath_null+0x0/0x2c) from [<c01e4744>] (manager_alpha_blending_enabled_show+0x3c/0x60)
> [<c01e4708>] (manager_alpha_blending_enabled_show+0x0/0x60) from [<c01e41c0>] (manager_attr_show+0x20/0x2c)
>  r4:de090cd0
> [<c01e41a0>] (manager_attr_show+0x0/0x2c) from [<c0126ee4>] (sysfs_read_file+0xc4/0x14c)
> [<c0126e20>] (sysfs_read_file+0x0/0x14c) from [<c00cef2c>] (do_readv_writev+0x118/0x24c)
> [<c00cee14>] (do_readv_writev+0x0/0x24c) from [<c00cf140>] (vfs_readv+0x68/0x78)
> [<c00cf0d8>] (vfs_readv+0x0/0x78) from [<c00cf19c>] (SyS_readv+0x4c/0x74)
>  r5:00000000 r4:dd5b7700
> [<c00cf150>] (SyS_readv+0x0/0x74) from [<c0013340>] (ret_fast_syscall+0x0/0x48)
> 
> Looking at the code:
> 
> static ssize_t manager_alpha_blending_enabled_show(
>                 struct omap_overlay_manager *mgr, char *buf)
> {
>         struct omap_overlay_manager_info info;
> 
>         mgr->get_manager_info(mgr, &info);
> 
>         WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
> 
> -rw-r--r-- 1 root root 4096 Jan  1 00:01 manager0/alpha_blending_enabled
> -rw-r--r-- 1 root root 4096 Jan  1 00:01 manager1/alpha_blending_enabled
> -rw-r--r-- 1 root root 4096 Jan  1 00:01 manager2/alpha_blending_enabled
> 
> So, any program in userspace can open this sysfs file and on read cause
> the kernel to print a warning and taint itself if there is no ZORDER
> feature?  This is not good kernel programming guys.  Please audit your
> other sysfs files for this bug, thanks.

Well that's ugly. Thanks for reporting. The store part of
alpha_blending_enabled had similar issue, but I didn't find such things
elsewhere in the driver.

I made a fix, below.

 Tomi

Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Tue Aug 27 14:28:03 2013 +0300

    OMAPDSS: fix WARN_ON in 'alpha_blending_enabled' sysfs file
    
    The code handling 'alpha_blending_enabled' sysfs file contains WARN_ONs
    in case the feature is not supported on the current platform. Even
    though only root can write to the file, anyone can read it, thus causing
    the kernel to get tainted and printing an ugly warning.
    
    Instead of having WARN_ONs, return a proper error if the feature is not
    supported.
    
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
    Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>

diff --git a/drivers/video/omap2/dss/manager-sysfs.c b/drivers/video/omap2/dss/manager-sysfs.c
index de7e7b5..37b59fe 100644
--- a/drivers/video/omap2/dss/manager-sysfs.c
+++ b/drivers/video/omap2/dss/manager-sysfs.c
@@ -285,9 +285,10 @@ static ssize_t manager_alpha_blending_enabled_show(
 {
 	struct omap_overlay_manager_info info;
 
-	mgr->get_manager_info(mgr, &info);
+	if(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
+		return -ENODEV;
 
-	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
+	mgr->get_manager_info(mgr, &info);
 
 	return snprintf(buf, PAGE_SIZE, "%d\n",
 		info.partial_alpha_enabled);
@@ -301,7 +302,8 @@ static ssize_t manager_alpha_blending_enabled_store(
 	bool enable;
 	int r;
 
-	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
+	if(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
+		return -ENODEV;
 
 	r = strtobool(buf, &enable);
 	if (r)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/5ec74a4b/attachment-0001.sig>
