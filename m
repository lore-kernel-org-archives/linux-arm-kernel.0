From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 10 Jul 2018 16:16:28 +1000
Subject: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than
 __get_user/__put_user
In-Reply-To: <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
 <20180708210330.27324-3-mathieu.desnoyers@efficios.com>
 <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
Message-ID: <87tvp7mx8j.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On Jul 8, 2018, at 5:03 PM, Mathieu Desnoyers mathieu.desnoyers at efficios.com wrote:
>
>> In preparation to use __u64 for the rseq_cs pointer field, 32-bit
>> architectures need to read this 64-bit value located in user-space
>> addresses.
>> 
>> __get_user is used to read this value, given that its access check has
>> already been performed with access_ok() on rseq registration.
>> 
>> arm does not implement 8-byte __get_user. Rather than trying to
>> improve __get_user on ARM, use get_user/put_user across rseq instead.
>> 
>> If those end up showing up in benchmarks, the proper approach would be to
>> use user_access_begin() / unsafe_get/put_user() / user_access_end()
>> anyway.
>
> So, another twist to this story: ppc32 does not implement u64 get_user().

Or __get_user() for that matter.

But we should just fix it.

We have the asm to do it, it's just the fact that __gu_val is unsigned
long causes the size > sizeof(x) check here to fail:

#define __get_user_size(x, ptr, size, retval)			\
do {								\
	retval = 0;						\
	__chk_user_ptr(ptr);					\
	if (size > sizeof(x))					\
		(x) = __get_user_bad();				\



We seem to be able to fix that with the __inttype() trick that x86 uses.

That's probably not 4.18 material though. But if you want to go with
copy_from_user() for now you could then switch to get_user() for 4.19.

cheers
