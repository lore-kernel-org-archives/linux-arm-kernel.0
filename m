From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 8 Nov 2015 22:07:00 -0500
Subject: [PATCH V3 3/4] dmaselftest: add memcpy selftest support functions
In-Reply-To: <CAHp75VfS6iCYcWeFmbK2PEUYLntQQRdsmN=7gttFpOn=CfrSZg@mail.gmail.com>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
 <CAHp75VfS6iCYcWeFmbK2PEUYLntQQRdsmN=7gttFpOn=CfrSZg@mail.gmail.com>
Message-ID: <56400DD4.5080506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/8/2015 3:09 PM, Andy Shevchenko wrote:
> On Sun, Nov 8, 2015 at 6:52 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> This patch adds supporting utility functions
>> for selftest. The intention is to share the self
>> test code between different drivers.
>>
>> Supported test cases include:
>> 1. dma_map_single
>> 2. streaming DMA
>> 3. coherent DMA
>> 4. scatter-gather DMA
>
> All below comments about entire file, please check and update.
>
>> +struct test_result {
>> +       atomic_t counter;
>> +       wait_queue_head_t wq;
>> +       struct dma_device *dmadev;
>
> dmadev -> dma.
>

Done.

>> +};
>> +
>> +static void dma_selftest_complete(void *arg)
>> +{
>> +       struct test_result *result = arg;
>> +       struct dma_device *dmadev = result->dmadev;
>> +
>> +       atomic_inc(&result->counter);
>> +       wake_up(&result->wq);
>> +       dev_dbg(dmadev->dev, "self test transfer complete :%d\n",
>> +               atomic_read(&result->counter));
>> +}
>> +
>> +/*
>> + * Perform a transaction to verify the HW works.
>> + */
>> +static int dma_selftest_sg(struct dma_device *dmadev,
>
> dmdev -> dma
>
ok

>> +                       struct dma_chan *dma_chanptr, u64 size,
>
> dma_chanptr -> chan

ok

>
>> +                       unsigned long flags)
>> +{
>> +       dma_addr_t src_dma, dest_dma, dest_dma_it;
>
> src_dma -> src, dest_dma_it -> dst ?

ok

>
>> +       u8 *dest_buf;
>
> Perhaps put nearby src_buf definition?

ok
>
>> +       u32 i, j = 0;
>
> unsigned int

why?

>
>> +       dma_cookie_t cookie;
>> +       struct dma_async_tx_descriptor *tx;
>
>> +       int err = 0;
>> +       int ret;
>
> Any reason to have two instead of one of similar meaning?
>

removed ret

>> +       struct sg_table sg_table;
>> +       struct scatterlist      *sg;
>> +       int nents = 10, count;
>> +       bool free_channel = 1;
>> +       u8 *src_buf;
>> +       int map_count;
>> +       struct test_result result;
>
> Hmm? Maybe make names shorter?
>
>> +
>> +       init_waitqueue_head(&result.wq);
>> +       atomic_set(&result.counter, 0);
>> +       result.dmadev = dmadev;
>> +
>> +       if (!dma_chanptr)
>> +               return -ENOMEM;
>> +
>> +       if (dmadev->device_alloc_chan_resources(dma_chanptr) < 1)
>
>
>> +               return -ENODEV;
>> +
>> +       if (!dma_chanptr->device || !dmadev->dev) {
>> +               dmadev->device_free_chan_resources(dma_chanptr);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = sg_alloc_table(&sg_table, nents, GFP_KERNEL);
>> +       if (ret) {
>> +               err = ret;
>> +               goto sg_table_alloc_failed;
>> +       }
>> +
>> +       for_each_sg(sg_table.sgl, sg, nents, i) {
>> +               u64 alloc_sz;
>> +               void *cpu_addr;
>> +
>> +               alloc_sz = round_up(size, nents);
>> +               do_div(alloc_sz, nents);
>> +               cpu_addr = kmalloc(alloc_sz, GFP_KERNEL);
>> +
>> +               if (!cpu_addr) {
>> +                       err = -ENOMEM;
>> +                       goto sg_buf_alloc_failed;
>> +               }
>> +
>> +               dev_dbg(dmadev->dev, "set sg buf[%d] :%p\n", i, cpu_addr);
>> +               sg_set_buf(sg, cpu_addr, alloc_sz);
>> +       }
>> +
>> +       dest_buf = kmalloc(round_up(size, nents), GFP_KERNEL);
>> +       if (!dest_buf) {
>> +               err = -ENOMEM;
>> +               goto dst_alloc_failed;
>> +       }
>> +       dev_dbg(dmadev->dev, "dest:%p\n", dest_buf);
>> +
>> +       /* Fill in src buffer */
>> +       count = 0;
>> +       for_each_sg(sg_table.sgl, sg, nents, i) {
>> +               src_buf = sg_virt(sg);
>> +               dev_dbg(dmadev->dev,
>> +                       "set src[%d, %d, %p] = %d\n", i, j, src_buf, count);
>> +
>> +               for (j = 0; j < sg_dma_len(sg); j++)
>> +                       src_buf[j] = count++;
>> +       }
>> +
>> +       /* dma_map_sg cleans and invalidates the cache in arm64 when
>> +        * DMA_TO_DEVICE is selected for src. That's why, we need to do
>> +        * the mapping after the data is copied.
>> +        */
>> +       map_count = dma_map_sg(dmadev->dev, sg_table.sgl, nents,
>> +                               DMA_TO_DEVICE);
>> +       if (!map_count) {
>> +               err =  -EINVAL;
>> +               goto src_map_failed;
>> +       }
>> +
>> +       dest_dma = dma_map_single(dmadev->dev, dest_buf,
>> +                               size, DMA_FROM_DEVICE);
>> +
>> +       err = dma_mapping_error(dmadev->dev, dest_dma);
>> +       if (err)
>> +               goto dest_map_failed;
>> +
>> +       /* check scatter gather list contents */
>> +       for_each_sg(sg_table.sgl, sg, map_count, i)
>> +               dev_dbg(dmadev->dev,
>> +                       "[%d/%d] src va=%p, iova = %pa len:%d\n",
>> +                       i, map_count, sg_virt(sg), &sg_dma_address(sg),
>> +                       sg_dma_len(sg));
>> +
>> +       dest_dma_it = dest_dma;
>> +       for_each_sg(sg_table.sgl, sg, map_count, i) {
>> +               src_buf = sg_virt(sg);
>> +               src_dma = sg_dma_address(sg);
>> +               dev_dbg(dmadev->dev, "src_dma: %pad dest_dma:%pad\n",
>> +                       &src_dma, &dest_dma_it);
>> +
>> +               tx = dmadev->device_prep_dma_memcpy(dma_chanptr, dest_dma_it,
>> +                               src_dma, sg_dma_len(sg), flags);
>> +               if (!tx) {
>> +                       dev_err(dmadev->dev,
>> +                               "Self-test sg failed, disabling\n");
>> +                       err = -ENODEV;
>> +                       goto prep_memcpy_failed;
>> +               }
>> +
>> +               tx->callback_param = &result;
>> +               tx->callback = dma_selftest_complete;
>> +               cookie = tx->tx_submit(tx);
>> +               dest_dma_it += sg_dma_len(sg);
>> +       }
>> +
>> +       dmadev->device_issue_pending(dma_chanptr);
>> +
>> +       /*
>> +        * It is assumed that the hardware can move the data within 1s
>> +        * and signal the OS of the completion
>> +        */
>> +       ret = wait_event_timeout(result.wq,
>> +               atomic_read(&result.counter) == (map_count),
>> +                               msecs_to_jiffies(10000));
>> +
>> +       if (ret <= 0) {
>> +               dev_err(dmadev->dev,
>> +                       "Self-test sg copy timed out, disabling\n");
>> +               err = -ENODEV;
>> +               goto tx_status;
>> +       }
>> +       dev_dbg(dmadev->dev,
>> +               "Self-test complete signal received\n");
>> +
>> +       if (dmadev->device_tx_status(dma_chanptr, cookie, NULL) !=
>> +                               DMA_COMPLETE) {
>> +               dev_err(dmadev->dev,
>> +                       "Self-test sg status not complete, disabling\n");
>> +               err = -ENODEV;
>> +               goto tx_status;
>> +       }
>> +
>> +       dma_sync_single_for_cpu(dmadev->dev, dest_dma, size,
>> +                               DMA_FROM_DEVICE);
>> +
>> +       count = 0;
>> +       for_each_sg(sg_table.sgl, sg, map_count, i) {
>> +               src_buf = sg_virt(sg);
>> +               if (memcmp(src_buf, &dest_buf[count], sg_dma_len(sg)) == 0) {
>> +                       count += sg_dma_len(sg);
>> +                       continue;
>> +               }
>> +
>> +               for (j = 0; j < sg_dma_len(sg); j++) {
>> +                       if (src_buf[j] != dest_buf[count]) {
>> +                               dev_dbg(dmadev->dev,
>> +                               "[%d, %d] (%p) src :%x dest (%p):%x cnt:%d\n",
>> +                                       i, j, &src_buf[j], src_buf[j],
>> +                                       &dest_buf[count], dest_buf[count],
>> +                                       count);
>> +                               dev_err(dmadev->dev,
>> +                                "Self-test copy failed compare, disabling\n");
>> +                               err = -EFAULT;
>> +                               return err;
>> +                               goto compare_failed;
>
> Here something wrong.

removed the return.
>
>> +                       }
>> +                       count++;
>> +               }
>> +       }
>> +

thanks

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
