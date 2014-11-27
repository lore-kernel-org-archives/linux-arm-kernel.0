From: w@1wt.eu (Willy Tarreau)
Date: Thu, 27 Nov 2014 12:09:50 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <5476FFA2.8010403@free.fr>
References: <5476FFA2.8010403@free.fr>
Message-ID: <20141127110950.GA23012@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 27, 2014 at 11:40:34AM +0100, Mason wrote:
> Hello everyone,
> 
> Consider the following code (preprocessor output):
> 
> static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
> {
>  while (__raw_readl((volatile void *)(0xf0000000 +(0x10024))) >> 31);
>  __raw_writel(0, (volatile void *)(0xf0000000 +(0x10024)));
>  return 0;
> }
> 
> gcc generates the following code:
> (version and command-line in sig below)
> 
> 00000014 <tangox_target>:
>   14:   e3a03000        mov     r3, #0
>   18:   e34f3001        movt    r3, #61441      ; 0xf001
>   1c:   e3a02000        mov     r2, #0
>   20:   e34f2001        movt    r2, #61441      ; 0xf001
>   24:   e5931024        ldr     r1, [r3, #36]   ; 0x24
>   28:   e3510000        cmp     r1, #0
>   2c:   bafffffa        blt     1c <tangox_target+0x8>
>   30:   e3a00000        mov     r0, #0
>   34:   e5820024        str     r0, [r2, #36]   ; 0x24
>   38:   e12fff1e        bx      lr
> 
> Do you know why gcc duplicates the address in r2 and r3?
> And keeps putting the address in r2 over and over in the loop?

I'm used to see crap like this all the time, which is why I
*always* look at the assembly code for any performance-sensible
section. In general, I try hard to help gcc do the right thing,
or at least make it harder for it to do the wrong thing. Yes
that's painful. But with a bit of training, you get automatisms
and don't think about it anymore.

Above it's very likely that if you compute your offset into a
variable and use this variable, it will magically work.

Hoping this helps,
Willy
