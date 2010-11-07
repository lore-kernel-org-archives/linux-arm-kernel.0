From: ccross@android.com (Colin Cross)
Date: Sun, 7 Nov 2010 12:38:35 -0800
Subject: [PATCH RFC] ARM ETM driver: Do not deref potentially null pointer
	and don't allocate and free mem while holding lock.
In-Reply-To: <alpine.LNX.2.00.1011071952510.26247@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1011071952510.26247@swampdragon.chaosbits.net>
Message-ID: <AANLkTinJF3uYibP9QNXNU3WavThzkZ17w30+6m2DKgjb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 7, 2010 at 11:12 AM, Jesper Juhl <jj@chaosbits.net> wrote:
> Hello,
>
> Looking at etb_read() in arch/arm/kernel/etm.c I noticed two things.
>
> ?1. We are allocting and freeing 'buf' with vmalloc() while holding a
> ? ?mutex locked. I cannot see any reason why we have to hold the mutex
> ? ?just to allocate and free a bit of memory, so I moved it outside the
> ? ?lock.
>
> ?2. If the memory allocation fails we'll dereference a null pointer
> ? ?further down since we never check the vmalloc() return value.
> ? ? ? ?for (i = 0; i < length / 4; i++)
> ? ? ? ? ? ? ? ?buf[i] = etb_readl(t, ETBR_READMEM);
> ? ?The best way I could find to handle this was to simply return 0 when
> ? ?we can't allocate memory, but there might be a better option that I
> ? ?just couldn't find - in any case it is better than crashing the
> ? ?kernel.
>
> Please consider merging, but please also review carefully first since I'm
> not familliar with this code.
>
> CC me on replies please.
>
>
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
> ?etm.c | ? ?8 +++++---
> ?1 file changed, 5 insertions(+), 3 deletions(-)
>
> ?note: completely untested patch since I have neither hardware nor
> ?toolchain to test it, so please review carefully and test before applying
> ?it.
>
> diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
> index 11db628..30f845b 100644
> --- a/arch/arm/kernel/etm.c
> +++ b/arch/arm/kernel/etm.c
> @@ -274,7 +274,10 @@ static ssize_t etb_read(struct file *file, char __user *data,
> ? ? ? ?long length;
> ? ? ? ?struct tracectx *t = file->private_data;
> ? ? ? ?u32 first = 0;
> - ? ? ? u32 *buf;
> + ? ? ? u32 *buf = vmalloc(length);
You can't move the vmalloc out of the lock, length is uninitialized here

> +
> + ? ? ? if (!buf)
> + ? ? ? ? ? ? ? return 0;
ssize_t is signed so you can return -ENOMEM

> ? ? ? ?mutex_lock(&t->mutex);
>
> @@ -292,7 +295,6 @@ static ssize_t etb_read(struct file *file, char __user *data,
> ? ? ? ?etb_writel(t, first, ETBR_READADDR);
>
> ? ? ? ?length = min(total * 4, (int)len);
> - ? ? ? buf = vmalloc(length);
>
> ? ? ? ?dev_dbg(t->dev, "ETB buffer length: %d\n", total);
> ? ? ? ?dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
> @@ -310,10 +312,10 @@ static ssize_t etb_read(struct file *file, char __user *data,
> ? ? ? ?etb_lock(t);
>
> ? ? ? ?length -= copy_to_user(data, buf, length);
> - ? ? ? vfree(buf);
>
> ?out:
> ? ? ? ?mutex_unlock(&t->mutex);
> + ? ? ? vfree(buf);
>
> ? ? ? ?return length;
> ?}
>
>
>
> --
> Jesper Juhl <jj@chaosbits.net> ? ? ? ? ? ? http://www.chaosbits.net/
> Don't top-post ?http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
