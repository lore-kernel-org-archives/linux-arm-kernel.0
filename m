From: john.stultz@linaro.org (John Stultz)
Date: Thu, 25 May 2017 12:41:45 -0700
Subject: [PATCH v2 2/2] arm64: Add support for CLOCK_MONOTONIC_RAW in
 clock_gettime() vDSO
In-Reply-To: <20170525162938.GT2859@arm.com>
References: <CAE2F3rCCJG5+cjTgWmHFN7zeJNhudKWyj5owg1aQnWWhMN3oKQ@mail.gmail.com>
 <20170525162938.GT2859@arm.com>
Message-ID: <CALAqxLXdWkh-P+Lfk1ysj3W6r6RMynkimA5FOD6jR4F1roSV4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 9:29 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Daniel,
>
> [adding John, as I know he's working on patches for this]
>
> On Mon, May 22, 2017 at 04:56:34PM -0700, Daniel Mentz wrote:
>> One of the tests in the kselftest suite fails for me on a HiKey board
>> (ARM Cortex-A53), and I believe that this change could be related to
>> it. The specific test that fails is
>> tools/testing/selftests/timers/inconsistency-check.c
>
> Have you got any hints on reproducing this? I've failed to reproduce it
> so far on any of my machines running 4.12-rc2.
>
> Which version of the HiKey are you using? The latest one is big.LITTLE
> with an A73, which has an unfortunate erratum that ends up disabling the
> vDSO.
>
> Will
>
>
>> Here is a snippet of the test output:
>>
>> 285:363928252
>> 285:363928252
>> 285:363928252
>> 285:363928252
>> --------------------
>> 285:363974918
>> 285:363974917
>> --------------------
>> 285:363974917
>> 285:363974917
>> 285:363974917
>> 285:363974917
>> 285:363974917
>> 285:363974917
>> 285:363974917
>> 285:363975751
>> 285:363975751
>> 285:363975751
>> 285:363975751
>> 285:363975751
>> 285:363975751
>>
>> As you can see between the two lines "--------------",
>> CLOCK_MONOTONIC_RAW went backwards by one nanosecond.
>


Hey Daniel,
   Yea. Apologies for the duplicated debugging effort you've done. You
diagnosed the problem properly.

I've already got patches to fix up the core handling and am testing a
patch Will provided to correct the vdso. I'll add you to the cc when I
send to the list.

Will: This was all done on the original HiKey. I can reproduce it with
4.12-rc2 (as well as 4.9). It looks like your vDSO patch is working
properly.

thanks
-john
