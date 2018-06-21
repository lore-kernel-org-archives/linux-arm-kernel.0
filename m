From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 21 Jun 2018 16:45:38 +0000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
Message-ID: <TY1PR01MB1562B232625397CCACD5931A8A760@TY1PR01MB1562.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 21, 2018 1, Nicolas Pitre wrote:
> > I've just sent a patch to do that.
> 
> Your patch isn't wrong per se.  But it is not enough. The issue here
> would be easily fixed with some kconfig extension so that:
> 
> - If XIP or NOMMU is selected then only one target in the multiplatform
>   set can be selected, basically turning it into a choice menu.
> 
> - If more than one multiplatform targets is selected then XIP and NOMMU
>   can no longere be selected.
>

Over the years I tried to tackle this issue in multiple different ways, 
while still staying in the limitations of kbuild.
Basically, everything was shot down for one reason or another (or the 
only way to do it is really ugly...so I didn't even ask).

kbuild doesn't really have a mutually exclusive property that can be 
dynamically set/cleared.


In the end, I saw only 2 paths for adding XIP to ARM MMU builds:

1) Modify kbuild to give the ability as stated above.

2) Make XIP builds somehow be able to run at multiple physical address 
by modifying the binaries post-build (Arnd's suggestion).


What I have been doing is simply applying this patch to arch/arm/Kconifg
before every XIP KERNEL build:

 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM



Chris
