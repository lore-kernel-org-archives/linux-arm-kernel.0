From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 1 Aug 2017 12:09:32 +0100
Subject: [PATCH] arm64: acpi/gtdt: validate CNTFRQ after having enabled
 the frame
In-Reply-To: <20170801105345.GB9347@leverpostej>
References: <20170724151053.17769-1-ard.biesheuvel@linaro.org>
 <20170801105345.GB9347@leverpostej>
Message-ID: <CAKv+Gu8jD_oJV138qWGQm2dOnqJTSxSNNQ7xFCPtb4efyR9n1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2017 at 11:53, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> Thanks for this. Sorry it's taken a while to reply.
>
> On Mon, Jul 24, 2017 at 04:10:53PM +0100, Ard Biesheuvel wrote:
>> The ACPI GTDT code validates the CNTFRQ field of each MMIO timer
>> frame against the CNTFRQ system register of the current CPU, to
>> ensure that they are equal, which is mandated by the architecture.
>>
>> However, reading the CNTFRQ field of a frame is not possible until
>> the RFRQ bit in the frame's CNTACRn register is set, and doing so
>> before that willl produce the following error:
>>
>>   arch_timer: [Firmware Bug]: CNTFRQ mismatch: frame @ 0x00000000e0be0000: (0x00000000), CPU: (0x0ee6b280)
>>   arch_timer: Disabling MMIO timers due to CNTFRQ mismatch
>>   arch_timer: Failed to initialize memory-mapped timer.
>>
>> The reason is that the CNTFRQ field is RES0 if access is not enabled.
>>
>> So move the validation of CNTFRQ into the loop that iterates over the
>> timers to find the best frame, and only validate the frame that has
>> been selected as the best frame (and has thus been enabled).
>
> The intention here was to verify all frames, such that if/when we choose
> to use other frames in future, CNTFRQ will be valid. This is stricter
> than the DT case, which I'd also make stricter were it not for legacy.
>
> So while that check needs to be corrected, I'd like to retain the check
> for all frames.
>

The point here is that CNTFRQ cannot differ between frames. It either
returns the value of the base frame or RES0.

>> (Note that there is no point in trying other frames of the same timer
>> if the validation fails, since they are all architecturally guaranteed
>> to have the same value for CNTFRQ)
>>
>> Oh, and while we're at it, fix the bogus 'i = i' initializer in the
>> for() loop that iterates over the timers.
>
> Matthias Kaehlcke just sent a patch for this alone. I'd like to take
> that as an ortohogonal fix while we sort out the dodgy CNTFRQ check.
>

Yeah that is fine.
