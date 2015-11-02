From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 02 Nov 2015 13:31:07 +0000
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <563736A0.9040804@free.fr> (Mason's message of "Mon, 2 Nov 2015
 11:10:40 +0100")
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
 <56325C67.8000007@free.fr> <yw1xeggdd007.fsf@unicorn.mansr.com>
 <5633CF2A.4040504@free.fr> <yw1xpozvavui.fsf@unicorn.mansr.com>
 <563736A0.9040804@free.fr>
Message-ID: <yw1xsi4oa5pg.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 31/10/2015 16:41, M?ns Rullg?rd wrote:
>
>> Mason writes:
>> 
>>> On 29/10/2015 19:04, M?ns Rullg?rd wrote:
>>>
>>>> There's also something wrong with the L2C-310 aux control register
>>>> setting.  The SMC call ID from OMAP (0x109) which is also used in some
>>>> Sigma code I found somewhere doesn't seem to do anything, so the
>>>> register is left at the value set by the secure boot code.  Perhaps you
>>>> can check with your firmware guy if there's another way of writing that
>>>> register.
>>>
>>> IIRC, only debug firmware allows writes to L2 AUXCTRL (after filtering
>>> some of the bits out), while production firmware ignores them completely.
>>>
>>> IME, the smc handler should default to return ENOTSUP; that way, when
>>> a syscall disappears due to ifdef-ery, the caller gets a meaningful
>>> answer.
>>>
>>> We just had an interesting internal discussion about L2 AUXCTRL.
>>> For my education, what value would you like to write to AUXCTRL? :-)
>> 
>> The best value to use depends on the workload, so it would be nice to be
>> able to control all the purely performance related bits.  I see no
>> possible benefit in restricting the non-secure kernel from writing
>> these.
>
> For the record, the latest firmware uses 0x72860401.

My SMP8759 firmware sets it to 0x62460801.

> [ 0] Full Line of Zero enable

This is only takes effect if the feature is also enabled in the cp15 aux
control register, so it's safe to always set it.  It would of course be
nice to have a way of updating the cp15 aux control register...

> [10] High Priority for SO and Dev Reads enable

The best value here depends on the workload.  It would be nice for the
system integrator to have control over it.

> [11] Store buffer device limitation disable

Ditto.

> [12] Exclusive cache configuration disable

Like FLZ, this has a corresponding cp15 bit.  It is a potentially useful
feature, so again it would be nice to have control over it.

> [13] Shared Attribute Invalidate disable
> [22] Shared attribute override disable

Not sure about these.

> [16] Associativity 8-way
> [17-19] Way-size = 64

These must match the actual hardware.

> [20] Event monitor bus disable

OK to disable.

> [21] Parity disable

Must match hardware.

> [23:24] Force write allocate = 0x1

Why was this changed?  Write-allocate can be useful, and this attribute
is normally supplied by the page table.  Forcing it off should only be
done to work around broken hardware or software that can't be fixed.

> [25] Cache replacement policy = 1

Again, the best value depends on the workload.  Better to let the OS choose.

> [26] Non-secure lock-down disable

The Linux setup code has this comment:

	/*
	 * Always enable non-secure access to the lockdown registers -
	 * we write to them as part of the L2C enable sequence so they
	 * need to be accessible.
	 */

The lockdown registers are only accessed if this bit is actually set, so
leaving it off is harmless provided the cache is left unlocked by the
secure firmware.

> [27] Non-secure interrupt access control disable

Access to the interrupt control registers is useful in conjunction with
the event counters.

> [28] Data prefetch enable
> [29] Instruction prefetch enable

These are accessible also from the prefetch control register, so as long
as that is accessible, the values set here don't matter.

> [30] Early BRESP enable

Linux wants this enabled.  It is generally good for performance.

-- 
M?ns Rullg?rd
mans at mansr.com
