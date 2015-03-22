From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Mar 2015 16:57:11 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320222320.GL8656@n2100.arm.linux.org.uk>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150322165710.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 21, 2015 at 03:39:30PM +0000, Chris Brandt wrote:
> > At first glance, HIGHMEM shouldn't be affected by XIP_KERNEL at all.
> 
> I really didn't find the root cause of this. I just remember looking at the crashed log and it seemed like removing HIGHMEM would fix it....and it did (can't remember the details).
> 
> > However, SMP_ON_UP is incompatible with XIP_KERNEL (as already listed in its dependencies) and building with SMP=y without SMP_ON_UP, and trying to run on UP hardware will definitely fail.
> 
> So, it sounds like you are saying XIP_KERNEL and SMP is not going to happen.

XIP_KERNEL=y and SMP=y can happen if the CPU you're booting on has the SMP
extensions.  In other words, it's a single CPU which was implemented with
the SMP extensions enabled, or it's part of a SMP set.

So, allowing both XIP_KERNEL=y and SMP=y is quite correct: however, folk
need to understand that the SMP option _must_ match the hardware they're
booting on.

> However, you said:
> > To put that another way:
> > 1. SMP_ON_UP relies on being able to change the kernel text, which it
> >    can't do with an XIP kernel.
> 
> But, what kernel text are we talking about? All of it, or just certain
> parts?

I'm afraid quite a lot of it.  If you consider that the SMP alternatives
table is 0x5ee0 bytes long for my iMX6 kernel, and that each entry is
8 bytes, that's 3036 locations throughout the kernel text which need to
be fixed up for a SMP_ON_UP kernel.  They start at 0xc0012460, and
continue up to 0xc09ef31c.  That covers much of the kernel .text and
the .text.init sections.

In an XIP kernel, the .text locations will most likely be in read-only
memory, and so can't be fixed up.

> You are correct...maybe my wording was confusing. This is what I meant:
> 
> config ARCH_MULTIPLATFORM
> 	bool "Allow multiple platforms to be selected"
> 	depends on MMU
> 	select ARCH_WANT_OPTIONAL_GPIOLIB
> 	select ARM_HAS_SG_CHAIN
> -	select ARM_PATCH_PHYS_VIRT
> +	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL

Yes, that makes sense if we agree that we want to have multi-platform
XIP kernels.

The problem is going to be expressing what a set of valid configurations
are - soo many of them just won't boot.  For example, if any of the
multiplatforms select SMP, but you want a non-SMP XIP kernel, you have
to devine which platforms are forcibly selecting SMP and turn them off.
In some of the kernel configurators, that's almost impossible to find
out.

I guess the other problem is going to be that people will want to add a
set of reasonable defaults for CONFIG_PHYS_OFFSET based upon the
platform selected - and we know that we have problems with that kind of
thing when it comes to the DEBUG_LL stuff interacting with a multiplatform
kernel.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
