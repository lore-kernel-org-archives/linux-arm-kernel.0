From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 Dec 2013 04:02:41 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <alpine.LFD.2.10.1312072111410.15948@knanqh.ubzr>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <CAL_Jsq+7j62ucsA96TbRrFSqHBR5SGUvWeqdsxtUvEtcbtdGyQ@mail.gmail.com>
 <alpine.LFD.2.10.1312072111410.15948@knanqh.ubzr>
Message-ID: <201312080402.42101.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 December 2013, Nicolas Pitre wrote:
> The right fix is probably to leave it as is and optimize your user space 
> for ARMv6k instead, meaning that this operation would then be 
> implemented inline rather than relying on the kernel helper.

That would not make the program run on ARMv6 though. The bug we're trying
to fix is for running a kernel with ARMv6k support built-in on an
OMAP2 with ARMv6. The kuser helper already supports cmpxchg for pure
v6 builds, but that code doesn't get built (and isn't SMP safe) with
CONFIG_CPU_V6K or CONFIG_CPU_V7 enabled.
 
> Otherwise if you really want to optimize the kernel helper at runtime 
> for ARMv6k when ARMv6 is also configured in, then you could do some 
> instruction patching in kuser_init() as we already do for getting the 
> TLS value.

This does sound like the cleanest solution.

	Arnd
