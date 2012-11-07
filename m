From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 7 Nov 2012 12:17:10 +0200
Subject: [PATCHv9 0/8] ARM: OMAP4: core retention support
In-Reply-To: <87wqxy77li.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <87d2zrg04t.fsf@deeprootsystems.com> <1352193483.8788.43.camel@sokoban>
 <87wqxy77li.fsf@deeprootsystems.com>
Message-ID: <1352283430.2406.7.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-06 at 13:19 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Hi Kevin,
> >
> > On Mon, 2012-11-05 at 14:23 -0800, Kevin Hilman wrote:
> >> Hi Tero,
> >> 
> >> Tero Kristo <t-kristo@ti.com> writes:
> >> 
> >> > Hi,
> >> >
> >> > Changes compared to previous version:
> >> > - rebased on top of 3.7-rc1
> >> > - applies on top of latest func pwrst code (v6)
> >> > - added back patch #1 to this set (it wasn't queued yet after all)
> >> > - added patch #7 for fixing a bug in the functional pwrst code
> >> > - added patch #8 for fixing a regression with MUSB PHY power handling
> >> >   (not quite sure if this is the correct way to fix this or not)
> >> >
> >> > Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
> >> > suspend.
> >> >
> >> > Branch also available here:
> >> > git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> >> > branch: mainline-3.7-rc1-omap4-ret-v9
> >> 
> >> I tested this branch on 4430/Panda and 4460/Panda-ES and I'm seeing
> >> several domains not hitting target power state in suspend[1].
> >> 
> >> Am I missing some other fixes?  Using omap2plus_defconfig, I tried your
> >> branch alone, and merged with v3.7-rc4, and I get the same errors.
> 
> [...]
> 
> > This looks like a combination of boot loader/kernel problems. My guess
> > is that l3init is probably held on by the USB, and both ivahd / tesla
> > are held on by some DSP/IVA modules which are not idling properly.
> >
> > The last patch in this set should fix the USB problems at least
> > partially, but also the USB DPLL itself might be in wrong state,
> > attached patch might help for that one and get l3init to idle.
> >
> > For DSP I don't have a patch right now, what is the boot loader you are
> > using? (Can you provide git / commit / config info?)
> 
> I was using mainline u-boot at tag v2012.04.01 when I saw the errors.  
> 
> To check the bootloader, I upgraded to the latest mainline tag
> (v2012.10) and the problems are gone on both 4430/Panda and
> 4460/Panda-ES...   Interesting.
> 
> That suggests that there's still some kernel assumptions/dependencies on
> the bootloader that need to be addressed.

I am not surprised of that, the all so common bootloader madness hits
again. Anyway, I can try with the bootloader tag you used hopefully next
week and see if I can figure out something. The l3init problem can
probably be fixed rather easily if it is because of the USB, but the
tesla / ivahd might be more problematic... last time I saw that problem
I wasn't able to recover from the situation without power on reset...
bootloader took the tesla out of reset and it seemed impossible to put
it back to idle after that. I tried resetting the DSP but it didn't
help. Also, I didn't find a bootmode register similar to what omap3 has.

-Tero
