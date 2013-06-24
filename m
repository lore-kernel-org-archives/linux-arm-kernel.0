From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 24 Jun 2013 09:11:08 +0100
Subject: [GIT PULL] Keystone SOC support for 3.11
In-Reply-To: <201306211819.36288.arnd@arndb.de>
References: <1371255346-3000-1-git-send-email-santosh.shilimkar@ti.com>
 <201306211819.36288.arnd@arndb.de>
Message-ID: <20130624081057.GA11105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 06:19:36PM +0200, Arnd Bergmann wrote:
> On Saturday 15 June 2013, Santosh Shilimkar wrote:
> > The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> > 
> >   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc
> > 
> > for you to fetch changes up to cc92fc07c26c1bec1abb58f0cd356b13dc00a28c:
> > 
> >   ARM: dts: keystone: Add minimal Keystone SOC device tree data (2013-06-14 19:45:46 -0400)
> > 
> > ----------------------------------------------------------------
> > SOC support for Keystone II devices:
> > 
> > - Minimal machine and device-tree support with arch_timers and console UART
> > - Reboot hook using PLL reset
> > - Low level debug support using UART
> > - SMP boot support
> 
> I'm getting a build warning with keystone_defconfig that I have not 
> encountered before:
> 
> arch/arm/mm/fault.c:495:1: warning: 'do_sect_fault' defined but not used [-Wunused-function]
>  do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  ^
> 
> Any idea what is going on here and what the fix is? Should that function
> just be hidden in #ifndef CONFIG_ARM_LPAE?

Many apologies, I think this was introduced by my huge page patches. For
transparent hugepages to function correctly, access flag faults need to be
handled by do_page_fault rather than do_sect_fault. Even without THP enabled
the standard page fault handler is safe to use, so I removed the do_sect_fault
entry from fsr-3level.c.

Originally I had non-LPAE huge page code too in the series and one of those
patches re-wired fsr-2level.c and then completely removed do_sect_fault.

When I split the patch series I didn't spot that do_sect_fault was in limbo for
LPAE.

I think the do_sect_fault can safely be surrounded by #ifndef CONFIG_ARM_LPAE.
Should I send a patch to do this?

Thanks,
-- 
Steve

> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
