From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 Dec 2012 13:11:51 +0000
Subject: [PATCH 1/2] gpiolib: add gpio_export_with_name
In-Reply-To: <20121218060415.GM23971@game.jcrosoft.org>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <1353492849-29397-1-git-send-email-plagnioj@jcrosoft.com>
 <20121126135911.2F1D33E187C@localhost>
 <20121128201907.GF4398@game.jcrosoft.org>
 <20121218060415.GM23971@game.jcrosoft.org>
Message-ID: <20121219131151.789043E0AD7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Dec 2012 07:04:15 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> On 21:19 Wed 28 Nov     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 13:59 Mon 26 Nov     , Grant Likely wrote:
> > > On Wed, 21 Nov 2012 11:14:08 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > > > allow to specify a name to an exported gpio
> > > > 
> > > > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > 
> > > The gpio sysfs ABI is already horrible, racy, and unsafe. Really, we
> > > need a proper chrdev interface for controlling gpios. Sysfs is fine for
> > > poking around and experimenting, but we cannot provide any fine grained
> > > access control, locking or faster IO with the one-file-per-gpio sysfs
> > > model.
> > I do agree on this and mention it on the ML multiple times but this an ABI
> > and we can not change it anymore we need to support it
> > > So, no, I don't think this is a good idea to extend gpiolib in
> > > this way.
> > > 
> > > However, I would be okay with making gpiochips first-class kobjects or
> > > struct devices that appear as a child of the gpio controller device so
> > > that userspace could interrogate the device tree node associated with
> > > the device.
> > the problem here is that I do not want the user space to become smart
> > 
> > I want the user space to known which gpio use for a specific feature
> > as example you just want to read lack restistor to detect a hw features
> > 
> > you known the encoding it does not change cross hw but the pin to read do
> > 
> > So the idea is just to tell the user space use this pin to get your
> > information
> > 
> > how to do you want to solve this?
> > 
> > This apply to other case:
> >  - chip poweron/off
> >  - reset
> >  etc... all control by userspace
> 
> ping

I've already stated in other thread that I want to see a significantly
better GPIO interface created. Something based on a char dev and can
handle 'bursts' of gpio manipulations/reads. I'm not going to accept
extensions to the sysfs interface.

Within that context I would consider named subsets of the same interface
that pre-packages a set of related gpio pins.

That said, I'm not convinced that direct gpio access is the abstraction
that you want. If it is an interface for, say, reading feature bits,
then it probably does want to be an actual driver that reads the
gpios/registers/adc/etc and returns the parsed status in a file. That's
the only way to reliably get the abstraction from your example above.

g.
