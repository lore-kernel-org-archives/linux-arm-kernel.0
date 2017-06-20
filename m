From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 20 Jun 2017 08:48:19 +0200
Subject: [PATCH v2] drivers/kmem: disable on arm64
In-Reply-To: <20170619150323.GB9291@arm.com>
References: <1497883044-1276-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170619150323.GB9291@arm.com>
Message-ID: <CAKv+Gu__ZGrWKAVmNTrTR1xZo+b41egtjXnE68nncyFP0yKgQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2017 at 17:03, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jun 19, 2017 at 04:37:24PM +0200, Ard Biesheuvel wrote:
>> On arm64, the /dev/kmem driver barely works, given that it assumes that
>> VMALLOC_START > PAGE_OFFSET, which is not the case on arm64. Due to the
>
> Probably worth being explicit about the failure mode here (the commit
> message you had in your RFC was much better ;).
>

Yeah, that's a fair point, I was being lazy :-)

I will repost with the v1 commit log integrated


>> dubious value of kmem on an architecture such as arm64, which is fairly
>> new and is not as forgiving as other architectures when it comes to
>> userland accesses to kernel memory using mismatched attributes*, let's
>> disable it altogether if CONFIG_ARM64=y.
>>
>> * Mappings in the vmalloc region will be accessed using vread/vwrite when
>>   reading/writing to/from /dev/kmem, which will perform these accesses by
>>   kmap()'ing each page using writeback cacheable attributes. This will be
>>   correct in most cases, but this is not guaranteed.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/char/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>> index 31adbebf812e..8102ee7b3247 100644
>> --- a/drivers/char/Kconfig
>> +++ b/drivers/char/Kconfig
>> @@ -17,6 +17,8 @@ config DEVMEM
>>
>>  config DEVKMEM
>>       bool "/dev/kmem virtual device support"
>> +     # On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
>> +     depends on !ARM64
>>       help
>>         Say Y here if you want to support the /dev/kmem device. The
>>         /dev/kmem device is rarely used, but can be used for certain
>> --
>> 2.7.4
>>
