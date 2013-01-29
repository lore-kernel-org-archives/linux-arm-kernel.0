From: kyungsik.lee@lge.com (kyungsik.lee)
Date: Tue, 29 Jan 2013 10:16:25 +0900
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130128142510.68092e10.akpm@linux-foundation.org>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
Message-ID: <510722E9.5090603@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-01-29 ?? 7:25, Andrew Morton wrote:
> On Sat, 26 Jan 2013 14:50:43 +0900
> Kyungsik Lee <kyungsik.lee@lge.com> wrote:
>
>> This patchset is for supporting LZ4 compressed kernel and initial ramdisk on
>> the x86 and ARM architectures.
>>
>> According to http://code.google.com/p/lz4/, LZ4 is a very fast lossless
>> compression algorithm and also features an extremely fast decoder.
>>
>> Kernel Decompression APIs are based on implementation by Yann Collet
>> (http://code.google.com/p/lz4/source/checkout).
>> De/compression Tools are also provided from the site above.
>>
>> The initial test result on ARM(v7) based board shows that the size of kernel
>> with LZ4 compressed is 8% bigger than LZO compressed  but the decompressing
>> speed is faster(especially under the enabled unaligned memory access).
>>
>> Test: 3.4 based kernel built with many modules
>> Uncompressed kernel size: 13MB
>> lzo: 6.3MB, 301ms
>> lz4: 6.8MB, 251ms(167ms, with enabled unaligned memory access)
>>
>> It seems that it___s worth trying LZ4 compressed kernel image or ramdisk
>> for making the kernel boot more faster.
>>
>> ...
>>
>>   20 files changed, 663 insertions(+), 3 deletions(-)
>>
>> ...
>>
> What's this "with enabled unaligned memory access" thing?  You mean "if
> the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"?  If so,
> that's only x86, which isn't really in the target market for this
> patch, yes?

Yes, exactly. If the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,

then it is expected more boot-time improvement by LZ4-decompressor.

Currently there are two architectures which support it in mainline; x86 and powerpc.
And it is expected that ARM arch(v6 or above) also support it since the commit below.
Commit ID: 5010192d5
ARM: 7583/1: decompressor: Enable unaligned memory access for v6 and above
by Dave Martin

The test results(167ms) come from the ARM(v7 arch), MSM8960 based board with
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS set.
  

>
> It's a lot of code for a 50ms boot-time improvement.  Does anyone have
> any opinions on whether or not the benefits are worth the cost?
>

Not only for the kernel but also the ramdisk can be compressed with LZ4 so
the boot-time would be more improved. The test case above didn't include
the decompressing time result for LZ4-compressed ramdisk.

So far the implementation is applicable to boot-time improvement for
LZ4-compressed kernel and ramdisk images but the decompressor module is
exported as an interface for other usages like LZO.
With LZ4 compressor(not yet implemented for the kernel), it is expected
that it will be used in many places in kernel such as crypto and fs(squashfs, btrfs).

Thanks,
Kyungsik

  
