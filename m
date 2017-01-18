From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Jan 2017 16:10:31 +0000
Subject: arm64: issue with invalid mode handling
In-Reply-To: <1484755011.6398.10.camel@redhat.com>
References: <1484755011.6398.10.camel@redhat.com>
Message-ID: <20170118161031.GL3231@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jan 18, 2017 at 10:56:51AM -0500, Mark Salter wrote:
> Recently, I've run across some bug reports with:
> 
>   Internal error: Attempting to execute userspace memory: 8600000f
> 
> But the real problem comes before just before this. Something like:
> 
>   Bad mode in Error handler detected on CPU0, code 0xbe000000 -- SError?
> 
> or
> 
>   Bad mode in FIQ handler detected on CPU0, code 0x56000000 -- SVC (AArch64)
> 
> In handling the bad mode exceptions happening in userspace, the kernel
> ends up trying to send SIGILL to the task but there is no path back to
> userspace. In entry.S, there is:
> 
> 	.macro	inv_entry, el, reason, regsize = 64
> 	kernel_entry \el, \regsize
> 	mov	x0, sp
> 	mov	x1, #\reason
> 	mrs	x2, esr_el1
> 	b	bad_mode
>       ^^^^^
> 
> which SError and others use. When bad_mode() returns, the LR actually
> contains the userspace address and the above internal error results.

Thanks for the report, it's much appreciated.

> So, what is the intent here? Should the kernel actually try to kill the
> task and keep going for these sorts of things or should it panic?

This was an unintended consequence of commit 9955ac47f4ba1c95 ("arm64:
don't kill the kernel on a bad esr from el0"), which was intended to
cater for certain synchronous exceptions.

We should treat SError as fatal; I'll spin a patch to correct that and
to avoid the erroneous return.

Thanks,
Mark.
