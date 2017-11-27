From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 27 Nov 2017 17:55:04 +0100
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <CAFEAcA_Bq1AtsGtv0gZLpcWwUrZ8b=OGGKmvz=EujJUkK9osOQ@mail.gmail.com>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
 <CACPK8XdvUtvKiX_uqTnnb8U-jKuhy4Kw+cda=OKvzabfaffjgQ@mail.gmail.com>
 <20171127094436.GB31757@n2100.armlinux.org.uk>
 <ff0993df-8c3f-e985-8b1c-641a8de7dc21@kaod.org>
 <20171127104717.GD31757@n2100.armlinux.org.uk>
 <CAFEAcA_Bq1AtsGtv0gZLpcWwUrZ8b=OGGKmvz=EujJUkK9osOQ@mail.gmail.com>
Message-ID: <08ef70f9-c70a-ca2c-1084-3920de9fe98e@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2017 12:50 PM, Peter Maydell wrote:
> On 27 November 2017 at 11:47, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Mon, Nov 27, 2017 at 11:16:06AM +0100, C?dric Le Goater wrote:
>>> Additional QEMU logging gives us :
>>>
>>>   Ignoring attempt to switch CPSR_A flag from non-secure world with SCR.AW bit clear
>>>   Ignoring attempt to switch CPSR_F flag from non-secure world with SCR.FW bit clear
> 
>> From what it sounds like, when you run the kernel without uboot, QEMU
>> decides to run the kernel in the nonsecure world.  If it did the same
>> with u-boot, u-boot would not be able to change the SCR register, so
>> u-boot must run in the secure world if it's setting the AW and FW
>> bits.
> 
> Yes, this seems like a QEMU bug. (Added qemu-devel to cc: accordingly).
> We'll print this warning for a v7 CPU which has the Security Extensions
> but not the Virtualization Extensions (which is the case where the
> architecture mandates that NS not be able to change the CPSR.A and
> F bits), but we shouldn't (in theory) get into that situation
> because either:
>  * we started the emulation by running a secure bootrom, which
>    should have initialized SCR.AW/FW correctly before booting the
>    NS kernel (I assume this is the "run from u-boot" setup)
>  * we started the kernel directly from QEMU, in which case QEMU's
>    internal "act like a bootloader" code should have done the
>    setting of SCR.AW/FW.
> 
> Cedric's command line is the second of these types, so something's
> gone wrong in our internal bootloader. The code in
> hw/arm/boot.c:arm_write_secure_board_setup_dummy_smc() sets up
> a little bit of guest code that runs in secure mode and sets
> SCR.AW/FW. I suspect the romulus-bmc machine model isn't invoking
> that code.

Indeed, it is missing. 

With a quick hack adding the extra secure boot loader, I could 
boot the QEMU romulus-bmc machine (armv6 CPU) with 4.15-rc1 kernel.
All is fine.  
  
But the code of the Aspeed machines also covers the ast2400 SoC 
which uses an armv5 CPU. So it needs some rework. That will be for
QEMU 2.12 I suppose.

Thank,

C.


> Most QEMU users shouldn't be affected by this because not
> many board models default to enabling the security extensions
> in the emulated CPU, and the highbank and raspi boards at least
> do do this secure-mode setup I think.
> 
> thanks
> -- PMM
> 
