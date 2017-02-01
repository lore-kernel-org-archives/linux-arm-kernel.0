From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 1 Feb 2017 14:12:13 -0800
Subject: [PATCH v3] initramfs: finish fput() before accessing any binary
 from initramfs
In-Reply-To: <20170201140540.22051-1-lokeshvutla@ti.com>
References: <20170201140540.22051-1-lokeshvutla@ti.com>
Message-ID: <20170201141213.3cf81a7a3a771ac2b94e8d48@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Feb 2017 19:35:40 +0530 Lokesh Vutla <lokeshvutla@ti.com> wrote:

> commit 4a9d4b024a31 ("switch fput to task_work_add") implements a
> schedule_work() for completing fput(), but did not guarantee calling
> __fput() after unpacking initramfs. Because of this, there is a
> possibility that during boot a driver can see ETXTBSY when it tries
> to load a binary from initramfs as fput() is still pending on that
> binary. This patch makes sure that fput() is completed after unpacking
> initramfs and removes the call to flush_delayed_fput() in kernel_init()
> which happens very late after unpacking initramfs.

There's not really enough info here for others to be able to decide
which kernel versions need the fix.  How serious is the bug?  Given
that it's been there for 4 years, I assume "not very"?
