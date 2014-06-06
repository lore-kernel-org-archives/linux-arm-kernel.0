From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Jun 2014 14:49:21 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406061717520.25775@knanqh.ubzr>
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
Message-ID: <20140606214921.GA10969@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 05:34:21PM -0400, Nicolas Pitre wrote:
> On Fri, 6 Jun 2014, Olof Johansson wrote:
> 
> > On Sat, Jun 07, 2014 at 02:16:27AM +0530, Abhilash Kesavan wrote:
> > > My answer is not "use mainline u-boot" primarily because I am not sure
> > > mainline u-boot actually works on 5420 :).
> > 
> > And I'm saying that's not the answer primarily because we should never require
> > people to update their firmware to get a usable linux system.
> > 
> > > My answer is keep a patch
> > > locally (or make a trivial change to the bootcmd) for people who would
> > > like to use an upstream kernel with the firmware on the device. Once
> > > we do have a working mainline u-boot, that can then be used by the
> > > interested parties.
> > 
> > And I am strongly NAK:ing both of those approaches. We should not require
> > a single out-of-tree patch because that means we have failed to make a useful
> > kernel for people. And it should never, ever, be a requirement for people to
> > reflash and risk bricking their device just to run mainline linux on it.
> 
> What we can do, though, is to publicly shame you all Google People very 
> strongly for not making firmware updates in the field safer and easier.  
> After all you must all know already that, by definition, software always 
> contains bugs.  The first feature to be tested with a new 
> bootloader/firmware must be the ability to successfully and safely (and 
> securely) update itself.  Especially for a mainstream device like a 
> Chromebook.

The security model of Chrome OS is that it relies on a read-only firmware
that is later verifying and launching a read-write firwmare. Obviously
changes to the read-only firwmare is impossible in the field (and only
done at risk of bricking the device for hobbyists). Some changes are
not possible to work around in the read-write part of the firmware,
or for some other reason becomes unfeasible to handle there.

We're working on making the RO portion smaller, so we'll be less exposed
to this in the future, but that's a feature that will take some time
to mature. It can also be hard to motivate updating the firmware in
the field for upstream usage, since doing these updates are a large
undertaking from a QA point of view. When we can bundle them with other
high-priority changes (without adding significant risk), we try to do so.

Anyway, with that being said: The real reason we're in this situation
at this time is that the upstream review and discussion (including
patch posting) didn't happen until after RO firmware had been cut, and
some pieces were not acceptable (things that we had not realized
in our internal reviews when we were working on the product). If SoC
vendors upstream code earlier, we can be more certain that the upstream
implementation will work well with the firmware we have. That's the
_real_ solution to this situation. We're working with vendors to make
them understand this (work closer and earlier with upstream). Samsung is
making a great effort on 5420/5800, but things won't be perfect overnight.

> > It's an artificial barrier of entry with high risk, and we'll be worse 
> > off for adding it. Same for out-of-tree patches.
> 
> So ... let's find the lesser of all evils ... as always.

We're working hard on making sure a vanilla upstream kernel will work
well on this generation of ARM Chromebooks, something we never really
did with the first generation. If the response we get is "just carry it
out of tree", why would we even care about upstream at all? We're trying
to do the right thing here, even if it might require a line of code or
two here or there that isn't perfect.

> > iRAM is covered on Doug's sub-thread, and I think his approach looks promising.
> > So, it seems like we have a solution both to enable the CCI port and to avoid
> > clearing iram -- we should be set?
> 
> Care to resume the proposed solution then?

Doug has posted patches for the IRAM piece, and Andrew was going to look
at the MCPM piece. So that's already happening.


-Olof
