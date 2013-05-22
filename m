From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 16:16:22 +0200
Subject: [PATCH 9/9] arm: mvebu: switch internal register address at
 runtime if needed
In-Reply-To: <20130522140444.GK2824@lunn.ch>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522152700.4dab10a1@skate> <20130522140444.GK2824@lunn.ch>
Message-ID: <20130522161622.3a65e45d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 22 May 2013 16:04:44 +0200, Andrew Lunn wrote:

> You gave a good explanation why the CP15 bit its needed, etc. I liked
> the comment.

Thanks.

> It might be worth cross posting both u-boot and barebox lists, since
> they are somewhat involved as well. Are there any other boot loaders
> used on 370 and XP.

As far as Barebox is concerned, Sebastian Hesselbarth and myself have
recently started the Marvell SoC support, so we kind of know what to do.
The current status is that (thanks to the latest patches from
Sebastian), Barebox remaps registers to 0xf1 very early, on all
platforms (currently, we support Kirkwood, Armada 370/XP and Dove). The
CP15 bit is *not* set yet, simply because we don't have enough drivers
yet in Barebox to even load a kernel to then boot it. But once it
happens, I'll adjust the Armada 370/XP code to set this CP15 bit.

As far as mainline U-Boot is concerned, it has zero support for Armada
370/XP at the moment.

> What happens with future chips. 375 springs to mind. I assume its
> Marvell bootloader will do the mapping before handing over to
> Linux. Is it required to also set the bit in CP15? Are we setting off
> down a road where all future Marvell chips which are compatible with
> 370/XP now need to set this bit?

No, the bootloaders provided by Marvell for the future chips will not
have this CP15 bit set. It will only be set for Armada 370/XP platforms.

> How does this effect dove? It will get compiled into the same multi
> arch kernel as 370/XP. I'm thinking about
> arch/arm/include/debug/mvebu.S which might be shared. Dove is not
> going to have this bit set. Kirkwood could also share this code, now
> that the serial ports are all in the same location.

This code will have to be conditionally compiled. When we'll integrate
Dove support in mach-mvebu, we'll make the code conditional. So you'll
have a choice:

 * Either you want to run a multiplatform capable kernel with support
   for Dove, Armada 370 and Armada XP in the same kernel, and you'll
   have to run a recent enough bootloader.

 * Or you have an old bootloader and you don't want to upgrade it, in
   this case you'll have to build a kernel which will only work on
   Armada 370/XP.

My plan is also to make this code show a warning when it detects that
the user is running an old bootloader, in order to encourage users to
move to newer versions of the bootloader. I don't want to show this
message right now, because such new versions are not yet widely
available, but let's say in 1 or 2 release cycles (3.12 or 3.13), we
can add such a message.

Currently, the only two platforms that are widely available with Armada
370 or Armada XP are the Globalscale Mirabox and the Plathome
Openblocks AX3. Once Globalscale and Plathome have released new
versions of their bootloader, we can document how users can upgrade. So
that hopefully, in the future, we may even decide to get rid of this
'hack' entirely.

> What does the ARM reference documentation say about this bit? Is its
> meaning defined? Is there any danger when this bit is used for its
> intended purpose?

I haven't checked myself the ARM reference documentation for this CP15
bit, but I know it has been chosen with care by Marvell engineers. It
is used when the CPU goes idle with the 'wfi' instruction, so the
entire hack makes the assumption that the CPU doesn't go idle between
the moment the bootloader sets the CP15 bit and the moment the kernel
checks it to understand where the internal registers are. If you want,
I can do some more research to give a (hopefully) more compelling
explanation for the choice of this particular bit.

Thanks again for your review and all your questions!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
