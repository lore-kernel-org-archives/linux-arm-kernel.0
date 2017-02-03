From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Feb 2017 19:19:11 +0200
Subject: [PATCH v3] initramfs: finish fput() before accessing any binary
 from initramfs
In-Reply-To: <20170201141213.3cf81a7a3a771ac2b94e8d48@linux-foundation.org>
References: <20170201140540.22051-1-lokeshvutla@ti.com>
 <20170201141213.3cf81a7a3a771ac2b94e8d48@linux-foundation.org>
Message-ID: <689e7fdc-8445-2d5f-da2e-116aeb0b9c90@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/17 00:12, Andrew Morton wrote:
> On Wed, 1 Feb 2017 19:35:40 +0530 Lokesh Vutla <lokeshvutla@ti.com> wrote:
>
>> commit 4a9d4b024a31 ("switch fput to task_work_add") implements a
>> schedule_work() for completing fput(), but did not guarantee calling
>> __fput() after unpacking initramfs. Because of this, there is a
>> possibility that during boot a driver can see ETXTBSY when it tries
>> to load a binary from initramfs as fput() is still pending on that
>> binary. This patch makes sure that fput() is completed after unpacking
>> initramfs and removes the call to flush_delayed_fput() in kernel_init()
>> which happens very late after unpacking initramfs.
>
> There's not really enough info here for others to be able to decide
> which kernel versions need the fix.  How serious is the bug?  Given
> that it's been there for 4 years, I assume "not very"?

I think the issue only surfaces with certain timing conditions, and for 
some reason it has been masked for at least us until we noticed this 
with 4.9-lts kernel. The same issue was not detected with earlier 
4.4-lts kernel.

-Tero
