From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 11 Feb 2016 13:12:20 +0200
Subject: [PATCH v2] dmaengine: edma: Implement device_synchronize callback
In-Reply-To: <56BC5759.80000@metafoo.de>
References: <1455181722-32099-1-git-send-email-peter.ujfalusi@ti.com>
 <56BC5759.80000@metafoo.de>
Message-ID: <56BC6C94.1060409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2016 11:41 AM, Lars-Peter Clausen wrote:
> On 02/11/2016 10:08 AM, Peter Ujfalusi wrote:
>> We need the callback to support the dmaengine_terminate_sync().
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Looks good, but I noticed a slight race condition in
> edma_completion_handler(). You need to fetch echan->desc while holding the
> vchan.lock. Otherwise this can race against terminate_all() and the callback
> might get scheduled even though terminate_all() completed and then there is
> a race where the synchronize() operation could be called before the callback
> gets scheduled, which means it doesn't do its intended job. Highly unlikely
> to happen, but theoretically possible.

Right, actually I had (have) another series fixing the very same race in a
different way - patching the terminate_all (series attached).
We have seen race with RT kernel on uniprocessor setup.

The tasklet_kill after the terminate_all will execute the scheduled task
unconditionally, so the vchan_complete() will run after we have terminated the
channel, which might be not what we want.
I have also seen a race condition as explained in the first patch. The only
way I was able to fix that by using the attached patches. Unfortunately I can
not test RT with mainline yet, so I'm not 100% sure if by using the
dmaengine_terminate_sync() in drivers will fix the issue.

-- 
P?ter
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-dmaengine-virt-dma-Support-for-ignoring-callback-aft.patch
Type: text/x-patch
Size: 4081 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/26d818cd/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-dmaengine-omap-dma-Prevent-race-between-vchan_comple.patch
Type: text/x-patch
Size: 1215 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/26d818cd/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-dmaengine-edma-Prevent-race-between-vchan_complete-a.patch
Type: text/x-patch
Size: 1230 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/26d818cd/attachment-0005.bin>
