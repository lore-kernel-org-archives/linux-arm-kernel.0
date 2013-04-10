From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 10 Apr 2013 12:51:36 +0100
Subject: v7_flush_kern_cache_louis flushes up to L2?
In-Reply-To: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
References: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
Message-ID: <51655248.7000401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastian,

On 10/04/13 11:43, Bastian Hecht wrote:
> Hello,
>
> I've got a Cortex-A9 UP with a L2 and want to submit some PM code I've

To clarify, is this an MPCore with a single core, or a genuine UP? This 
can be established from the 'U' bit of the MPIDR.

> written. Just to make sure I've made no mistake, it would be very
> helpful if you can confirm a hypothesis I use in my code:
>
> v7_flush_kern_cache_louis: Flush the data cache up to Level of
> Unification Inner Shareable
>

Depending on whether you're SMP or UP (bearing in mind that you can be 
SMP, but still only have one processor!) the IS is ignored in the 
v7_flush_dcache_louis operation:
(from cache-v7.S)

         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
         ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
         ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
         ALT_SMP(mov     r3, r3, lsr #20)        @ r3 = LoUIS * 2
         ALT_UP(mov      r3, r3, lsr #26)        @ r3 = LoUU * 2
	...
	flush levels based on value in r3

> This flushes the data out up to the L2, right? The ARM docs say that
> the Point of Unification would be my L2. I'm a bit confused by the
> term "Level of Unification Inner Shareable" (that states that in an
> SMP system L1 coherency is guaranteed and all is flushed to the L2?).
>

As you say, for the A9 (from the TRM) the CLIDR reports LoUIS is the 
same as LoUU and both specify L2.

Does that make things clearer, or are you still unsure about something?

Jonny
