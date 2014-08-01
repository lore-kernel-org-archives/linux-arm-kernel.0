From: achandran@mvista.com (Arun Chandran)
Date: Fri, 1 Aug 2014 16:43:12 +0530
Subject: Kexec on arm64
In-Reply-To: <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
Message-ID: <CAFdej00F56XLzNZEhYB0aV70mt+R+NN=gKQgE_5oDGsbxW0npA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 12:52 PM, Arun Chandran <achandran@mvista.com> wrote:
> On Wed, Jul 30, 2014 at 2:49 AM, Geoff Levand <geoff@infradead.org> wrote:
>> Hi Mark,
>>
>> On Tue, 2014-07-29 at 14:35 +0100, Mark Rutland wrote:
>>> Since c218bca74eea (arm64: Relax the kernel cache requirements for
>>> boot), the kernel will flush the cache for anything outside of the Image
>>> that it writes to before enabling the MMU and caches (e.g. the idmap and
>>> swapper page tables). Once caches are up we shouldn't care.
>>>
>>> Assuming that the existing kernel code is correct, the only region we
>>> should need to flush out to the PoC is the region from _text to _edata
>>> (i.e. just the contents of the Image).
>>
>> If the new kernel will overwrite the old one, then we do the final copy
>> of the new kernel in the relocate_new_kernel routine.  relocate_new_kernel
>> is executed after the dcache is disabled, so that should write it directly
>> to the PoC.  It seems the protocol expects us to invalidate the dcache
>> for that range though, so I added code to do this, essentially what Arun
>> had added.
>>
>> Arun, please try.
>>
> It works without any hiccups :)..
> I have attached the log.
>
> I will try with big-endian UP configuration next.
>

This question may be irrelevant to kexec and may be stupid also.

while debugging kexec in BIG-endian configuration I see
_create_page_tables (arch/arm64/kernel/head.S) is
doing __inval_cache_range on the addresses
from idmap_pg_dir to swapper_pg_dir.

ie from 0x4000D5F000 to 0x4000D61000 + #SWAPPER_DIR_SIZE
in my case.

Is it supposed to clear the corresponding virtual addresses?

There might be chance that first stage kernel may be using VA
from the same area right? (cache (L3)containing valid lines in the
area 0xffffffc000d5f000 to 0xffffffc000d5f000 + 16K)

Or is it the duty of the kexec to flush the entire
VA regions used by the first stage kernel and
the VA regions going to be used by the 2nd
stage kernel?

--Arun


> Just had to comment the crashdump code to compile with
> defconfig.
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 233cd04..6f4ebd8 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -377,6 +377,7 @@ static void __init __maybe_unused reserve_crashkernel(void)
>         insert_resource(&iomem_resource, &crashk_res);
>  }
>
> +#ifdef CONFIG_CRASH_DUMP
>  static void __init __maybe_unused reserve_elfcorehdr(void)
>  {
>         struct resource res;
> @@ -402,6 +403,7 @@ static void __init __maybe_unused reserve_elfcorehdr(void)
>         res.end = elfcorehdr_addr + elfcorehdr_size - 1;
>         insert_resource(&iomem_resource, &res);
>  }
> +#endif
>
>  static void __init request_standard_resources(void)
>  {
>
> --Arun
