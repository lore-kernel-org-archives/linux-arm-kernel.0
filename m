From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 6 Jun 2014 18:17:27 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140606214921.GA10969@quad.lixom.net>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <20140606203721.GA10422@quad.lixom.net>
 <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
 <20140606210126.GA10219@quad.lixom.net>
 <alpine.LFD.2.11.1406061717520.25775@knanqh.ubzr>
 <20140606214921.GA10969@quad.lixom.net>
Message-ID: <alpine.LFD.2.11.1406061755200.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jun 2014, Olof Johansson wrote:

> On Fri, Jun 06, 2014 at 05:34:21PM -0400, Nicolas Pitre wrote:
> > On Fri, 6 Jun 2014, Olof Johansson wrote:
> > 
> > > On Sat, Jun 07, 2014 at 02:16:27AM +0530, Abhilash Kesavan wrote:
> > > > My answer is not "use mainline u-boot" primarily because I am not sure
> > > > mainline u-boot actually works on 5420 :).
> > > 
> > > And I'm saying that's not the answer primarily because we should never require
> > > people to update their firmware to get a usable linux system.
> > > 
> > > > My answer is keep a patch
> > > > locally (or make a trivial change to the bootcmd) for people who would
> > > > like to use an upstream kernel with the firmware on the device. Once
> > > > we do have a working mainline u-boot, that can then be used by the
> > > > interested parties.
> > > 
> > > And I am strongly NAK:ing both of those approaches. We should not require
> > > a single out-of-tree patch because that means we have failed to make a useful
> > > kernel for people. And it should never, ever, be a requirement for people to
> > > reflash and risk bricking their device just to run mainline linux on it.
> > 
> > What we can do, though, is to publicly shame you all Google People very 
> > strongly for not making firmware updates in the field safer and easier.  
> > After all you must all know already that, by definition, software always 
> > contains bugs.  The first feature to be tested with a new 
> > bootloader/firmware must be the ability to successfully and safely (and 
> > securely) update itself.  Especially for a mainstream device like a 
> > Chromebook.
> 
> The security model of Chrome OS is that it relies on a read-only firmware
> that is later verifying and launching a read-write firwmare.

It must do a whole lot more than that, otherwise we wouldn't be talking 
about ways to update it.

> Some changes are
> not possible to work around in the read-write part of the firmware,
> or for some other reason becomes unfeasible to handle there.

In other words, you are pleading guilty for bad design.

> We're working on making the RO portion smaller, so we'll be less exposed
> to this in the future, but that's a feature that will take some time
> to mature. It can also be hard to motivate updating the firmware in
> the field for upstream usage, since doing these updates are a large
> undertaking from a QA point of view.

Usually, when the mechanism is there, it gets happily used even before 
mainline usage is considered.

> We're working hard on making sure a vanilla upstream kernel will work
> well on this generation of ARM Chromebooks, something we never really
> did with the first generation. If the response we get is "just carry it
> out of tree", why would we even care about upstream at all? We're trying
> to do the right thing here, even if it might require a line of code or
> two here or there that isn't perfect.

Shit happens.  One line or two is tolerable.

What is not acceptable is the impossibility to fix fundamental 
correctness issues because people think their damn read-only firmware is 
bug free.  I've spent a great amount of time doing multiple rounds of 
reviews for MCPM backends.  Still it seems that people just don't get 
all the correctness subtleties before at least 5 rounds.  Yet they 
thought their code was OK on the initial rounds, otherwise why would 
they knowingly post buggy code?  If that code had been put into 
read-only firmware, say behind some PSCI interface for example, then 
your device would simply be stuck to board-bringup feature level.

I don't know enough about the actual issue with the Chromebook yet, but 
I do hope your firmware screwups aren't too serious.  The patch Doug 
just posted appears innocent enough.


Nicolas
