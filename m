From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 19 Jul 2010 17:51:48 +0400
Subject: [PATCH 4/5] ARMv6K and ARMv7 use fault statuses 3 and 6 as Access
	Flag fault
In-Reply-To: <20100719112012.GA12602@shutemov.name>
References: <cover.1279529223.git.kirill@shutemov.name>
	<bfd71c480c8d137cc4cc6261a42f514f9024ee53.1279529223.git.kirill@shutemov.name>
	<4C4424D4.3000002@ru.mvista.com>
	<20100719112012.GA12602@shutemov.name>
Message-ID: <4C445874.40500@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kirill A. Shutemov wrote:

>> Hello.

>> Kirill A. Shutsemov wrote:

>>> Statuses 3 (0b00011) and 6 (0x00110) of DFSR are Access Flags faults on
>>> ARMv6K and ARMv7. Let's patch fsr_info[] at runtime if we are on ARMv7
>>> or later.
>>> Unfortunately, we don't have runtime check for 'K' extension, so we
>>> can't check for it.
>>> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
>> [...]
>>> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
>>> index 77cfdbe..d073b64 100644
>>> --- a/arch/arm/mm/alignment.c
>>> +++ b/arch/arm/mm/alignment.c
>>> @@ -926,8 +926,18 @@ static int __init alignment_init(void)
>>>  
>>>  	hook_fault_code(1, do_alignment, SIGBUS, BUS_ADRALN,
>>>  			"alignment exception");
>>> -	hook_fault_code(3, do_alignment, SIGBUS, BUS_ADRALN,
>>> -			"alignment exception");
>>> +
>>> +	/*
>>> +	 * ARMv6K and ARMv7 use fault status 3 (0b00011) as Access Flag section
>>> +	 * fault, not as alignment error.
>>> +	 *
>>> +	 * TODO: handle ARMv6K properly. Runtime check for 'K' extension is
>>> +	 * needed.
>>> +	 */
>>> +	if (cpu_architecture() <= CPU_ARCH_ARMv6) {
>>> +		hook_fault_code(3, do_alignment, SIGBUS, BUS_ADRALN,
>>> +				"alignment exception");
>>> +	}

>>     Curly braces not neeed here. I assume you haven't run your patch thru 
>> scripts/checkpatch.pl?

> total: 0 errors, 0 warnings, 37 lines checked

    Strange, it used to warn about superfluous braces...

> I'll remove it if you want. But I think it reasonable to leave braces in
> cases like:

> if (condition) {
> 	do_this(a, very_long, list, of, parameters,
> 		second, part, of, the, list);
> }

> What do you think?

    I wouldn't use braces in this case. But it's up to you after all, if 
checkpatch.pl is indifferent about them...

WBR, Sergei
