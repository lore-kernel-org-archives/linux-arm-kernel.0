From: shugelinux@gmail.com (Shuge)
Date: Wed, 13 Mar 2013 11:35:15 +0800
Subject: [PATCH] bounce:fix bug, avoid to flush dcache on slab page from
 jbd2.
In-Reply-To: <20130313011020.GA5313@blackbox.djwong.org>
References: <5139DB90.5090302@gmail.com>
 <20130312153221.0d26fe5599d4885e51bb0c7c@linux-foundation.org>
 <20130313011020.GA5313@blackbox.djwong.org>
Message-ID: <513FF3F3.2000509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all
>>> The bounce accept slab pages from jbd2, and flush dcache on them.
>>> When enabling VM_DEBUG, it will tigger VM_BUG_ON in page_mapping().
>>> So, check PageSlab to avoid it in __blk_queue_bounce().
>>>
>>> Bug URL: http://lkml.org/lkml/2013/3/7/56
>>>
>>> ...
>>>
>> ......
>>
> That sure is strange.  I didn't see any obvious reasons why we'd end up with a
>
......

     Well, this problem not only appear in arm64, but also arm32. And my 
kernel version is 3.3.0, arch is arm32.
Following the newest kernel, the problem shoulde be exist.
     I agree with Darrick's modification. Hum, if 
CONFIG_NEED_BOUNCE_POOL is not set, it also flush dcahce on
the pages of b_frozen_data, some of them are allocated by kmem_cache_alloc.
     As we know, jbd2_alloc allocate a buffer from jbd2_xk slab pool, 
when the size is smaller than PAGE_SIZE.
The b_frozen_data  is not mapped to usrspace, not aliasing cache. It cat 
be lazy flush or other. Is it right?
