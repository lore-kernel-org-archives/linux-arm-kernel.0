From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 12 Nov 2018 10:21:12 -0800
Subject: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
In-Reply-To: <20181109.162920.1263908485037438031.davem@davemloft.net>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <20181109.162920.1263908485037438031.davem@davemloft.net>
Message-ID: <1b41ccb3-34dc-e579-f65d-328400cf2b8a@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2018 04:29 PM, David Miller wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Date: Fri,  9 Nov 2018 12:37:10 +0000
>
>> To take advantage of the commonly defined vdso interface for
>> gettimeofday the architectural code requires an adaptation.
>>
>> This patch re-implements the gettimeofday vdso in C in order to use
>> lib/vdso.
>>
>> With the new implementation arm64 gains support for CLOCK_BOOTTIME,
>> CLOCK_TAI and __kernel_time.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> What is the performance penalty for going to C from ASM like this?
>
> I like the vDSO consolidation, but actually I think it makes a lot of
> sense to implement these things in assembler with some C implementation
> as guidance or for architectures that haven't optimized into an ASM
> version yet.
>
> I'd also like to see if we can somehow make PowerPC's optimizations in
> this area usable in more places.
>
> It defines a reciprocal in order to use a multiply instead of a divide
> after capturing the time values.
>
> I say all of this because I want to do something similar on sparc, and
> having a generic implementation of all of the math would make that easier
> for me and other architecture maintainers who might want to do the same.

I saw an _improvement_ in performance for the C implementation (for 
arm64), the optimizer did a better job with the specific processor 
architecture and actually killed a few bugs in the assembler 
implementation. The improvement was in the order of a nano-second or two 
in micro-benchmarks.

I used the bionic benchmarks to measure the performance.

-- Mark
