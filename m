From: msalter@redhat.com (Mark Salter)
Date: Wed, 18 Jan 2017 10:56:51 -0500
Subject: arm64: issue with invalid mode handling
Message-ID: <1484755011.6398.10.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently, I've run across some bug reports with:

  Internal error: Attempting to execute userspace memory: 8600000f

But the real problem comes before just before this. Something like:

  Bad mode in Error handler detected on CPU0, code 0xbe000000 -- SError?

or

  Bad mode in FIQ handler detected on CPU0, code 0x56000000 -- SVC (AArch64)

In handling the bad mode exceptions happening in userspace, the kernel
ends up trying to send SIGILL to the task but there is no path back to
userspace. In entry.S, there is:

	.macro	inv_entry, el, reason, regsize = 64
	kernel_entry \el, \regsize
	mov	x0, sp
	mov	x1, #\reason
	mrs	x2, esr_el1
	b	bad_mode
      ^^^^^

which SError and others use. When bad_mode() returns, the LR actually
contains the userspace address and the above internal error results.

So, what is the intent here? Should the kernel actually try to kill the
task and keep going for these sorts of things or should it panic?

--Mark
