From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Feb 2016 13:44:34 -0500 (EST)
Subject: [PATCH 8/9] ARM: do not use optimized do_div for ARMv3
In-Reply-To: <13253932.bg5yHHtIOq@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-9-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181215310.13632@knanqh.ubzr>
 <13253932.bg5yHHtIOq@wuerfel>
Message-ID: <alpine.LFD.2.20.1602191307380.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2016, Arnd Bergmann wrote:

> On Thursday 18 February 2016 12:20:51 Nicolas Pitre wrote:
> > On Thu, 18 Feb 2016, Arnd Bergmann wrote:
> > 
> > > The gcc-4.9 optimization goes wrong while building target_core_iblock.c
> > > for ARMv3 and leaves a bogus reference to __aeabi_uldivmod in the
> > > output:
> > > 
> > > ERROR: "__aeabi_uldivmod" [drivers/target/target_core_iblock.ko] undefined!
> > > 
> > > I could not find anyone who is interested in fixing it in gcc,
> > > so as a workaround this disables the do_div magic, just like
> > > we do for old compilers and for OABI.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I suppose this is good enough for the purpose of keeping RiscPC 
> > buildable. Whether or not it is still used is another question.  If it 
> > is then its user probably expects it to be slow already.
> > 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Thanks.
> 
> > Still unfortunate having to use a big hammer such as -march=armv3 just 
> > to avoid halfword memory accesses.
> 
> I brought this up with the gcc developers before. They would really want
> to deprecated ARMv3 support, but nobody seems interested in implementing
> halfword memory access as a replacement.

Actually, the only thing needed as far as Linux on RiscPC is concerned 
is a compiler switch that prevents the use of STRH, LDRH and LDRSH 
instructions when -march=armv4 is used.

> FWIW, I am currently still allowing ARMv3 in randconfig builds, but
> have run into 12 internal compiler errors with that, on gcc-4.9 or higher.
> It's probably all the same bug, but I don't see this getting fixed
> unless the RiscOS people update to a newer toolchain and run into the
> same problem.

Hmmm I suppose the ability to use halfword accesses is assumed by new 
optimization patterns and that's why gcc fails when they're not 
available.

> The patch below disables optimization so I am able to build this, but
> I see no way to fix this upstream.

That begs the question again: is anyone using mainline Linux on RiscPC?
If I remember correctly, the ability to boot Linux on an i386 was 
removed a while ago and nobody complained.


Nicolas
