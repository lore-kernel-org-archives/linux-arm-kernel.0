From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Feb 2016 17:11:33 +0000
Subject: [PATCH v2] arm64: add alignment fault hanling
In-Reply-To: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
References: <329817481.954581455597874663.JavaMail.weblogic@epmlwas08c>
Message-ID: <20160216171133.GB24950@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 04:44:38AM +0000, EunTaik Lee wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 19211c4..a5ebb99 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -371,6 +371,14 @@ static int __kprobes do_translation_fault(unsigned long addr,
>  	return 0;
>  }
>  
> +static int __kprobes do_alignment_fault(unsigned long addr,
> +					  unsigned int esr,
> +					  struct pt_regs *regs)
> +{
> +	do_bad_area(addr, esr, regs);
> +	return 0;
> +}
> +
>  /*
>   * This abort handler always returns "fault".
>   */
> @@ -418,7 +426,7 @@ static struct fault_info {
>  	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
>  	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
>  	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
> -	{ do_bad,		SIGBUS,  BUS_ADRALN,	"alignment fault"		},
> +	{ do_alignment_fault,	SIGBUS,  BUS_ADRALN,	"alignment fault"		},

Do you need a new function, can you not just add do_bad_area in the
fault_info array?

-- 
Catalin
