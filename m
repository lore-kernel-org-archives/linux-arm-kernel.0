From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed, 14 Nov 2018 15:54:43 +0000
Subject: [PATCH 00/17] ARMv8.3 pointer authentication support
In-Reply-To: <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
 <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
 <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
Message-ID: <bcfe9fd2-8832-f975-8462-18e6645ffec6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2018 23:09, Kees Cook wrote:
> On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
> <kristina.martsenko@arm.com> wrote:
>> When the PAC authentication fails, it doesn't actually generate an
>> exception, it just flips a bit in the high-order bits of the pointer,
>> making the pointer invalid. Then when the pointer is dereferenced (e.g.
>> as a function return address), it generates the usual type of exception
>> for an invalid address.
> 
> Ah! Okay, thanks. I missed that detail. :)
> 
> What area of memory ends up being addressable with such bit flips?
> (i.e. is the kernel making sure nothing executable ends up there?)

The address will be in between the user and kernel address ranges, so
it's guaranteed to be invalid and not address any memory.

Specifically, assuming a 48-bit VA configuration, user addresses must
have bits [55:48] clear and kernel addresses must have bits [63:48] set.
When authentication fails it will set two bits in those ranges to "10"
or "01", ensuring that the address is no longer a valid user or kernel
address.

>> So when a function return fails in user mode, the exception is handled
>> in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
>> function return fails in kernel mode, the exception is handled in
>> __do_kernel_fault and the task is killed.
>>
>> This is different from stack protector as we don't panic the kernel, we
>> just kill the task. It would be difficult to panic as we don't have a
>> reliable way of knowing that the exception was caused by a PAC
>> authentication failure (we just have an invalid pointer with a specific
>> bit flipped). We also don't print out any PAC-related warning.
> 
> There are other "guesses" in __do_kernel_fault(), I think? Could a
> "PAC mismatch?" warning be included in the Oops if execution fails in
> the address range that PAC failures would resolve into?

Sounds reasonable to me, I'll add a warning.

Thanks,
Kristina
