From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 23 Mar 2010 18:49:18 +0200
Subject: [PATCH 2/3] ep93xx: add /proc/cpuinfo extension
In-Reply-To: <0D753D10438DA54287A00B02708426976368E58039@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B02708426976368DDCD38@AUSP01VMBX24.collaborationhost.net>
	<20100323153554.GD2904@gw.healthdatacare.com>
	<0D753D10438DA54287A00B02708426976368E58039@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100323164918.GE2904@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 23, 2010 at 11:34:32AM -0500, H Hartley Sweeten wrote:
> On Tuesday, March 23, 2010 8:36 AM, Mika Westerberg wrote:
> > On Mon, Mar 22, 2010 at 01:39:00PM -0500, H Hartley Sweeten wrote:
> >> Add a callback to mach-ep93xx for the /proc/cpuinfo extension.
> >> 
> >> This cpuinfo extension dumps the processor unique ID and Maverick
> >> Key as well as the processor silicon revision and a number of
> >> boot configuration options.
> >> 
> >> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> >> 
> >> ---
> 
> [snip]
> 
> >> +	seq_printf(m, "Boot mode\t: %s %ssync %sternal %d-bit\n",
> >> +		(val & EP93XX_SYSCON_SYSCFG_SBOOT) ? "serial" : "normal",
> >> +		(val & EP93XX_SYSCON_SYSCFG_LASDO) ? "" : "a",
> >> +		(val & EP93XX_SYSCON_SYSCFG_LEECLK) ? "in" : "ex",
> >> +		ep93xx_boot_width());
> >           ^^^^^^^^^^^^^^^^^
> > 
> > I got following compile error:
> >
> >  CC      arch/arm/mach-ep93xx/core.o
> > arch/arm/mach-ep93xx/core.c: In function 'ep93xx_cpuinfo':
> > arch/arm/mach-ep93xx/core.c:707: error: implicit declaration of function 'ep93xx_boot_width'
> > make[1]: *** [arch/arm/mach-ep93xx/core.o] Error 1
> > make: *** [arch/arm/mach-ep93xx] Error 2
> >
> > Should this function be included in the patch set also? I applied these on top of
> > latest mainline kernel.
> 
> Grr.. Left that piece out, sorry about that.
> 
> I will post the updated patch in a bit.
> 
> If you want to test this now, just put the following after the 
> ep93xx_chip_revision() in core.c (and of course the proper prototype in
> platform.h).

Ok. Thanks.

With that function in place I get following on my TS-7260 board:

ts-7260:~# cat /proc/cpuinfo 
Processor       : ARM920T rev 0 (v4l)
BogoMIPS        : 49.76
Features        : swp half thumb crunch 
CPU implementer : 0x41
CPU architecture: 4T
CPU variant     : 0x1
CPU part        : 0x920
CPU revision    : 0

Hardware        : Technologic Systems TS-72xx SBC
Revision        : 0000
Serial          : 0000000000000000

Unique ID       : 920fef0b
Maverick Key    : 920fef0b58d363f79f0fa62c06a512 OK
Silicon Rev     : E2
Watchdog        : disabled
Reset duration  : disabled
Boot mode       : normal sync internal 16-bit

(Note that my bootloader doesn't pass the revision information).

Tested-by: Mika Westerberg <mika.westerberg@iki.fi>

Regards,
MW
