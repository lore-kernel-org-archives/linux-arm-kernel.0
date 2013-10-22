From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Oct 2013 15:29:50 +0200
Subject: Armada XP Internal registers
In-Reply-To: <20131021184219.GA24520@titan.lakedaemon.net>
References: <CAFJTrDtznkpwi76yyEKYvjuo+XV34ky9AOe8Qfa5wm-uHDJT6A@mail.gmail.com>
 <20131021174339.GA27284@localhost>
 <20131021184219.GA24520@titan.lakedaemon.net>
Message-ID: <20131022152950.40171b36@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Matthew,

On Mon, 21 Oct 2013 14:42:19 -0400, Jason Cooper wrote:

> > Hm.. so if you upgraded the bootloader and the internal register address
> > is now 0xf100000 then it makes sense to fix your DT accordingly.
> 
> Agreed.
> 
> > Are you enabling CONFIG_DEBUG_LL? In that case, please note there's a
> > new option that will let you move to the 'new' internal regs address.
> 
> The option is CONFIG_DEBUG_MVEBU_UART.  Since you swapped out the
> bootloader, you need to tell it so.  (Early printk assumes the
> bootloader setup the uart and just writes to it blindly.  If it's at a
> different address than expected, it'll crash.)

I do confirm what Ezequiel and Jason said. The earlier U-Boot versions
from Marvell remapped the registers at 0xd0000000, while the more
recent versions remap the registers at 0xf1000000.

In recent kernel versions (I guess since 3.10 or 3.11), we've made sure
that changing the DT Mbus informations was enough to switch the entire
kernel to use the correct internal register base address. With the
exception of DEBUG_LL, which can't really on the DT, so that's why we
have two separate Kconfig options, one for 0xd0000000 and another one
for 0xf1000000.

That being said, I don't think the issue Matthew is seeing is related
to improper DEBUG_LL configuration. He wouldn't be getting "Unhandled
fault: external abort on non-linefetch (0x808) at 0xf0144010". He would
simply be getting *nothing* if the DEBUG_LL configuration was wrong.

Matthew, can you tell me which U-Boot version exactly you're using, and
give me the diff of the changes you've made to your Device Tree, so I
can see if I can reproduce the problem? For what it's worth, register
0x44010 is part of the PCIe registers, but I don't see right now what
could be the reason for the problem you're seeing.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
