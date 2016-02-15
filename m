From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Feb 2016 10:03:19 +0000
Subject: [PATCH RESEND] arm64: add alignment fault hanling
In-Reply-To: <2039801453.916991455526707908.JavaMail.weblogic@epmlwas09b>
References: <2039801453.916991455526707908.JavaMail.weblogic@epmlwas09b>
Message-ID: <20160215100319.GA13683@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:58:32AM +0000, EunTaik Lee wrote:
> Userspace memory is mapped as below:
> F2A7F000--F2A7FFFF Normal Memory
> F2A80000--F2A80FFF Device nGnRnE

How do you end up with Device nGnRnE in user space? I thought we should
have got some guard page.

> And that userspace application makes a system call
> as below:
> 
> -009 |do_strncpy_from_user(inline)
> -009 |strncpy_from_user()
> -010 |getname_flags()
> -011 |user_path_at_empty()
> -012 |user_path_at()
> -013 |SYSC_faccessat(inline)
> -013 |sys_faccessat()
> -014 |__sys_trace(asm)
> --> |exception
> 
> The string spans from 0xF2A7FFC1 to 0xF2A7FFFB.
> 
> When do_strncpy_from_user() reads the last (unsigned long)
> value, the alignement fault is triggered. The 8 byte
> from 0xF2A7FFC1 spans to the next page that is mapped as
> Device nGnRnE, which does not allow an unaligned access,
> causes the abort.

do_strncpy_from_user() relies on unsafe_get_user() not being able to
read 8 bytes. The problem now is that it doesn't get a page fault but an
alignment one is isn't handled.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 19211c4..8257d4f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -371,6 +371,16 @@ static int __kprobes do_translation_fault(unsigned long addr,
> return 0;
> }
> 
> +static int __kprobes do_alignment_fault(unsigned long addr,
> +   unsigned int esr,
> +   struct pt_regs *regs)
> +{
> + if (addr >= TASK_SIZE && fixup_exception(regs))
> + return 0;
> +
> + return 1;
> +}

Why addr >= TASK_SIZE? addr here should be the fault address, not pc.

> +
> /*
>   * This abort handler always returns "fault".
>   */
> @@ -418,7 +428,7 @@ static struct fault_info {
> { do_bad, SIGBUS,  0, "synchronous parity error (translation table walk" },
> { do_bad, SIGBUS,  0, "synchronous parity error (translation table walk" },
> { do_bad, SIGBUS,  0, "unknown 32" },
> - { do_bad, SIGBUS,  BUS_ADRALN, "alignment fault" },
> + { do_alignment_fault, SIGBUS,  BUS_ADRALN, "alignment fault" },

The simplest would be to use do_bad_area() here without any additional
function.

-- 
Catalin
