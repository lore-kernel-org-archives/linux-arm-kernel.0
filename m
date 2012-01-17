From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Jan 2012 15:57:46 -0500 (EST)
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <alpine.LFD.2.02.1201171536470.2722@xanadu.home>
References: <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com>
 <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
 <alpine.LFD.2.02.1201171425060.2722@xanadu.home>
 <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
 <alpine.LFD.2.02.1201171536470.2722@xanadu.home>
Message-ID: <alpine.LFD.2.02.1201171553220.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2012, Nicolas Pitre wrote:

> On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
> 
> > On Tue, Jan 17, 2012 at 8:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > > On Tue, 17 Jan 2012, Shilimkar, Santosh wrote:
> > >
> > >> How about allowing platform hooks for single SOC builds. I mean having
> > >> this code under !single_zImage or something like that. That way we don't
> > >> impact the single zImage efforts and also allow socs to have all those
> > >> critical, vital bits enabled for the SOC specific builds.
> > >
> > > Absolutely not! ?Because if we start doing that, people will get lazy
> > > and no platform will ever work in a multi-SOC kernel.
> > >
> > > If your SOC require some fancy setup that is not shared by other
> > > platforms then please abstract that into the bootloader, or make sure it
> > > can be deferred later on.
> > >
> > There is nothing fancy here. It's an ARM security architecture feature which
> > OMAP implements. Have given enough reason about boot-loaders issues.
> 
> I was not convinced by those reasons. Just push harder on the bootloader 
> side.  There is _no_ reason for the bootloader not to take care of this 
> very platform specific issue.  You can even do it into a standalone 
> uImage that returns to u-Boot after it is done with its magic.

Alternatively, you may leverage all the infrastructure that was 
implemented to support CPU offlining i.e. the creation of a 1:1 mapping 
needed to disable the MMU and so on.  That should be possible for you to 
just have the MMU turned off, then call the secure mode to turn on L2, 
then restore MMU and normal operation of the kernel.  This can be 
accomplished later during boot rather than right at the beginning.


Nicolas
