From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Sat, 21 Mar 2015 15:39:30 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150320222320.GL8656@n2100.arm.linux.org.uk>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320222320.GL8656@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> At first glance, HIGHMEM shouldn't be affected by XIP_KERNEL at all.

I really didn't find the root cause of this. I just remember looking at the crashed log and it seemed like removing HIGHMEM would fix it....and it did (can't remember the details).

> However, SMP_ON_UP is incompatible with XIP_KERNEL (as already listed in its dependencies) and building with SMP=y without SMP_ON_UP, and trying to run on UP hardware will definitely fail.

So, it sounds like you are saying XIP_KERNEL and SMP is not going to happen.

However, you said:
> To put that another way:
> 1. SMP_ON_UP relies on being able to change the kernel text, which it
>    can't do with an XIP kernel.

But, what kernel text are we talking about? All of it, or just certain parts?
What if I changed the linker to put all those files in a specific area and then remap that one area to RAM (of course and copy the binary too). Yes, sounds pretty hack-ish, but if XIP can't go past single core, it might not have a long term future anyway.


> I'm not sure what you mean by this.  We have:
>
> config PHYS_OFFSET
>         hex "Physical address of main memory" if MMU
>         depends on !ARM_PATCH_PHYS_VIRT
>
> which is quite correct - PHYS_OFFSET depends on not having the phys offset patching code enabled.  However, for
> an XIP kernel, you don't want to have the phys offset patching code enabled, so you want ARM_PATCH_PHYS_VIRT to be off.

You are correct...maybe my wording was confusing. This is what I meant:

config ARCH_MULTIPLATFORM
	bool "Allow multiple platforms to be selected"
	depends on MMU
	select ARCH_WANT_OPTIONAL_GPIOLIB
	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
	select AUTO_ZRELADDR


Chris
