From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 May 2010 14:29:40 +0100
Subject: [PATCH v2] [RESEND] Handle instruction cache maintenance fault
	properly
In-Reply-To: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
References: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
Message-ID: <1273843780.28312.27.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-11 at 11:33 +0100, Kirill A. Shutemov wrote:
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 9d40c34..7f193ea 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -463,7 +463,12 @@ static struct fsr_info {
>         { do_bad,               SIGILL,  BUS_ADRALN,    "alignment exception"              },
>         { do_bad,               SIGKILL, 0,             "terminal exception"               },
>         { do_bad,               SIGILL,  BUS_ADRALN,    "alignment exception"              },
> +/* Do we need runtime check ? */
> +#if __LINUX_ARM_ARCH__ < 6
>         { do_bad,               SIGBUS,  0,             "external abort on linefetch"      },
> +#else
> +       { do_translation_fault, SIGSEGV, SEGV_MAPPER,   "I-cache maintenance
> fault"     },
> +#endif

Apart from line wrapping, it should be SEGV_MAPERR above.

-- 
Catalin
