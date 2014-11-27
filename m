From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 12:23:10 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <5476FFA2.8010403@free.fr>
References: <5476FFA2.8010403@free.fr>
Message-ID: <7562945.VT72mKYTjh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 11:40:34 Mason wrote:
> Hello everyone,
> 
> Consider the following code (preprocessor output):
> 
> static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
> {
>   while (__raw_readl((volatile void *)(0xf0000000 +(0x10024))) >> 31);
>   __raw_writel(0, (volatile void *)(0xf0000000 +(0x10024)));
>   return 0;
> }

First of all:
- don't use __raw_readl in driver code, use readl or readl_relaxed.
- When you do a busy-loop, add a cpu_relax().
- use proper types: 'void __iomem *', not 'volatile void *'.
- use of_iomap or devm_ioremap_resource to get to the pointer for
  a device, don't just hardcode virtual addresses.

> gcc generates the following code:
> (version and command-line in sig below)
> 
> 00000014 <tangox_target>:
>    14:   e3a03000        mov     r3, #0
>    18:   e34f3001        movt    r3, #61441      ; 0xf001
>    1c:   e3a02000        mov     r2, #0
>    20:   e34f2001        movt    r2, #61441      ; 0xf001
>    24:   e5931024        ldr     r1, [r3, #36]   ; 0x24
>    28:   e3510000        cmp     r1, #0
>    2c:   bafffffa        blt     1c <tangox_target+0x8>
>    30:   e3a00000        mov     r0, #0
>    34:   e5820024        str     r0, [r2, #36]   ; 0x24
>    38:   e12fff1e        bx      lr
> 
> Do you know why gcc duplicates the address in r2 and r3?
> And keeps putting the address in r2 over and over in the loop?
> 
> I was expecting something more along these lines:
> 
> 00000014 <tangox_target>:
>    14:   e3a03000        mov     r3, #0
>    18:   e34f3001        movt    r3, #61441      ; 0xf001
>    1c:   e5931024        ldr     r1, [r3, #36]   ; 0x24
>    20:   e3510000        cmp     r1, #0
>    24:   bafffffa        blt     1c <tangox_target+0x8>
>    28:   e3a00000        mov     r0, #0
>    2c:   e5820024        str     r0, [r3, #36]   ; 0x24
>    30:   e12fff1e        bx      lr

I suspect the use of 'volatile' just makes gcc avoid all
optimizations. Try cleaning up the code first and see if it
still happens, then use a local variable to store the __iomem
token if you have to.

	Arnd
