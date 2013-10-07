From: joelf@ti.com (Joel Fernandes)
Date: Sun, 6 Oct 2013 23:56:57 -0500
Subject: [RFC] ARM: kernel: irq: Simplify allocation of stack frame
In-Reply-To: <20131006224150.GA25647@n2100.arm.linux.org.uk>
References: <1381098649-21417-1-git-send-email-joelf@ti.com>
 <20131006224150.GA25647@n2100.arm.linux.org.uk>
Message-ID: <52523F19.9080104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2013 05:41 PM, Russell King - ARM Linux wrote:
> On Sun, Oct 06, 2013 at 05:30:47PM -0500, Joel Fernandes wrote:
>> On receiving IRQ exception in SVC mode, all the SVC mode registers are saved
>> onto the stack very early on.
>>
>> The stack frame allocation code for IRQ entry during SVC mode (svc_entry) is
>> hard to read as 4-less is allocated initially only to be allocated later
>> implicity using the mov r3, [sp, #-4]! instruction. We make code easier to read
>> by allocating the 4 bytes on the stack frame in the beginning itself and remove
>> all instances where 4 bytes is adjusted.
> 
> You omit to say that this results in saving one additional register

Ok, I will add this detail to the commit message.

> unnecessarily in the stmia.  We could use a stmib there instead which
> would avoid that issue while keeping the rest of the change.

But stmib is not available in THUMB mode, so this will break the THUMB builds.

usr_entry does something similar:
 ARM(   stmib   sp, {r1 - r12}  )
 THUMB( stmia   sp, {r0 - r12}  )

Let me know your suggestions about using ARM/THUMB macros or stmia for both
cases. Thanks.

Regards,

-Joel
