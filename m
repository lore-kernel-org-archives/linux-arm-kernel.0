From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 15:16:54 +0000
Subject: [PATCH 3/9] arm64: mm: install SError abort handler
In-Reply-To: <20170324144632.5896-4-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
 <20170324144632.5896-4-opendmb@gmail.com>
Message-ID: <20170324151654.GD29588@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 07:46:26AM -0700, Doug Berger wrote:
> This commit adds support for minimal handling of SError aborts and
> allows them to be hooked by a driver or other part of the kernel to
> install a custom SError abort handler.  The hook function returns
> the previously registered handler so that handlers may be chained if
> desired.
> 
> The handler should return the value 0 if the error has been handled,
> otherwise the handler should either call the next handler in the
> chain or return a non-zero value.

... so the order these get calls is completely dependent on probe
order...

> Since the Instruction Specific Syndrome value for SError aborts is
> implementation specific the registerred handlers must implement
> their own parsing of the syndrome.

... and drivers have to be intimately familiar with the CPU, in order to
be able to parse its IMPLEMENTATION DEFINED ESR_ELx.ISS value.

Even then, there's no guarantee there's anything useful there, since it
is IMPLEMENTATION DEFINED and could simply be RES0 or UNKNOWN in all
cases.

I do not think it is a good idea to allow arbitrary drivers to hook
this fault in this manner.

> +	.align	6
> +el0_error:
> +	kernel_entry 0
> +el0_error_naked:
> +	mrs	x25, esr_el1			// read the syndrome register
> +	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
> +	cmp	x24, #ESR_ELx_EC_SERROR		// SError exception in EL0
> +	b.ne	el0_error_inv
> +el0_serr:
> +	mrs	x26, far_el1
> +	// enable interrupts before calling the main handler
> +	enable_dbg_and_irq

... why?

We don't do this for inv_entry today.

> +	ct_user_exit
> +	bic	x0, x26, #(0xff << 56)
> +	mov	x1, x25
> +	mov	x2, sp
> +	bl	do_serr_abort
> +	b	ret_to_user
> +el0_error_inv:
> +	enable_dbg
> +	mov	x0, sp
> +	mov	x1, #BAD_ERROR
> +	mov	x2, x25
> +	b	bad_mode
> +ENDPROC(el0_error)

Clearly you expect these to be delivered at arbitrary times during
execution. What if a KVM guest is executing at the time the SError is
delivered?

To be quite frank, I don't believe that we can reliably and safely
handle this misfeature in the kernel, and this infrastructure only
provides the illusion that we can.

I do not think it makes sense to do this.

Thanks,
Mark.
