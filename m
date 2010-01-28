From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2010 13:03:02 +0000
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
In-Reply-To: <4B606D92.9020005@googlemail.com>
References: <4B606D92.9020005@googlemail.com>
Message-ID: <1264683782.7064.54.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-27 at 16:45 +0000, Dirk Behme wrote:
> On a 400MHz ARM11 MPCore system (NEC NaviEngine based) with kernel
> 2.6.32 we found that BogoMIPS/loops per jiffies ~doubles (see below
> [1]) by adding a nop to __delay():
> 
> --- a/arch/arm/lib/delay.S
> +++ b/arch/arm/lib/delay.S
> @@ -41,6 +41,9 @@ ENTRY(__const_udelay)    @ 0 <= r0 <= 0x
>   @ Delay routine
>   ENTRY(__delay)
> +#if defined(CONFIG_CPU_V6) && defined(CONFIG_SMP)
> +        nop
> +#endif
>           subs    r0, r0, #1
>   #if 0
>           movls    pc, lr
> 
> Any ideas what might happen here?

Branch (mis-)prediction? Alignment?

It doesn't really matter, bogomips should not be used as some form of
performance checking.

BTW, local timers give a more accurate estimate of the CPU frequency
(they are counting at half this frequency).

-- 
Catalin
