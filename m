From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 25 Oct 2012 16:29:02 -0500
Subject: [PATCH v4 5/5] zynq: move static peripheral mappings
In-Reply-To: <20121025201701.GA18217@elliptictech.com>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200451.GF6713@beefymiracle.amer.corp.natinst.com>
 <20121025201701.GA18217@elliptictech.com>
Message-ID: <20121025212902.GX20593@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 04:17:01PM -0400, Nick Bowler wrote:
> Hi Josh,
>
> On 2012-10-24 15:04 -0500, Josh Cartwright wrote:
> > Shifting them up into the vmalloc region prevents the following warning,
> > when booting a zynq qemu target with more than 512mb of RAM:
> [...]
> > -/* For now, all mappings are flat (physical = virtual)
> > +/* Static peripheral mappings are mapped at the top of the
> > + * vmalloc region
> >   */
> > -#define UART0_PHYS			0xE0000000
> > -#define UART0_VIRT			UART0_PHYS
> > +#define UART0_PHYS		0xE0000000
> > +#define UART0_SIZE		SZ_4K
> > +#define UART0_VIRT		(VMALLOC_END - UART0_SIZE)
>
> Did you test this on any real hardware?  I can't get the ZC702 to work
> with the UART mapped at this address (this ends up being mapped at
> 0xFEFFF000), although I can't for the life of me figure out why the
> virtual address even matters.  Note that for the ZC702, the physical
> address of the "main" UART is 0xE0001000.

Ugh, not yet;  My testing has been on a qemu model.  I also
unfortunately neglected to mention I am carrying a qemu patch that
forces RX_EN/TX_EN of the uarts out of reset.  There is an (incomplete)
thread on qemu-devel discussing whose responsibility it really is to
enable the uarts:

   http://lists.gnu.org/archive/html/qemu-devel/2012-10/msg03779.html

Clearly, though, if you are seeing the "Uncompressing Linux..."
messages, then the uart is enabled, so I don't think that's the problem.

> All I end up seeing is "Uncompressing Linux... done, booting the
> kernel." with no further messages.  With the UART mapped at
> 0xF0001000, all printouts make it to the console.  I tried a couple
> different virtual addresses and I'm surprised at the results, since
> the behaviour seems to vary wildly.  I saw three behaviours depending
> only on the virtual address of the static mapping; all results are 100%
> reproducible:
>
>    "Works":     all printouts make it to the console
>    "Fails":     no printouts make it to the console after decompression
>    "Truncated": the first few lines of output do not make it to the
>                 console, but after that it "Works".  The first line
> 		successfully printed is always
> 		  "Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096"

Odd, I'm wondering the uart gets into a weird state, and some bits get
knocked loose at console_initcall() time, when the console driver comes
up (Assuming CONFIG_SERIAL_XILINX_PS_UART)?

> And here are the addresses I tested:
> 
>   Address       Result
>   -----------------------
>   0xf0000000    Truncated
>   0xf0001000    Works
>   0xf0007000    Truncated
>   0xf0008000    Fails
>   0xf0009000    Fails
>   0xf000e000    Truncated
>   0xf000f000    Fails
>   0xf8000000    Truncated
>   0xf8001000    Works
>   0xfef00000    Truncated
>   0xfef01000    Works
>   0xfef08000    Fails
>   0xfef0f000    Fails
>   0xfeff0000    Fails
>   0xfeff1000    Fails
>   0xfeffe000    Fails
>   0xfefff000    Fails
> 
> Judging by the list, the console seems to only work properly if the
> defined virtual address is Fxxx1000 and xxx is not too big...

Very odd.  Do you mind sending out your patch allowing the selection of
the secondary uart for DEBUG_LL?

Thanks,

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/55b5ccf3/attachment.sig>
