From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 13 Feb 2015 11:22:05 +0000
Subject: [PATCH 01/11] ARM: vexpress: use ARM_CPU_SUSPEND if needed
In-Reply-To: <20150213111612.GV8656@n2100.arm.linux.org.uk>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-2-git-send-email-arnd@arndb.de>
 <20150213103716.GQ14954@e106497-lin.cambridge.arm.com>
 <20150213105752.GU8656@n2100.arm.linux.org.uk>
 <20150213110152.GR14954@e106497-lin.cambridge.arm.com>
 <20150213111612.GV8656@n2100.arm.linux.org.uk>
Message-ID: <20150213112205.GT14954@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 11:16:12AM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 13, 2015 at 11:01:52AM +0000, Liviu Dudau wrote:
> > On Fri, Feb 13, 2015 at 10:57:53AM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Feb 13, 2015 at 10:37:16AM +0000, Liviu Dudau wrote:
> > > > On Thu, Feb 12, 2015 at 07:42:33PM +0000, Arnd Bergmann wrote:
> > > > > The vexpress tc2 power management code calls mcpm_loopback, which
> > > > > is only available if ARM_CPU_SUSPEND is enabled, otherwise we
> > > > > get a link error:
> > > > > 
> > > > > arch/arm/mach-vexpress/built-in.o: In function `tc2_pm_init':
> > > > > arch/arm/mach-vexpress/tc2_pm.c:389: undefined reference to `mcpm_loopback'
> > > > 
> > > > Arnd,
> > > > 
> > > > We are having reports of TC2 not booting with MCPM enabled. Lorenzo
> > > > was investigating this but then headed for Linaro Connect this week,
> > > > so we don't have yet a resolution. Can this patch be postponed for
> > > > a later -rc?
> > > 
> > > Why?
> > > 
> > > This patch isn't forcing MCPM to be enabled for Versatile Express.
> > > 
> > > * In order to build tc2_pm.c, MCPM must already be enabled (the
> > >   feature depends on MCPM in the Kconfig already)
> > > * When this feature is enabled, the above link error occurs if
> > >   ARM_CPU_SUSPEND is not also enabled.
> > > 
> > > So, it is merely fixing the requirement that tc2_pm.c needs the CPU
> > > suspend infrastructure, which in turn has no effect on whether MCPM
> > > is enabled or not.
> > 
> > Because I think Lorenzo's plan was to disable MCPM for TC2. Which would
> > make this patch moot.
> 
> I don't think that makes a difference - the two issues are orthogonal.
> 
> As the code stands today, it requires ARM_CPU_SUSPEND to be set, so
> merging this change makes total sense.
> 
> If the code is temporarily disabled, then we still need this patch
> merged to fix the error when the feature is re-enabled.  If the code
> is changed later such that it doesn't need mcpm_loopback, then that's
> the time to remove the select of this symbol.
> 
> If the code is removed, that is something which is not going to happen
> during this merge window, so the patch still might as well be applied
> to prevent build errors.

Russell,

I'm not arguing either way, I was just asking for a delay until Lorenzo
(one other maintainer of the code that is in the Cc) has a chance to
have his say, because I thought it was relevant (and I have explained why).

If Arnd feels he would rather push the patch now rather than (let say) late
Monday, then I can give my Acked-by.

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
