From: johan@kernel.org (Johan Hovold)
Date: Fri, 31 Jul 2015 12:45:50 +0200
Subject: [PATCH 9/9] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <20150731104101.GB1994@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-10-git-send-email-mpa@pengutronix.de>
 <20150728095842.GO28535@localhost>
 <20150729070842.GG30895@pengutronix.de>
 <20150731085407.GO28535@localhost>
 <20150731104101.GB1994@pengutronix.de>
Message-ID: <20150731104550.GU28535@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 12:41:01PM +0200, Markus Pargmann wrote:
> On Fri, Jul 31, 2015 at 10:54:07AM +0200, Johan Hovold wrote:
> > On Wed, Jul 29, 2015 at 09:08:42AM +0200, Markus Pargmann wrote:
> > > On Tue, Jul 28, 2015 at 11:58:42AM +0200, Johan Hovold wrote:
> > > > On Fri, Jul 17, 2015 at 11:32:50AM +0200, Markus Pargmann wrote:
> > > > > Add some information about gpio names to the debugfs gpio file. name and
> > > > > label of a GPIO are then displayed next to each other. This way it is
> > > > > easy to see what the real name of GPIO is and what the driver requested
> > > > > it for.
> > > > > 
> > > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > > ---
> > > > >  drivers/gpio/gpiolib.c | 11 ++++++++---
> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > > index dcac3bcf21dd..0f1d1f5faf5d 100644
> > > > > --- a/drivers/gpio/gpiolib.c
> > > > > +++ b/drivers/gpio/gpiolib.c
> > > > > @@ -2308,14 +2308,19 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
> > > > >  	int			is_irq;
> > > > >  
> > > > >  	for (i = 0; i < chip->ngpio; i++, gpio++, gdesc++) {
> > > > > -		if (!test_bit(FLAG_REQUESTED, &gdesc->flags))
> > > > > +		if (!test_bit(FLAG_REQUESTED, &gdesc->flags)) {
> > > > > +			if (gdesc->name) {
> > > > > +				seq_printf(s, " gpio-%-3d (%-20.20s)\n",
> > > > > +					   gpio, gdesc->name);
> > > > > +			}
> > > > 
> > > > So now we'd no longer just be listing requested gpios, but on a similar
> > > > format to how requested ones used to be represented.
> > > 
> > > Better suggestions on how to display those extra information in debugfs?
> > 
> > Perhaps a new file only listing the line names.
> 
> Yes that's a possibility. On the other side having it all in one place
> is nice. As it helps you to debug faster, you can directly see which
> line name was requested for what purpose and so on.

Certainly, but you'd change the meaning of debug/gpio which used to
contain only requested gpios.

Not saying we shouldn't, but yeah, let's were this discussion goes
first.

> > > > Then there's the debugfs as ABI discussion...
> > > 
> > > I didn't consider debugfs as ABI as I thought it is just for debugging
> > > purposes?
> > 
> > Some people seem to have expressed a different position:
> > 
> > 	"The fact that something is documented (whether correctly or
> >         not) has absolutely _zero_ impact on anything at all. What makes
> >         something an ABI is that it's useful and available. The only way
> >         something isn't an ABI is by _explicitly_ making sure that it's
> >         not available even by mistake in a stable form for binary use.
> > 
> >         Example: kernel internal data structures and function calls. We
> >         make sure that you simply _cannot_ make a binary that works
> >         across kernel versions. That is the only way for an ABI to not
> >         form."
> > 
> >         https://lwn.net/Articles/309298/
> > 
> 
> Oh, I see. But I think that debugfs should help us to debug issues.
> If we start to care about breaking userspace tools it is not as helpful
> anymore. If I develop some tool against information that are
> clearly marked for debugging, I would somehow expect that my tool breaks
> at some point. But thats just my opinion.

I tend to agree, and wish debugfs was never to be considered ABI, but
it's Torvald's words above...

Johan
