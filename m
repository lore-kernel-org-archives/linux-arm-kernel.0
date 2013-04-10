From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 10 Apr 2013 17:08:25 +0200
Subject: v7_flush_kern_cache_louis flushes up to L2?
In-Reply-To: <20130410135138.GA9210@e102568-lin.cambridge.arm.com>
References: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
 <51655248.7000401@arm.com>
 <CABYn4swK_FB+nPO4vKZM8khp+mjaPwkAv_GF+XDg5SYz0VLf0Q@mail.gmail.com>
 <20130410135138.GA9210@e102568-lin.cambridge.arm.com>
Message-ID: <CABYn4sya=N7Hof7D_rmGJJtqjL5-27qnk39EUMRmRUB7_s+G5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

2013/4/10 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
> On Wed, Apr 10, 2013 at 01:16:03PM +0100, Bastian Hecht wrote:
>> Hi Jonny!
>>
>> 2013/4/10 Jonathan Austin <jonathan.austin@arm.com>:
>> > Hi Bastian,
>> >
>> >
>> > On 10/04/13 11:43, Bastian Hecht wrote:
>> >>
>> >> Hello,
>> >>
>> >> I've got a Cortex-A9 UP with a L2 and want to submit some PM code I've
>> >
>> >
>> > To clarify, is this an MPCore with a single core, or a genuine UP? This can
>> > be established from the 'U' bit of the MPIDR.
>> >
>>
>> I didn't actually read out the U bit, but I'm sure I've got no SCU, so
>> I bet high that it's a genuine UP system.
>>
>> >> written. Just to make sure I've made no mistake, it would be very
>> >> helpful if you can confirm a hypothesis I use in my code:
>> >>
>> >> v7_flush_kern_cache_louis: Flush the data cache up to Level of
>> >> Unification Inner Shareable
>> >>
>> >
>> > Depending on whether you're SMP or UP (bearing in mind that you can be SMP,
>> > but still only have one processor!) the IS is ignored in the
>> > v7_flush_dcache_louis operation:
>> > (from cache-v7.S)
>> >
>> >         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
>> >         ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
>> >         ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
>> >         ALT_SMP(mov     r3, r3, lsr #20)        @ r3 = LoUIS * 2
>> >         ALT_UP(mov      r3, r3, lsr #26)        @ r3 = LoUU * 2
>> >         ...
>> >         flush levels based on value in r3
>> >
>> >
>> >> This flushes the data out up to the L2, right? The ARM docs say that
>> >> the Point of Unification would be my L2. I'm a bit confused by the
>> >> term "Level of Unification Inner Shareable" (that states that in an
>> >> SMP system L1 coherency is guaranteed and all is flushed to the L2?).
>> >>
>> >
>> > As you say, for the A9 (from the TRM) the CLIDR reports LoUIS is the same as
>> > LoUU and both specify L2.
>>
>> Ok, this is the golden info I was looking for. So after cpu_suspend()
>> I am good with the following sequence?
>
> Is L2 RAM retained on power down ?

I have two different versions of powering down the SoC. Currently I'm
focusing on a shutdown mode that contains the powering off of the L2.

>> flush L2 (outer_flush_all)
>> disable L2 (outer_disable)
>
> Disabling L2 is not mandatory. And the code above (if L2 RAM is not
> retained) can be simply
>
> outer_disable
>
> the cleaning is done in the PL310 disable function properly.

The problem I see with this approach is:
What advantage do we get at all if we have to flush the L2 (which is
done in the PL310 disable routine)? Isn't this exactly the part we
want to save? Not to have to flush the L2.

>> Clear the SCTLR.C bit and issue an "isb"
>> flush L1 (v7_flush_dcache_all)
>
> Two steps above are ok, as long as flush L1 does not push data on the
> stack on entry and L1 clean routine does not need any dirty data present
> in L1. Clearing C bit on A9 stops the core from searching the
> cache so data writes should not be executed with C bit cleared and a
> data cache still containing dirty lines. For the same reason the cache
> cleaning routine should not require any data to execute since the data
> can be sitting in the cache that is not searched anymore when the C bit
> is cleared.

Ah true! When I enter my assembly code there are of course stack modifications.
And here comes a point I've just realized recently: Sometimes the WFI
command doesn't enter the low power state mode I've requested. I
haven't observed this when using Suspend-To-Ram but when using
CPUIdle.
I've seen code from the OMAP people that check for the case that WFI
doesn't succeed. Probably I need to do the same. And for this I need
the stack to be synced.

> The sequence:
>
> clear C bit
> bl v7_flush_dcache_all
>
> is better coded in assembly (in the cpu_suspend finisher, ie the
> function you pass as cpu_suspend 2 argument) to control what you are doing.
>
> The cache cleaning routine (v7_flush_dcache_all) does not require any
> data to execute, so running it with C bit cleared is fine.
>
>> cpu_do_idle
>>
>> and for resume:
>> invalidate L1
>
> Use v7_invalidate_l1 here.
>
>> (trust cpu_resume to resume the L1 and enable the SCTLR.C bit)
>> resume L2 (outer_resume)
>
> Again, it depends on L2 behaviour on shutdown, if it is retained or not.
> If L2 RAM content is lost on power down the sequence above seems ok.
>
> Post the code, happy to have a look.
>

Ok great, I'm quite blown away by the support here, should have
contacted you earlier!

Bastian
