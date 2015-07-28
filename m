From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 28 Jul 2015 09:29:52 +0100
Subject: [PATCH 1/3] nmi: create generic NMI backtrace implementation
In-Reply-To: <20150725144229.GZ7557@n2100.arm.linux.org.uk>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
 <E1ZFTSm-0006uz-3s@rmk-PC.arm.linux.org.uk> <55A7753C.9020708@linaro.org>
 <20150716093744.GI7557@n2100.arm.linux.org.uk> <55A77E9D.2030509@linaro.org>
 <20150725144229.GZ7557@n2100.arm.linux.org.uk>
Message-ID: <55B73D80.4010901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/15 15:42, Russell King - ARM Linux wrote:
> On Thu, Jul 16, 2015 at 10:51:25AM +0100, Daniel Thompson wrote:
>> On 16/07/15 10:37, Russell King - ARM Linux wrote:
>>> That can be implemented in the arch raise() method if needed - most
>>> architectures shouldn't need it as if they are properly raising a NMI
>>> which is, by definition, deliverable with normal IRQs disabled.
>>
>> Agreed. The bug certainly could be fixed in the ARM raise() function.
>>
>> However I'm still curious whether there is any architecture that benefits
>> from forcing the current CPU into an NMI handler? Why doesn't the
>> don't-run-unnecessary-code argument apply here as well?
>
> The benefit is that we get a consistent way of invoking the backtrace,
> since causing the NMI exception gives us a 'struct pt_regs' to work
> with, which we wouldn't otherwise have if we tried to call it "inline".
>
> The NMI backtrace includes dumping the register state of the NMI-
> receiving CPUs, which needs a 'struct pt_regs' and generating a that in
> arch-independent code wouldn't be nice.

Previously I have relied on dump_stack() for this. That should work 
everywhere although guess the arch code might display the stack display 
differently.


> In any case, if this area needs changing in the generic code, it should
> be done as a separate change so that it can be properly assessed and
> validated on x86.

Do you want me to supply a patch to fix the IRQ issue in the arm 
specific code for now?

If we don't fix that then the behaviour of SysRq-L on ARM will change 
and the output will no longer include the CPU that executed SysRq-L.


> In the mean time, I will action Thomas' request to put it into my tree
> so that we can get some reasonable linux-next time with it, and hopefully
> have some progress towards FIQ-based backtracing for ARM.

Great!
