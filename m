From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 09 Jan 2015 17:06:54 +0000
Subject: [PATCH] arm: Remove early stack deallocation from
 restore_user_regs
In-Reply-To: <20150109164608.GV12302@n2100.arm.linux.org.uk>
References: <1418382718-16323-1-git-send-email-daniel.thompson@linaro.org>
 <1420470758-5874-1-git-send-email-daniel.thompson@linaro.org>
 <20150109164608.GV12302@n2100.arm.linux.org.uk>
Message-ID: <54B00AAE.1050504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/15 16:46, Russell King - ARM Linux wrote:
> On Mon, Jan 05, 2015 at 03:12:38PM +0000, Daniel Thompson wrote:
>> Currently restore_user_regs deallocates the SVC stack early in
>> its execution and relies on no exception being taken between
>> the deallocation and the registers being restored. The introduction
>> of a default FIQ handler that also uses the SVC stack breaks this
>> assumption and can result in corrupted register state.
>>
>> This patch works around the problem by removing the early
>> stack deallocation and using r2 as a temporary instead. I have
>> not found a way to do this without introducing an extra mov
>> instruction to the macro.
>>
>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>> ---
> 
> Please put it in the patch system, thanks.

Will do.


> I think we should queue
> this one for stable too, as I think we need this for v3.18
> (as a result of c0e7f7ee717e2b4c5791e7422424c96b5008c39e,
> ARM: 8150/3: fiq: Replace default FIQ handler)?

It's a close call.

Before 8150/3 the system would probably crash if the default FIQ handler
ran. After 8150/3 the system is also likely to crash since there's no
code hooked into the handler in v3.18 that can clear the source of FIQ
leaving us stuck re-entering the FIQ handler.

Nevertheless, this is a nasty gremlin to leave for backporters (it
wasn't easy to find) so I'd be very happy to Cc: stable and see what
they think.


Daniel.
