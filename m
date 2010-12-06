From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 08:06:07 +0000
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
Message-ID: <20101206080606.GA29563@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 02:12:54PM +0800, Eric Miao wrote:
> On Sun, Dec 5, 2010 at 5:23 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Nov 22, 2010 at 04:26:50PM +0800, Eric Miao wrote:
> >> I wonder if it's still acceptable for a patch like below to have a dynamic IRQ
> >> handler at run-time. There is some changes to the irq_handler, esp. some
> >> SMP changes.
> >>
> >> Magnus had some similar patches to have a run-time irq_handler, which is
> >> a bit more complicated, but I'm also very happy with.
> >
> > I'd prefer a simple but efficient approach. ?I am worried about
> > unnecessarily increasing the IRQ latency - and IRQ latency is something
> > that we should be concerned about. ?It has the ability to make platforms
> > useless.
> >
> > Eg, we know that SMC91x net interfaces are sensitive to IRQ latency, and
> > the same is true of serial ports with small FIFOs.
> >
> > Any attempt to support multiple IRQ handlers is going to increase IRQ
> > handling latency - I don't think that's something which can be avoided,
> > and I'm wondering what effect this and the recent genirq changes is going
> > to have. ?Has anyone been keeping an eye on IRQ handling latency?
> >
> > Lastly, this patch is dependent on your machine class patches, which makes
> > it unsuitable as-is for mainline.
> >
> 
> This one isn't. I've rebased this on top of v2.6.37-rc1.
> 
> >> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> >> + ? ? handle_arch_irq = class ? class->handle_irq : NULL;
                             ^^^^^^^^^^^^^^^^^^^^^^^^^
