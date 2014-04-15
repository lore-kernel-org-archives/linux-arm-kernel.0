From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 13:38:40 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <534D6A1F.70102@linaro.org>
References: <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
 <20140415154637.GA3560@redhat.com> <534D6A1F.70102@linaro.org>
Message-ID: <20140415.133840.2270952586596479547.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Long <dave.long@linaro.org>
Date: Tue, 15 Apr 2014 13:19:27 -0400

> On 04/15/14 11:46, Oleg Nesterov wrote:
>> 
>> But. Please do not add copy_to_user_page() into copy_to_page() (as your patch
>> did). This is certainly not what uprobe_write_opcode() wants, we do not want
>> or need "flush" in this case. The same for __create_xol_area().
>> 
> 
> It looked me like a call to a new __copy_to_user_page(current->mm, ...) in xol_get_insn_slot()
> would be in line with David Miller's suggestion and would cure the problem on ARM (and hopefuly
> be more philosophically correct for all architectures):

It occurs to me that because of the specific environment in which this
executes we can make the interface take advantage of the invariants at
this call site:

1) We are copying into userspace and thus current->mm

2) We are only storing an instruction or two

So it would be just like the dynamic linker lazy resolving a PLT slot in
userland.

Furthermore, we can do the stores using something akin to put_user(),
directly store them into userspace.

This avoids completely any D-cache aliasing issues.  The kernel stores
to the same address, and therefore the same cache lines, as userspace
would.

So for example, since even on the most braindamaged sparc64 cpus the
remote cpus will have their I-cache snoop the store we do locally we
just need to do a simple flush on the local cpu where this store is
happening.  So I'd like to do this something like:

	stw	%r1, [%r2 + 0x0]
	flush	%r2

PowerPC could probably do something similar.

The copy_to_user_page() interface has to deal with storing into a non-current
'mm' and therefore via the kernel side copy of the page and that's why the
D-cache aliasing issues are so painful to deal with.

Just a thought...
