From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Dec 2017 09:08:22 +0000
Subject: [PATCH 0/5] crypto: arm64 - disable NEON across scatterwalk API
 calls
In-Reply-To: <20171202135952.GX3326@worktop>
References: <20171201211927.24653-1-ard.biesheuvel@linaro.org>
 <20171202090107.GT3326@worktop>
 <CAKv+Gu-dG0Zc35NZZ85U36K2TXCpN+wJTYOyjkhxRjXbdiJTAQ@mail.gmail.com>
 <CAKv+Gu_DMVYX8y-8JJwyxy2rF0+6ofSWyjwpvwuF042ievBb7w@mail.gmail.com>
 <20171202135952.GX3326@worktop>
Message-ID: <CAKv+Gu9e+JWKeHPpgudsJbNPh1sczPBr5SX1jm7h_wmqQ6NPVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2017 at 13:59, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Dec 02, 2017 at 11:15:14AM +0000, Ard Biesheuvel wrote:
>> On 2 December 2017 at 09:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> > They consume the entire input in a single go, yes. But making it more
>> > granular than that is going to hurt performance, unless we introduce
>> > some kind of kernel_neon_yield(), which does a end+begin but only if
>> > the task is being scheduled out.
>> >
>> > For example, the SHA256 keeps 256 bytes of round constants in NEON
>> > registers, and reloading those from memory for each 64 byte block of
>> > input is going to be noticeable. The same applies to the AES code
>> > (although the numbers are slightly different)
>>
>> Something like below should do the trick I think (apologies for the
>> patch soup). I.e., check TIF_NEED_RESCHED at a point where only very
>> few NEON registers are live, and preserve/restore the live registers
>> across calls to kernel_neon_end + kernel_neon_begin. Would that work
>> for RT?
>
> Probably yes. The important point is that preempt latencies (and thus by
> extension NEON regions) are bounded and preferably small.
>
> Unbounded stuff (like depends on the amount of data fed) are a complete
> no-no for RT since then you cannot make predictions on how long things
> will take.
>

OK, that makes sense. But I do wonder what the parameters should be here.

For instance, the AES instructions on ARMv8 operate at <1 cycle per
byte, and so checking the TIF_NEED_RESCHED flag for every iteration of
the inner loop (i.e., every 64 bytes ~ 64 cycles) is clearly going to
be noticeable, and is probably overkill. The pure NEON version (which
is instantiated from the same block mode wrappers) uses ~25 cycles per
byte, and the bit sliced NEON version runs at ~20 cycles per byte but
can only operate at 8 blocks (128 bytes) at a time.

So rather than simply polling the bit@each iteration of the inner
loop in each algorithm, I'd prefer to aim for a ballpark number of
cycles to execute, in the order 1000 - 2000. Would that be OK or too
coarse?
