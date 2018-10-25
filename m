From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Oct 2018 19:03:32 +0100
Subject: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
In-Reply-To: <a6f5b6e7-4d3e-dd8f-4028-0ee370b11722@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com>
 <20181025021013.GA30116@lunn.ch>
 <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
 <20181025173242.GC30658@n2100.armlinux.org.uk>
 <a6f5b6e7-4d3e-dd8f-4028-0ee370b11722@gmail.com>
Message-ID: <20181025180332.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 10:53:12AM -0700, Florian Fainelli wrote:
> Something like this below? It does not have to be an alternative
> solution, I would find it useful for perf to make sure the vectors page
> is present in the virtual address space by having an explicit test. perf
> maintains, what do you think?

Yep, I'd swap the two tests merely because the check for 'sig' will be
slightly cheaper than the mask-and-test of addr, but it probably doesn't
make that much difference.

> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f4ea4c62c613..b045b48d368d 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned
> long addr,
>                 show_regs(regs);
>         }
>  #endif
> +#ifndef CONFIG_KUSER_HELPERS
> +       if (((addr & PAGE_MASK) == 0xffff0000) && (sig == SIGSEGV))
> +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at
> 0x%08lx\n",
> +                      tsk->comm, addr);
> +#endif
> 
>         tsk->thread.address = addr;
>         tsk->thread.error_code = fsr;
> 
> 
> > 
> > BTW, I note that the help text for CONFIG_KUSER_HELPERS needs to be
> > updated.
> > 
> 
> 
> -- 
> Florian

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
