From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 17 May 2011 19:56:04 +0100 (BST)
Subject: Question on Thumb2 assembly, conditionals
In-Reply-To: <20110517114455.GA27656@arm.com>
References: <20110517110911.GA27546@arm.com> <20110517114455.GA27656@arm.com>
Message-ID: <alpine.DEB.2.00.1105171327260.7161@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 17 May 2011, Dave Martin wrote:

> On Mon, May 16, 2011 at 08:00:24PM +0100, Frank Hofmann wrote:
>> On Mon, 16 May 2011, Dave Martin wrote:
>>
>>> Hi,
>>>
>>> On Mon, May 16, 2011 at 5:34 PM, Frank Hofmann <frank.hofmann@tomtom.com> wrote:
>>>
>>> [...]
>>>
>>>> since you're the "Thumb2 kernel man", maybe you've got a quick / simple
>>>> answer.
>>>
>>> (What a reputation... ;)
>>>
>> [ ... ]
>>> Most likely, you are missing ".syntax unified" -- note that the kernel
>>> build automatically prepends that directive to the assembler input
>>> when building a Thumb-2 kernel, which is why you won't usually see it
>>> in the sources.
>>
>> I've tried that in userland; have no working thumb-2 kernel here,
>> our env is Froyo-based and both the kernel and default toolchain too
>> old to compile successfully for thumb2.
>>
>> I'm trying to get my hibernation support code (the page copy loop in
>> swsusp_arch_resume) to be thumb-2 clean; but since it clones
>> copy_page.S which uses conditional ldm I've thought it might be a
>> good idea to be explicit. The reason why this isn't simply branching
>> is because it always does a load + branch pair, i.e.
>
> Can you reuse the copy_page.S without copying it?  Copy-pasting code can
> lead to fragmentation and maintenance problems further down the line.
>
> There already seems to be a arch/arm/lib/copy_template.S to provide a
> common core for optimised memcpy operations; maybe that could be used.

swsusp_arch_resume() has the constraint that, as part of its normal 
operation, it overwrites kernel data - including the stack of the current 
thread. That's by design / intent.

Hence, no stack accesses (i.e. no function calls) - till the copy loop is 
done.

For this specific one, claim "special case" ;-)


But anyway, I've finally found a way to actually perform the assembler 
page copy loop using C-with-inline-asm:


 	extern struct pbe *restore_pblist;

 	u8 swsusp_resume_stack[PAGE_SIZE]
 		__attribute__((aligned(PAGE_SIZE))) __nosavedata;

 	int __naked swsusp_arch_resume(void)
 	{
 	        register struct pbe *pbe;
 		register void *sp asm("sp") =
 			swsusp_resume_stack + PAGE_SIZE - 8;

 	        __asm__ __volatile__("" : "+r"(sp));

 	        for (pbe = restore_pblist; pbe; pbe = pbe->next)
 	                copy_page(pbe->orig_address, pbe->address);

 		// inline asm block for SoC core state restore

 	        return 0;
 	}


This seems to do the trick - bounce it over a temporary stack which is not 
being touched by the copy loop, and there's no longer a need for a copy 
loop in assembly. 
I'm not counting cycles, seems "fast enough", that one function call per 
page copied might be measurable but is not subjectively noticeable. From 
my point of view at least, this wins.


Note: I'm not advising anyone to try the above _elsewhere_. 
swsusp_arch_resume is, apart from schedulers and trap handlers, probably 
the only place in the system whose business it is to meddle with 
stackpointers.


[ ... ]
>>> Note that that for new code, it's better to use the suffixed condition
>>> codes (i.e., ldmiaeq instead of ldmeqia) since the kernel now only
>>> supports being built with binutils versions which in any case are new
>>> enough to support this syntax.
>>
>> Yes, again, if you're on a sufficiently recent kernel :-D
>
> Of course, it depends on your precise circumstances.

I've found a way to at least compile my env for THUMB2.
Thanks for all your help with this !




FrankH.
