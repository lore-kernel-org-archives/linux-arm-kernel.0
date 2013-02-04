From: markus@oberhumer.com (Markus F.X.J. Oberhumer)
Date: Mon, 04 Feb 2013 02:37:08 +0100
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <510B6829.7050908@lge.com>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>,
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <254788880.18003.1359493798737.JavaMail.tomcat@be12>
 <510B6829.7050908@lge.com>
Message-ID: <510F10C4.2080903@oberhumer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-02-01 08:00, kyungsik.lee wrote:
> On 2013-01-30 ?? 6:09, Rajesh Pawar wrote:
>>> Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Sat, 26 Jan 2013 14:50:43 +0900
>>> Kyungsik Lee <kyungsik.lee@lge.com> wrote:
>>>> [...]
>>>>
>>> What's this "with enabled unaligned memory access" thing? You mean "if
>>> the arch supports CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS"? If so,
>>> that's only x86, which isn't really in the target market for this
>>> patch, yes?
>>> It's a lot of code for a 50ms boot-time improvement. Does anyone have
>>> any opinions on whether or not the benefits are worth the cost?
>> BTW, what happened to the proposed LZO update - woudn't it better to merge
>> this first?
>>
>> Also, under the hood LZ4 seems to be quite similar to LZO, so probably
>> LZO speed would also greatly benefit from unaligned access and some other
>> ARM optimisations
>>   
> I didn't test with the proposed LZO update you mentioned. Sorry, which one do
> you mean?
> I did some tests with the latest LZO in the mainline.

In fact you can easily improve LZO decompression speed on armv7 by almost 50%
by adding just a few lines for enabling unaligend access:

armv7 (Cortex-A9), Linaro gcc-4.6 -O3, Silesia test corpus, 256 kB block-size:

                   compression speed   decompression speed

  LZO-2005    :          27 MB/sec           84 MB/sec
  LZO-2012    :          44 MB/sec          117 MB/sec
  LZO-2013-UA :          47 MB/sec          167 MB/sec

Please see my other mail to LKML for details.

Cheers,
Markus

> As a result, LZO is not faster in an unaligned access enabled on ARM. Actually
> Slower.
> 
> Decompression time: 336ms(383ms, with unaligned access enabled)
> 
> You may refer to https://lkml.org/lkml/2012/10/7/85 to know more about it.
> 
> Thanks,
> Kyungsik
> 
> 
> Thanks,
> Kyungsik
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
