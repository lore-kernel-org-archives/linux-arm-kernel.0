From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Nov 2014 10:48:13 +0000
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <5476FFA2.8010403@free.fr>
References: <5476FFA2.8010403@free.fr>
Message-ID: <20141127104813.GP3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Because GCC is dumb.  GCC has a long history of doing stupid stuff like
this.

That's why it's often far better to code your functions assuming that
GCC isn't going to optimise very well.  So, for instance:

static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
{
 void __iomem *reg = (void *)(0xf0000000 +(0x10024));
 while (__raw_readl(reg) >> 31);
 __raw_writel(0, reg);
 return 0;
}

It's also good practise to add a cpu_relax() to the while loop:

 while (__raw_readl(reg) >> 31)
  cpu_relax();

for two reasons - the ';' at the end can easily be overlooked when reading
the code, and it also ensures that there are no bugs lurking (eg, some
ARM CPUs don't bound their write buffers, which means stores can sit in
them permanently while you're looping.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
