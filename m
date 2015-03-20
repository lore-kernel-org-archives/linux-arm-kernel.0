From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Mar 2015 22:23:20 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150320222320.GL8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 08:57:21PM +0000, Chris Brandt wrote:
> Eventually....I got it to boot.
> 
> I had to remove both CONFIG_HIGHMEM and CONFIG_SMP and then I could
> boot completely from ROM (which for me is external QSPI flash that
> is memory mapping into linear CPU space at address 0x18000000)

At first glance, HIGHMEM shouldn't be affected by XIP_KERNEL at all.

However, SMP_ON_UP is incompatible with XIP_KERNEL (as already listed
in its dependencies) and building with SMP=y without SMP_ON_UP, and
trying to run on UP hardware will definitely fail.

To put that another way:
1. SMP_ON_UP relies on being able to change the kernel text, which it
   can't do with an XIP kernel.
2. UP hardware requires either a SMP=n kernel _or_ SMP=SMP_ON_UP=y
   kernel.

> So, the total changes was:
> 
> 1. start with shmobile_defconfig
> 2. remove all architectures but RZ/A1 (ARCH_R7S72100)
> 3. remove !ARCH_MULTIPLATFORM from XIP_KERNEL's dependencies
> 4. modify  'select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL'  in PHYS_OFFSET
>    (because I need to be able to set PHYS_OFFSET)

I'm not sure what you mean by this.  We have:

config PHYS_OFFSET
        hex "Physical address of main memory" if MMU
        depends on !ARM_PATCH_PHYS_VIRT

which is quite correct - PHYS_OFFSET depends on not having the phys
offset patching code enabled.  However, for an XIP kernel, you don't
want to have the phys offset patching code enabled, so you want
ARM_PATCH_PHYS_VIRT to be off.

Maybe you mean the "select ARM_PATCH_PHYS_VIRT" under ARCH_MULTIPLATFORM?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
