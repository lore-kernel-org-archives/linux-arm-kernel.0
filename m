From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2015 22:40:19 +0000
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151027212020.GL4931@pengutronix.de>
References: <20151026012710.GA17365@laptop>
 <20151027202124.GK4931@pengutronix.de>
 <CAAEAJfBOcxwq=L2aq5=KYedN=gs=gM6rupUWS9bPceEDCZniSg@mail.gmail.com>
 <20151027212020.GL4931@pengutronix.de>
Message-ID: <20151027224019.GI8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 10:20:20PM +0100, Uwe Kleine-K?nig wrote:
> Hello Ezequiel,
> 
> On Tue, Oct 27, 2015 at 05:57:46PM -0300, Ezequiel Garcia wrote:
> > On 27 October 2015 at 17:21, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > Hello Ezequiel,
> > >
> > > On Sun, Oct 25, 2015 at 10:27:10PM -0300, Ezequiel Garcia wrote:
> > >> I've been trying to make my ARM v7-M LPC43xx board
> > >> boot a XIP kernel from flash. Currently, this seems
> > >> to be broken in mainline due to this:
> > >>
> > >> arch/arm/mm/proc-v7m.S
> > >> [..]
> > >>         @ SVC to run the kernel in this mode
> > >>         badr    r1, 1f
> > >>         ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
> > >>         str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
> > >>         mov     r6, lr                  @ save LR
> > >>         mov     r7, sp                  @ save SP
> > >>       ldr     sp, =__v7m_setup_stack_top @ <<< Breaks XIP!
> > >
> > > How does this fail for you?
> > >
> > 
> > My CPU just seems to stall.
> > I've added calls to the printch in arch/arm/kernel/debug.S
> > and can't get past the SVC call.
> Can you try to add something like:
> 
> 	stmdb	sp!, {r0-r4}

Wait one moment, and try reading the code.

The call path to this point is: entry text at stext in head-nommu.S
which goes on to call __v7m_setup.

Nothing in that path sets up a stack, so the value of 'sp' is
undefined - it's entirely whatever's left in the register after the
boot loader has passed control to the kernel.

So, it's pointless proc-v7m.S saving and restoring the stack pointer
around this.  It also means that there probably isn't a reliable
stack here.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
