From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 1 Feb 2017 14:54:46 +0530
Subject: [PATCH v2] initramfs: finish fput() before accessing any binary
 from initramfs
In-Reply-To: <20170124053636.30121-1-lokeshvutla@ti.com>
References: <20170124053636.30121-1-lokeshvutla@ti.com>
Message-ID: <f236f0b5-a1c4-2ed4-f41a-c50165f82f8a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Tuesday 24 January 2017 11:06 AM, Lokesh Vutla wrote:
> commit 4a9d4b024a31 ("switch fput to task_work_add") implements a
> schedule_work() for completing fput(), but did not guarantee calling
> __fput() after unpacking initramfs. Because of this, there is a
> possibility that during boot a driver can see ETXTBSY when it tries
> to load a binary from initramfs as fput() is still pending on that
> binary. This patch makes sure that fput() is completed after unpacking
> initramfs.
> 
> Reported-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Link to RFC: https://patchwork.kernel.org/patch/9520539/
> Changes since v1:
> - Moved flush_delayed_fput() before loading default modules.
> 
> Note: Reproduced on TI K2HK EVM. K2HK Queue Manager subsystem driver[1] tries
> to load a firmware from initramfs during boot. Sometimes loading of this
> firmware fails with error ETXTBSY. Digging a bit more observed that
> deny_write_access() is returning ETXTBSY as inode->i_writecount is > 0
> for that file. This is because Unpacking initramfs does a
> get_write_access(from open) but hasn't done put_write_access(from fput)
> as it hasn't been scheduled yet.
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/ti/knav_qmss_queue.c
> 
>  init/initramfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index b32ad7d97ac9..981f286c1d16 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -18,6 +18,7 @@
>  #include <linux/dirent.h>
>  #include <linux/syscalls.h>
>  #include <linux/utime.h>
> +#include <linux/file.h>
>  
>  static ssize_t __init xwrite(int fd, const char *p, size_t count)
>  {
> @@ -647,6 +648,7 @@ static int __init populate_rootfs(void)
>  			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
>  		free_initrd();
>  #endif
> +		flush_delayed_fput();
>  		/*
>  		 * Try loading default modules from initramfs.  This gives
>  		 * us a chance to load before device_initcalls.
> 

Not sure who else to cc here, get_maintainer.pl gives only LKML.
Are there any comments on this patch?

Thanks and regards,
Lokesh
