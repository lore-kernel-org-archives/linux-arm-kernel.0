From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Apr 2010 19:57:46 +0100
Subject: Query on direction_output fn of PL061 GPIO driver.
In-Reply-To: <20100413115321.GB2212@tarshish>
References: <4BC44C7E.20306@st.com> <20100413113237.GA2212@tarshish>
	<4BC45839.1080902@st.com> <20100413115321.GB2212@tarshish>
Message-ID: <20100413185746.GA6289@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 02:53:21PM +0300, Baruch Siach wrote:
> Hi Viresh,
> 
> On Tue, Apr 13, 2010 at 05:10:41PM +0530, Viresh KUMAR wrote:
> > On 4/13/2010 5:02 PM, Baruch Siach wrote:
> > >> > In current implementation, firstly value of GPIO pin is modified and then its
> > >> > direction is set to OUT. In our SOCs (ST SPEAr), this implementation doesn't
> > >> > work correctly (we have pl061 in our soc). Suppose previously pin is in IN mode,
> > >> > now writing val to it doesn't change anything because it is in IN mode and we
> > >> > can write to a pin only when it is in OUT mode. Now if its direction is
> > >> > changed to OUT then also its value will remain same and will not be changed to
> > >> > what we wanted.
> > >> > 
> > >> > Am i missing something?
> > > Probably not. This is a design bug in the PL061 hardware. Changing the 
> > > direction before the value makes the output value of the GPIO undefined 
> > > (apparently 0) for a short period of time. This is bad news for some 
> > > applications.
> > > 
> > 
> > thanks for your prompt reply.
> > Ok. so this may cause problem on the board. 
> > Anyway if this is the issue, then writing value to val register has no effects.
> > 
> > > Anyway, the right thing to do here is to reverse do just that, since the 
> > > current way of doing things is broken.
> > 
> > I didn't get it completely. If i got it correctly, maybe myself or you can just
> > send a patch to reverse this, i.e. writing val and setting direction.
> > Am i correct?
> 
> Correct. Please send a patch, and I'll ack it after review. Make sure to test 
> the patch before sending. I don't have access to this hardware anymore.  
> Estimating the length of the jitter on your platform (when switching direction 
> and value) would be even better. Please explain the issue and the jitter 
> problem in your commit log.

I've had this patch floating around for some time to resolve this issue;
though I wasn't sure if it was just a bug in the Realview board I had.

GPIO: Fix PL061 GPIO direction_output to set output level

PL061 hardware does not allow setting the output level prior to
changing the direction to output; we have to set the level after
changing the direction.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
index aa8e7cb..cac9c0c 100644
--- a/drivers/gpio/pl061.c
+++ b/drivers/gpio/pl061.c
@@ -90,6 +90,7 @@ static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
 	gpiodir = readb(chip->base + GPIODIR);
 	gpiodir |= 1 << offset;
 	writeb(gpiodir, chip->base + GPIODIR);
+	writeb(!!value << offset, chip->base + (1 << (offset + 2)));
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
