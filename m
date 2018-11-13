From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 13 Nov 2018 16:17:07 +0000
Subject: [PATCH 00/17] ARMv8.3 pointer authentication support
In-Reply-To: <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
Message-ID: <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Sorry for the really late response!)

On 15/10/2018 23:42, Kees Cook wrote:
> On Fri, Oct 5, 2018 at 1:47 AM, Kristina Martsenko
> <kristina.martsenko@arm.com> wrote:
>> This series adds support for the ARMv8.3 pointer authentication
>> extension. The series contains Mark's original patches to enable pointer
>> authentication for userspace [1], followed by early RFC patches using
>> pointer authentication in the kernel.
> 
> It wasn't obvious to me where the PAC mismatch exceptions will be
> caught. I'm mainly curious to compare the PAC exception handling to
> the existing stack-protector panic(). Can you point me to which
> routines manage that? (Perhaps I just missed it in the series...)

When the PAC authentication fails, it doesn't actually generate an
exception, it just flips a bit in the high-order bits of the pointer,
making the pointer invalid. Then when the pointer is dereferenced (e.g.
as a function return address), it generates the usual type of exception
for an invalid address.

So when a function return fails in user mode, the exception is handled
in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
function return fails in kernel mode, the exception is handled in
__do_kernel_fault and the task is killed.

This is different from stack protector as we don't panic the kernel, we
just kill the task. It would be difficult to panic as we don't have a
reliable way of knowing that the exception was caused by a PAC
authentication failure (we just have an invalid pointer with a specific
bit flipped). We also don't print out any PAC-related warning.

Thanks,
Kristina
