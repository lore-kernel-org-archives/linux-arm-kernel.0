From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 28 Oct 2009 19:32:34 +0000
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910281800.47681.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<alpine.LFD.2.00.0910281209240.10545@xanadu.home>
	<200910281723.01684.jpihet@mvista.com>
	<200910281800.47681.jpihet@mvista.com>
Message-ID: <20091028193234.GB17475@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet wrote:
>  				usp = (u32 __user *)regs->ARM_sp;
>  
> -				put_user(regs->ARM_pc, usp);
> -				regs->ARM_pc = KERN_RESTART_CODE;
> +				if (put_user(regs->ARM_pc, usp) == 0) {
> +					regs->ARM_pc = KERN_RESTART_CODE;
> +				} else {
> +					regs->ARM_sp += 4;
> +					force_sigsegv(0, current);
> +				}
>  #endif
>  			}
>  		}

This one looks good to me.

-- Jamie
