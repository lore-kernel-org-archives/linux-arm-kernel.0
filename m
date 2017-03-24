From: opendmb@gmail.com (Doug Berger)
Date: Fri, 24 Mar 2017 09:48:40 -0700
Subject: [PATCH 3/9] arm64: mm: install SError abort handler
In-Reply-To: <20170324151654.GD29588@leverpostej>
References: <20170324144632.5896-1-opendmb@gmail.com>
 <20170324144632.5896-4-opendmb@gmail.com>
 <20170324151654.GD29588@leverpostej>
Message-ID: <58D54DE8.9020707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2017 08:16 AM, Mark Rutland wrote:
> On Fri, Mar 24, 2017 at 07:46:26AM -0700, Doug Berger wrote:
>> This commit adds support for minimal handling of SError aborts and
>> allows them to be hooked by a driver or other part of the kernel to
>> install a custom SError abort handler.  The hook function returns
>> the previously registered handler so that handlers may be chained if
>> desired.
>>
>> The handler should return the value 0 if the error has been handled,
>> otherwise the handler should either call the next handler in the
>> chain or return a non-zero value.
>
> ... so the order these get calls is completely dependent on probe
> order...
Yes, but this was an attempt to keep some flexibility in handling a
very ambiguous event.

>
>> Since the Instruction Specific Syndrome value for SError aborts is
>> implementation specific the registerred handlers must implement
>> their own parsing of the syndrome.
>
> ... and drivers have to be intimately familiar with the CPU, in order to
> be able to parse its IMPLEMENTATION DEFINED ESR_ELx.ISS value.
>
> Even then, there's no guarantee there's anything useful there, since it
> is IMPLEMENTATION DEFINED and could simply be RES0 or UNKNOWN in all
> cases.
>
> I do not think it is a good idea to allow arbitrary drivers to hook
> this fault in this manner.
>
I agree.  It should really be resolved in the fault handling code like 
it is for the ARM architecture, but the IMPLEMENTATION DEFINED nature of 
the event for ARM64 makes this unmanageable but for the most specific 
use cases, which is what is attempted here.

>> +	.align	6
>> +el0_error:
>> +	kernel_entry 0
>> +el0_error_naked:
>> +	mrs	x25, esr_el1			// read the syndrome register
>> +	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
>> +	cmp	x24, #ESR_ELx_EC_SERROR		// SError exception in EL0
>> +	b.ne	el0_error_inv
>> +el0_serr:
>> +	mrs	x26, far_el1
>> +	// enable interrupts before calling the main handler
>> +	enable_dbg_and_irq
>
> ... why?
>
> We don't do this for inv_entry today.
>
Yes, my initial downstream implementation modified inv_entry, but after 
commit 7d9e8f71b989 ("arm64: avoid returning from bad mode") added the
user abort handling for el0_inv I tried to follow that approach so user
mode errors (i.e. bad writes) wouldn't kill the kernel.

>> +	ct_user_exit
>> +	bic	x0, x26, #(0xff << 56)
>> +	mov	x1, x25
>> +	mov	x2, sp
>> +	bl	do_serr_abort
>> +	b	ret_to_user
>> +el0_error_inv:
>> +	enable_dbg
>> +	mov	x0, sp
>> +	mov	x1, #BAD_ERROR
>> +	mov	x2, x25
>> +	b	bad_mode
>> +ENDPROC(el0_error)
>
> Clearly you expect these to be delivered at arbitrary times during
> execution. What if a KVM guest is executing at the time the SError is
> delivered?
The timing isn't really arbitrary in our particular use case.  It is 
just after the bus interface has moved on from the failing transaction 
so from the bus interfaces perspective it is asynchronous.  The main 
benefit is to help debug user mode code that accidentally maps a bad 
address since we would never make such an egregious error in the kernel ;)

I'm afraid I'm not fully versed on the implications to KVM here.
>
> To be quite frank, I don't believe that we can reliably and safely
> handle this misfeature in the kernel, and this infrastructure only
> provides the illusion that we can.
>
> I do not think it makes sense to do this.
>
> Thanks,
> Mark.
>
I understand your position since this was the cleanest approach I came 
up with and it is admittedly ugly.  I would be happy to entertain any 
better suggestion on how this could be handled more cleanly.

If you would consider an alternative implementation where we scrap the 
SError handler (i.e. maintain the ugliness in our downstream kernel) in 
favor of a more gentle user mode crash on SError that allows the kernel 
the opportunity to service the interrupt for diagnostic purposes I could 
try to repackage that.

Thanks for the review!
     Doug
