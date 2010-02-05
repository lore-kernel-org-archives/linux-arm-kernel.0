From: GKing@nvidia.com (Gary King)
Date: Fri, 5 Feb 2010 10:13:03 -0800
Subject: race between kmap shootdown and cache maintenance
Message-ID: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have seen some instability with highmem enabled on Tegra 2 systems (Cortex A9 SMP), where ocassionally the kernel will panic with unservicable page faults from flush_dcache_page, at an address half-way through a kmapped page.

I think this patch addresses the root cause: the cache maintenance code doesn't increase the reference count of the kmap, so another thread may kunmap the last reference and zap the corresponding PTE.

- Gary

Gary King
gking at nvidia.com




-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100205/2785f794/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001--ARM-highmem-fix-race-between-cache-flush-and-kmap.patch
Type: application/octet-stream
Size: 2027 bytes
Desc: 0001--ARM-highmem-fix-race-between-cache-flush-and-kmap.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100205/2785f794/attachment-0001.obj>
