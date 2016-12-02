From: fweimer@redhat.com (Florian Weimer)
Date: Fri, 2 Dec 2016 17:34:33 +0100
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161202114850.GQ1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161202114850.GQ1574@e103592.cambridge.arm.com>
Message-ID: <faabab1d-fafb-2bd1-200f-b0e3ba17e1d5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2016 12:48 PM, Dave Martin wrote:
> On Wed, Nov 30, 2016 at 01:38:28PM +0100, Florian Weimer wrote:
>
> [...]
>
>> We could add a system call to get the right stack size.  But as it depends
>> on VL, I'm not sure what it looks like.  Particularly if you need determine
>> the stack size before creating a thread that uses a specific VL setting.
>
> I missed this point previously -- apologies for that.
>
> What would you think of:
>
> 	set_vl(vl_for_new_thread);
> 	minsigstksz = get_minsigstksz();
> 	set_vl(my_vl);
>
> This avoids get_minsigstksz() requiring parameters -- which is mainly a
> concern because the parameters tomorrow might be different from the
> parameters today.
>
> If it is possible to create the new thread without any SVE-dependent code,
> then we could
>
> 	set_vl(vl_for_new_thread);
> 	new_thread_stack = malloc(get_minsigstksz());
> 	new_thread = create_thread(..., new_thread_stack);
> 	set_vl(my_vl);
>
> which has the nice property that the new thread directly inherits the
> configuration that was used for get_minsigstksz().

Because all SVE registers are caller-saved, it's acceptable to 
temporarily reduce the VL value, I think.  So this should work.

One complication is that both the kernel and the libc need to reserve 
stack space, so the kernel-returned value and the one which has to be 
used in reality will be different.

> However, it would be necessary to prevent GCC from moving any code
> across these statements -- in particular, SVE code that access VL-
> dependent data spilled on the stack is liable to go wrong if reordered
> with the above.  So the sequence would need to go in an external
> function (or a single asm...)

I would talk to GCC folks?we have similar issues with changing the FPU 
rounding mode, I assume.

Thanks,
Florian
