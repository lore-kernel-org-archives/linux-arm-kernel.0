From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 7 Mar 2012 19:12:28 +0800
Subject: [PATCH v3] MM: CMA: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <op.wasrgptm3l0zgt@mpn-glaptop>
References: <1331090098-25097-1-git-send-email-Barry.Song@csr.com>
 <op.wasrgptm3l0zgt@mpn-glaptop>
Message-ID: <CAGsJ_4ze8V0g0VKBKnfMeKoo_PBpEk86mB7-=L32A5jB65Qa0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/7 Michal Nazarewicz <mina86@mina86.com>:
> Thanks! ?Some minor comments, hopefully last ones:
>
>
> On Wed, 07 Mar 2012 04:14:58 +0100, Barry Song <Barry.Song@csr.com> wrote:
>>
>> +static ssize_t
>> +cma_test_read(struct file *file, char __user *buf, size_t count, loff_t
>> *ppos)
>> +{
>
>
> [...]
>
>
>> + ? ? ? _dev_info(cma_dev, "free: CM virt: %p dma: %p size:%uK\n",
>
>
> This should read: ?size: %zuK?. ??z? is the proper modifier to use for
> size_t type.

ok. thanks.

>
>
>> + ? ? ? ? ? ? ? alloc->virt, (void *)alloc->dma, alloc->size / SZ_1K);
>> + ? ? ? kfree(alloc);
>> +
>> + ? ? ? return 0;
>> +}
>
>
>> +static ssize_t
>> +cma_test_write(struct file *file, const char __user *buf, size_t count,
>> loff_t *ppos)
>> +{
>> + ? ? ? struct cma_allocation *alloc;
>> + ? ? ? size_t size;
>> + ? ? ? int ret;
>> +
>> + ? ? ? ret = kstrtouint_from_user(buf, count, 0, &size);
>
>
> kstrtouint_from_user() expects pointer to unsigned int, size_t is not always
> unsigned int. ?It may be unsigned long. ?As such, size should be of type
> unsigned long and this line should use kstrtoulong_from_user().

it comes to a compiling warning, so re-define "size" to unsigned long:

cma_test_write(struct file *file, const char __user *buf, size_t
count, loff_t *ppos)
 {
        struct cma_allocation *alloc;
-       size_t size;
+       unsigned long size;
        int ret;

-       ret = kstrtouint_from_user(buf, count, 0, &size);
+       ret = kstrtoul_from_user(buf, count, 0, &size);
        if (ret)
                return ret;

@@ -86,8 +86,8 @@ cma_test_write(struct file *file, const char __user
*buf, size_t count, loff_t *
                &alloc->dma, GFP_KERNEL);

        if (alloc->virt) {
-               _dev_info(cma_dev, "alloc: virt: %p dma: %p size: %uK\n",
-                       alloc->virt, (void *)alloc->dma, size);
+               _dev_info(cma_dev, "alloc: virt: %p dma: %p size: %zuK\n",
+                       alloc->virt, (void *)alloc->dma, alloc->size / SZ_1K);

                spin_lock(&cma_lock);
                list_add_tail(&alloc->list, &cma_allocations);

>
> [...]
>
>
>> + ? ? ? if (alloc->virt) {
>> + ? ? ? ? ? ? ? _dev_info(cma_dev, "alloc: virt: %p dma: %p size: %uK\n",
>> + ? ? ? ? ? ? ? ? ? ? ? alloc->virt, (void *)alloc->dma, size);
>
>
> Like previously, this should be ?size: %zuK?.
>
> [...]
>
>> +}
>
>
> --
> Best regards, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? _ ? ? _
> .o. | Liege of Serenely Enlightened Majesty of ? ? ?o' \,=./ `o
> ..o | Computer Science, ?Micha? ?mina86? Nazarewicz ? ?(o o)
> ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--

-barry
