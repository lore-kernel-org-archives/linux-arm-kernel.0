From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Oct 2015 08:34:58 +0100
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151027224019.GI8644@n2100.arm.linux.org.uk>
References: <20151026012710.GA17365@laptop>
 <20151027202124.GK4931@pengutronix.de>
 <CAAEAJfBOcxwq=L2aq5=KYedN=gs=gM6rupUWS9bPceEDCZniSg@mail.gmail.com>
 <20151027212020.GL4931@pengutronix.de>
 <20151027224019.GI8644@n2100.arm.linux.org.uk>
Message-ID: <20151028073458.GM4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Oct 27, 2015 at 10:40:19PM +0000, Russell King - ARM Linux wrote:
> On Tue, Oct 27, 2015 at 10:20:20PM +0100, Uwe Kleine-K?nig wrote:
> > Hello Ezequiel,
> > 
> > On Tue, Oct 27, 2015 at 05:57:46PM -0300, Ezequiel Garcia wrote:
> > > On 27 October 2015 at 17:21, Uwe Kleine-K?nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > Hello Ezequiel,
> > > >
> > > > On Sun, Oct 25, 2015 at 10:27:10PM -0300, Ezequiel Garcia wrote:
> > > >> I've been trying to make my ARM v7-M LPC43xx board
> > > >> boot a XIP kernel from flash. Currently, this seems
> > > >> to be broken in mainline due to this:
> > > >>
> > > >> arch/arm/mm/proc-v7m.S
> > > >> [..]
> > > >>         @ SVC to run the kernel in this mode
> > > >>         badr    r1, 1f
> > > >>         ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
> > > >>         str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
> > > >>         mov     r6, lr                  @ save LR
> > > >>         mov     r7, sp                  @ save SP
> > > >>       ldr     sp, =__v7m_setup_stack_top @ <<< Breaks XIP!
> > > >
> > > > How does this fail for you?
> > > >
> > > 
> > > My CPU just seems to stall.
> > > I've added calls to the printch in arch/arm/kernel/debug.S
> > > and can't get past the SVC call.
> > Can you try to add something like:
> > 
> > 	stmdb	sp!, {r0-r4}
> 
> Wait one moment, and try reading the code.
> 
> The call path to this point is: entry text at stext in head-nommu.S
> which goes on to call __v7m_setup.
> 
> Nothing in that path sets up a stack, so the value of 'sp' is
> undefined - it's entirely whatever's left in the register after the
> boot loader has passed control to the kernel.

Yeah, that's what I found, too. With this test I want to find out if
it's really the write to ROM memory that makes the machine hang.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
