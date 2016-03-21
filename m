From: opensource.ganesh@gmail.com (Ganesh Mahendran)
Date: Mon, 21 Mar 2016 09:56:06 +0800
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
Message-ID: <CADAEsF8UwR+qqD=GWvoT1EdFH2+KOBJWE6cBZYEi=+_2LCVCWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Tirumalesh:

2016-03-19 5:05 GMT+08:00 Chalamarla, Tirumalesh
<Tirumalesh.Chalamarla@caviumnetworks.com>:
>
>
>
>
>
> On 3/16/16, 2:32 AM, "linux-arm-kernel on behalf of Ganesh Mahendran" <linux-arm-kernel-bounces at lists.infradead.org on behalf of opensource.ganesh@gmail.com> wrote:
>
>>Reverts commit 97303480753e ("arm64: Increase the max granular size").
>>
>>The commit 97303480753e ("arm64: Increase the max granular size") will
>>degrade system performente in some cpus.
>>
>>We test wifi network throughput with iperf on Qualcomm msm8996 CPU:
>>----------------
>>run on host:
>>  # iperf -s
>>run on device:
>>  # iperf -c <device-ip-addr> -t 100 -i 1
>>----------------
>>
>>Test result:
>>----------------
>>with commit 97303480753e ("arm64: Increase the max granular size"):
>>    172MBits/sec
>>
>>without commit 97303480753e ("arm64: Increase the max granular size"):
>>    230MBits/sec
>>----------------
>>
>>Some module like slab/net will use the L1_CACHE_SHIFT, so if we do not
>>set the parameter correctly, it may affect the system performance.
>>
>>So revert the commit.
>
> Is there any explanation why is this so? May be there is an alternative to this, apart from reverting the commit.
>

I just think the commit 97303480753e ("arm64: Increase the max
granular size") introduced new problem for other Socs which
the L1 cache line size is not 128 Bytes. So I wanted to revert this commit.

> Until now it seems L1_CACHE_SHIFT is the max of supported chips. But now we are making it 64byte, is there any reason why not 32.
>

We could not simply set the L1_CACHE_SHIFT to max. There are other
places which use L1 cache line size.
If we just set the L1 cache line size to the max, the memory footprint
and the system performance will be affected.
For example:
------
#define SMP_CACHE_BYTES L1_CACHE_BYTES
#define SKB_DATA_ALIGN(X) ALIGN(X, SMP_CACHE_BYTES)
------

Thanks.

> Thanks,
> Tirumalesh.
>>
>>Cc: stable at vger.kernel.org
>>Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>>---
>> arch/arm64/include/asm/cache.h |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>>index 5082b30..bde4499 100644
>>--- a/arch/arm64/include/asm/cache.h
>>+++ b/arch/arm64/include/asm/cache.h
>>@@ -18,7 +18,7 @@
>>
>> #include <asm/cachetype.h>
>>
>>-#define L1_CACHE_SHIFT                7
>>+#define L1_CACHE_SHIFT                6
>> #define L1_CACHE_BYTES                (1 << L1_CACHE_SHIFT)
>>
>> /*
>>--
>>1.7.9.5
>>
>>
>>_______________________________________________
>>linux-arm-kernel mailing list
>>linux-arm-kernel at lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
