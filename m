From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 6 Nov 2012 11:18:02 +0200
Subject: [PATCHv9 0/8] ARM: OMAP4: core retention support
In-Reply-To: <87d2zrg04t.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <87d2zrg04t.fsf@deeprootsystems.com>
Message-ID: <1352193483.8788.43.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Mon, 2012-11-05 at 14:23 -0800, Kevin Hilman wrote:
> Hi Tero,
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Hi,
> >
> > Changes compared to previous version:
> > - rebased on top of 3.7-rc1
> > - applies on top of latest func pwrst code (v6)
> > - added back patch #1 to this set (it wasn't queued yet after all)
> > - added patch #7 for fixing a bug in the functional pwrst code
> > - added patch #8 for fixing a regression with MUSB PHY power handling
> >   (not quite sure if this is the correct way to fix this or not)
> >
> > Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
> > suspend.
> >
> > Branch also available here:
> > git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > branch: mainline-3.7-rc1-omap4-ret-v9
> 
> I tested this branch on 4430/Panda and 4460/Panda-ES and I'm seeing
> several domains not hitting target power state in suspend[1].
> 
> Am I missing some other fixes?  Using omap2plus_defconfig, I tried your
> branch alone, and merged with v3.7-rc4, and I get the same errors.
> 
> Kevin
> 
> [1]
> # echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> # echo mem > /sys/power/state 
> [  102.271087] PM: Syncing filesystems ... done.
> [  102.282196] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [  102.312133] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [  102.343353] Suspending console(s) (use no_console_suspend to debug)
> ?[  102.363433] PM: suspend of devices complete after 10.650 msecs
> [  102.365631] PM: late suspend of devices complete after 2.166 msecs
> [  102.369201] PM: noirq suspend of devices complete after 3.509 msecs
> [  102.369232] Disabling non-boot CPUs ...
> [  102.373016] CPU1: shutdown
> [  104.357421] Powerdomain (core_pwrdm) didn't enter target state 1
> [  104.357452] Powerdomain (tesla_pwrdm) didn't enter target state 1
> [  104.357452] Powerdomain (ivahd_pwrdm) didn't enter target state 1
> [  104.357482] Powerdomain (l3init_pwrdm) didn't enter target state 1
> [  104.357482] Could not enter target state in pm_suspend
> [  104.357666] Enabling non-boot CPUs ...
> [  104.359863] CPU1: Booted secondary processor
> [  104.360626] cpu cpu0: opp_init_cpufreq_table: Device OPP not found (-19)
> [  104.360656] cpu cpu0: omap_cpu_init: cpu1: failed creating freq table[-19]
> [  104.360656] CPU1 is up
> [  104.362579] PM: noirq resume of devices complete after 1.892 msecs
> [  104.364807] PM: early resume of devices complete after 1.373 msecs
> [  104.710937] PM: resume of devices complete after 346.099 msecs
> [  104.817901] Restarting tasks ... done.

This looks like a combination of boot loader/kernel problems. My guess
is that l3init is probably held on by the USB, and both ivahd / tesla
are held on by some DSP/IVA modules which are not idling properly.

The last patch in this set should fix the USB problems at least
partially, but also the USB DPLL itself might be in wrong state,
attached patch might help for that one and get l3init to idle.

For DSP I don't have a patch right now, what is the boot loader you are
using? (Can you provide git / commit / config info?)

-Tero

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-ARM-OMAP4-clock-setup-USB-DPLL-during-init.patch
Type: text/x-patch
Size: 1199 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121106/aa09bad8/attachment.bin>
