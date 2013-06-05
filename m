From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Wed, 05 Jun 2013 23:59:34 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
Message-ID: <1370469574.18839.33.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ons 2013-06-05 klockan 22:24 +0100 skrev Luke Kenneth Casson Leighton:

>  And Then Some, stephen.  there are two versions of u-boot being used:
> one is the community-assembled [GPL-compliant] one, and the other
> includes a [as-of-a-few-days-ago-but-no-longer, yay!]
> formerly-GPL-violating one from allwinner.
> 
>  the community-based one *doesn't* have fex integration (i don't
> think, but henrik will know for sure), but the allwinner one
> definitely does.

Correct.

>  .... and then there's the boot0 and boot1 loaders, these *do* have
> fex integration: they're absolutely tiny and they're designed to fit
> into the 1st level cache.  the job of these bootloaders is to set up
> the DDR3 RAM timings (so that you can access DRAM!!) and to then
> decide whether to load from NAND, SD/MMC etc. and many other things.

no, these are not tiny. boot0 is 24KB to fit the initial embedded SRAM
(not cache), but boot1 is on pair with u-boot in size and runs from
DRAM.
 
boot0 do NOT read the script.bin at all. It can't, there isn't space
fore it. There is tools in the build process that reads the script.bin
and adds some information to a header of boot0, but it's irrelevant to
the device tree question. Exactly the same can be done from a device
tree, or from a fex, it does not matter.

even most of boot1 is not using script.bin. The important parameters are
all recorded in a heaeder of boot1 when the image is composed using the
Allwinner pack tools. Currently based on those tools reading script.bin
to prepare the boot1 part of the image.

>  these boot0 and boot1 loaders are themselves configureable so that
> you can specify, through script.fex, what GPIO is to be the "reset
> key" and so on.  that's a much simplified story btw.

No. That info is in the boot0 and boot1 file headers, not script.bin. 

>  so the point is: if anyone wishes me to propose to allwinner that
> they convert over to devicetree, or any other proposal which involves
> significant low-level changes to their working practices that could
> potentially have a massive knock-on effect onto their
> multi-million-dollar clients, it had better be a damn good story.

Calm down. It isn't really a significant difference to them outside of
the kernel. They do not need to change any of their configuraiton
methods, only a small toolchain change in how the resultig images are
built to have a corresponding device tree built.

But it is a fair bit of one-time changes kernel side. And some
scratching to figure out how to use/improve/ignore the stuff being
mainlined.

Regards
Henrik
