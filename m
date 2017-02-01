From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 1 Feb 2017 12:28:38 +0000
Subject: [PATCH v2] initramfs: finish fput() before accessing any binary
 from initramfs
In-Reply-To: <20170124053636.30121-1-lokeshvutla@ti.com>
References: <20170124053636.30121-1-lokeshvutla@ti.com>
Message-ID: <20170201122838.GC27291@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 11:06:36AM +0530, Lokesh Vutla wrote:
> commit 4a9d4b024a31 ("switch fput to task_work_add") implements a
> schedule_work() for completing fput(), but did not guarantee calling
> __fput() after unpacking initramfs. Because of this, there is a
> possibility that during boot a driver can see ETXTBSY when it tries
> to load a binary from initramfs as fput() is still pending on that
> binary. This patch makes sure that fput() is completed after unpacking
> initramfs.

Umm...  Do we want it done in kernel_init(), then?  I have no objections
against calling it in populate_rootfs(), and it looks like a sane place
for that, but I wonder if the old callsite would remain needed after that...
