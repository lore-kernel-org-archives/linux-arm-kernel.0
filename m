From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Dec 2010 20:04:41 +0000
Subject: OMAP3: Warning: swp{b} use is deprecated for this architecture
In-Reply-To: <AANLkTinL3oonBvkZwZFr=Wh2m_EYQ1WVudV9cxNqKRBx@mail.gmail.com>
References: <AANLkTinmg4SyQNz5ide40YYC7k_MRQ6Q-j=WKN7jLC68@mail.gmail.com>
	<20101216115657.GP9937@n2100.arm.linux.org.uk>
	<AANLkTi=-ERvBARQ3bzOMZPx0s-OPuZHgXqjRet1aUxGw@mail.gmail.com>
	<AANLkTink3TJonOC+cnpRUKKu9_+OBhJKDQ25yvrZZsrQ@mail.gmail.com>
	<6188477658179778436@unknownmsgid>
	<AANLkTinL3oonBvkZwZFr=Wh2m_EYQ1WVudV9cxNqKRBx@mail.gmail.com>
Message-ID: <AANLkTinXBx5F-wQC_eJPftsqgbaFUg9R8z5FxTFR+gTy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 5:16 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Hi Will,
>
> On Thu, Dec 16, 2010 at 6:05 PM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Jean,
>>
>>> >>> Here is the offending code excerpt:
>>> >>>
>>> >>> wait_sem:
>>> >>> ? ? ? ? mov ? ? r0,#1
>>> >>> ? ? ? ? ldr ? ? r1, sdrc_scratchpad_sem
>>> >>> wait_loop:
>>> >>> ? ? ? ? ldr ? ? r2, [r1] ? ? ? ?@ load the lock value
>>> >>> ? ? ? ? cmp ? ? r2, r0 ? ? ? ? ?@ is the lock free ?
>>> >>> ? ? ? ? beq ? ? wait_loop ? ? ? @ not free...
>>> >>> ? ? ? ? swp ? ? r2, r0, [r1] ? ?@ semaphore free so lock it and proceed
>>> >>> ? ? ? ? cmp ? ? r2, r0 ? ? ? ? ?@ did we succeed ?
>>> >>> ? ? ? ? beq ? ? wait_sem ? ? ? ?@ no - try again
>>> >>
>>> >> (untested, as my LDP is useless because of OMAP regressions.)
>>> >>
>>> >> wait_sem:
>>> >> ? ? ? ?mov ? ? r0, #1
>>> >> ? ? ? ?ldr ? ? r1, sdrc_scratchpad_sem
>>> >> wait_loop:
>>> >> ? ? ? ?ldrex ? r2, [r1] ? ? ? ?@ load lock value
>>> >> ? ? ? ?teq ? ? r2, r0 ? ? ? ? ?@ is lock free ( != 1)
>>> >> ? ? ? ?beq ? ? wait_loop ? ? ? @ no, try again
>>> >> ? ? ? ?strex ? r2, r0, [r1] ? ?@ try to lock
>>> >> ? ? ? ?teq ? ? r2, #0 ? ? ? ? ?@ did store succeed?
>>> >> ? ? ? ?bne ? ? wait_loop ? ? ? @ no, try again
>>> >
>>> > I'm not familiar with the OMAP code but I recall they needed swp for
>>> > some synchronisation with external processor (DSP). Is this still the
>>> > case?
>>> This code is meant to be used by the new DVFS code which is not merged in yet.
>>
>> I don't know what you do with this lock held or what the contention
>> is like, but you probably want a memory barrier immediately after you've
>> acquired it and another one before you release it.
> OK, thanks for the suggestion.
>
> Since this code is not used at the moment it will be removed.
> It shall be added back, fixed and tested later when the API will be in real use.

Note that the above bit of code is similar/identical to a bit of code
already present in the OMAP BSP... so this still needs to be
addressed.

See arch/arm/mach-omap2/sleep34xx.S:lock_scratchpad_sem


I encountered the same problem when trying to build this code for
Thumb-2 -- though there it's an error, not a warning since Thumb-2 has
no instruction encoding for SWP at all.

I suspect that an actual atomic swap is needed on the bus to
synchronise safely with some piece of hardware in these cases -- I
don't know whether there's a workaround. Some with knowledge about the
hardware will need to comment.

If the SWP must be used, there are a few options: use ",arch armv5" in
the assembler file; use -march=armv5 for the whole file; or use .long
0xe1012090.  Unfortunately, none of these alternatives is pretty :/

Will is probably correct regarding the need for barriers, also.

Cheers
---Dave
