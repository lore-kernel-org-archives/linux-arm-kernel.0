From: ccross@android.com (Colin Cross)
Date: Mon, 15 Oct 2012 19:15:31 -0700
Subject: [PATCH 2/2] ARM: unwind: enable dumping stacks for SMP &&
 ARM_UNWIND
In-Reply-To: <20121012100242.GA2126@linaro.org>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
 <1346021216-21979-3-git-send-email-ccross@android.com>
 <20121012090807.GB21164@n2100.arm.linux.org.uk>
 <20121012100242.GA2126@linaro.org>
Message-ID: <CAMbhsRRpYrOBhaFn5PV5f5J=36Hsj2eZixyD1hXRfRLoyWm1Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 3:02 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Fri, Oct 12, 2012 at 10:08:07AM +0100, Russell King - ARM Linux wrote:
>> On Sun, Aug 26, 2012 at 03:46:56PM -0700, Colin Cross wrote:
>> > Unwinding with CONFIG_ARM_UNWIND is much more complicated than
>> > unwinding with CONFIG_FRAME_POINTER, but there are only a few points
>> > that require validation in order to avoid faults or infinite loops.
>> > Avoiding faults is easy by adding checks to verify that all accesses
>> > relative to the frame's stack pointer remain inside the stack.
>> >
>> > When CONFIG_FRAME_POINTER is not set it is possible for two frames to
>> > have the same SP, so there is no way to avoid repeated calls to
>> > unwind_frame continuing forever.
>>
>> So here you admit that this patch can cause the unwinder to loop forever,
>> which would provide no way out of that.  Why do you think this patch is
>> suitable for mainline with such a problem?
>
> With CONFIG_FRAME_POINTER we have a straightforward definition of
> progress: the sp must increase per frame, and cannot increase beyond the
> limit of the tasks stack.  We get this property from the fact that
> each frame record consumes actual space on the stack.  If we parse a
> frame record which does not both increase the sp and provide a frame
> address greater than that sp, we know that frame is garbage and we must
> stop.
>
>
> With CONFIG_ARM_UNWIND, we have no straightforward definition of
> progress.  However, sp must _normally_ still increase, because compiler-
> generated non-leaf functions must store the lr somewhere, and the
> compiler always uses the stack.  Even if lr is stashed in r4, an ABI
> compliant would then have needed to save r4 on the stack beforehand.
>
> We can assume that we will never parse a garbage unwind table because of
> the way the table lookup works (though we may parse a valid table which
> has nothing whatever to do with the code that was executing in the case
> of a corrupted stack).  So we only need to worry about what the unwind
> tables will look like for valid functions.
>
> Nonetheless, tail-call-optimised and manually-annotated functions may
> have unusual frames which don't consume any stack.  Stackless tail-
> call-optimised functions shouldn't be a problem, since their frames
> are completely missing from the backtrace and won't dump us into a loop.
> Stackless assembler functions are overwhelmingly likely to be leaf
> functions, giving us just one stackless frame.
>
>
> Would it make sense if we place some small sanity limit on the number
> of frames the unwinder will process with the same sp before giving up?

About half the callers to unwind_frame end up limiting the number of
frames they will follow before giving up, so I wasn't sure if I should
put an arbitrary limit in unwind_frame or just make sure all callers
are bounded.  Your idea of limiting same sp frames instead of total
frames sounds better.  I can send a new patch that adds a new field to
struct stackframe (which will need to be initialized everywhere, the
struct is usually on the stack) and limits the recursion.  Any
suggestion on the recursion limit?  I would never expect to see a real
situation with more than a few, but on the other hand parsing the
frames should be pretty fast so a high number (100?) shouldn't cause
any user visible effect.
