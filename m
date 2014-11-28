From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 22:24:31 +0100
Subject: [PATCH 2/2] ARM: imx: src: support vf610 system reset controller
In-Reply-To: <7cd7c820d32cb04fa1d59889d16666a9@agner.ch>
References: <1417193015-6033-1-git-send-email-stefan@agner.ch>
 <34359137.rt8QrS7shW@wuerfel> <7cd7c820d32cb04fa1d59889d16666a9@agner.ch>
Message-ID: <2716009.DOfHfaSPkY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 22:02:01 Stefan Agner wrote:
> On 2014-11-28 17:49, Arnd Bergmann wrote:
> > On Friday 28 November 2014 17:43:35 Stefan Agner wrote:
> >> Support Vybrid SoC's system reset controller (SRC). Currently we
> >> don't register a reset controller but only support the imx_cpu_jump
> >> and imx_cpu_arg functions.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > 
> > I think this should be a platform driver in drivers/power/reset.
> 
> Yeah, I thought that too, see my cover letter. The problem is, in that
> module are also some register which are of interest when implementing
> suspend/resume support (see cover letter too). However, we could also
> just make a dt entry for that reset register only, and create another dt
> entry for the other registers.

Don't make a node with just one register, in this case, a syscon device
would be best.

> > If the SRC is also capable of resetting individual blocks instead of just
> > the entire machine, it would be a reset driver in drivers/reset instead.
> 
> Beside the system reset, there is only a mask functionality for the
> watchdogs (there are two watchdogs, one for Cortex-A5 and one for the
> M4). This makes the SRC module in the Vybrid a bit different then what
> is available on other i.MX SoC's...

If you already have the watchdog registers in there and want to have
a watchdog driver too, the easiest way would be to register the reboot
handler from the watchdog driver.

	Arnd
