From: james.morse@arm.com (James Morse)
Date: Tue, 17 Jan 2017 10:23:50 +0000
Subject: [PATCH V7 04/10] arm64: exception: handle Synchronous External
 Abort
In-Reply-To: <20170116115309.GE1510@arm.com>
References: <1484244924-24786-1-git-send-email-tbaicar@codeaurora.org>
 <1484244924-24786-5-git-send-email-tbaicar@codeaurora.org>
 <20170116115309.GE1510@arm.com>
Message-ID: <587DF0B6.4060000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 16/01/17 11:53, Will Deacon wrote:
> On Thu, Jan 12, 2017 at 11:15:18AM -0700, Tyler Baicar wrote:
>> SEA exceptions are often caused by an uncorrected hardware
>> error, and are handled when data abort and instruction abort
>> exception classes have specific values for their Fault Status
>> Code.
>> When SEA occurs, before killing the process, go through
>> the handlers registered in the notification list.
>> Update fault_info[] with specific SEA faults so that the
>> new SEA handler is used.

>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 05d2bd7..81039c7 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -480,6 +496,28 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  	return 1;
>>  }
>>  
>> +/*
>> + * This abort handler deals with Synchronous External Abort.
>> + * It calls notifiers, and then returns "fault".
>> + */
>> +static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>> +{
>> +	struct siginfo info;
>> +
>> +	atomic_notifier_call_chain(&sea_handler_chain, 0, NULL);
>> +
>> +	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
>> +		 fault_name(esr), esr, addr);
>> +
>> +	info.si_signo = SIGBUS;
>> +	info.si_errno = 0;
>> +	info.si_code  = 0;
>> +	info.si_addr  = (void __user *)addr;
>> +	arm64_notify_die("", regs, &info, esr);
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct fault_info {
>>  	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
>>  	int	sig;
>> @@ -502,22 +540,22 @@ static const struct fault_info {
>>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
>>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
>>  	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
>> -	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
>> +	{ do_sea,		SIGBUS,  0,		"synchronous external abort"	},
>>  	{ do_bad,		SIGBUS,  0,		"unknown 17"			},
>>  	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
>>  	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
>> -	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
>> -	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
>> -	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
>> -	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
>> -	{ do_bad,		SIGBUS,  0,		"synchronous parity error"	},
>> +	{ do_sea,		SIGBUS,  0,		"level 0 SEA (translation table walk)"	},
>> +	{ do_sea,		SIGBUS,  0,		"level 1 SEA (translation table walk)"	},
>> +	{ do_sea,		SIGBUS,  0,		"level 2 SEA (translation table walk)"	},
>> +	{ do_sea,		SIGBUS,  0,		"level 3 SEA (translation table walk)"	},
> 
> Perhaps I wasn't clear enough in my previous review, but please expand the
> acronym for strings and comments.


The 'SEA' in this user-string doesn't add anything. Now that these use do_sea()
instead of do_bad(), when they are printed won't it be:
> Synchronous External Abort: level 3 SEA (translation table walk) (...) at ....



Thanks,

James
