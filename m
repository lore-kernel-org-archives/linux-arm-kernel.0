From: yanpai.chen@gmail.com (Andrew Yan-Pai Chen)
Date: Fri, 5 Oct 2012 15:55:33 +0800
Subject: [RFC] arm/mm: add a protection when flushing anonymous pages
In-Reply-To: <CANj_sbADwtPR6cgk05QkmvrSUOOQRYXB9vPB6KATKEmwcN8UrA@mail.gmail.com>
References: <CAGCDX1mY4wbMq4qDJ9vCazShxdWQXVYyWkpLd5u8_xqbEC2BWQ@mail.gmail.com>
 <CAGCDX1mkPVre6h=9kNbRqCp_wtbOneuRLMXM+mkZWFXPwWkBfg@mail.gmail.com>
 <CANj_sbADwtPR6cgk05QkmvrSUOOQRYXB9vPB6KATKEmwcN8UrA@mail.gmail.com>
Message-ID: <CANj_sbDz02NJedA=Hc1Xe5rFe1p3XUtg_BAeys25xVUqZ8utJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 3:07 PM, Andrew Yan-Pai Chen
<yanpai.chen@gmail.com> wrote:
> On Mon, Oct 1, 2012 at 11:50 AM, Jason Lin <kernel.jason@gmail.com> wrote:
>>
>> Dear all:
>> By the way, I used the CPU with VIPT cache.
>> Thanks.
>>
>> 2012/10/1 Jason Lin <kernel.jason@gmail.com>:
>> > Dear all:
>> > When I do LTP direct I/O tests, it produced a cache coherence issue
>> > caused by flush_pfn_alias() (arch/arm/mm/flush.c).
>> > I think we should to disable preemption or lock before setting page
>> > table and enable preemption or unlock after flushing pages
>> >
>> > Any comments are appreciated.
>> > Thanks.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> [RFC PATCH] make flush_pfn_alias() nonpreemptible
>
> Since flush_pfn_alias() is preemptible, it is possible to be
> preempted just after set_top_pte() is done. If the process
> which preempts the previous happened to invoke flush_pfn_alias()
> with the same colour vaddr as that of the previous, the same
> top pte will be overwritten. When switching back to the previous,
> it attempts to flush cache lines with incorrect mapping. Then
> no lines (or wrong lines) will be flushed because of the nature
> of vipt caches.
>
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 40ca11e..bd07918 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -27,6 +27,8 @@ static void flush_pfn_alias(unsigned long pfn,
> unsigned long vaddr)
>         unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) <<
> PAGE_SHIFT);
>         const int zero = 0;
>
> +       preempt_disable();
> +
>         set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
>
>         asm(    "mcrr   p15, 0, %1, %0, c14\n"
> @@ -34,6 +36,8 @@ static void flush_pfn_alias(unsigned long pfn,
> unsigned long vaddr)
>             :
>             : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
>             : "cc");
> +
> +       preempt_enable();
>  }
>
> --
> Regards,
> Andrew

Hi Russell,

We met the problem when running the direct I/O test (diotest03) in LTP
testsuite on PB1176.
And we got the error messages:
bufcmp: offset 224: Expected: 0x1b, got 0x1a
diotest03    1  TFAIL  :  comparsion failed; child=11 offset=1069056
diotest03    2  TFAIL  :  Read Direct-child 11 failed
...

The error was gone after applying this patch.
Any idea would be appreciated.


--
Regards,
Andrew
