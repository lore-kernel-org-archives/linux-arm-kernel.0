From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 23 Jan 2011 09:17:58 -0500 (EST)
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing
	inmdesc->map_io()
In-Reply-To: <9dbba3c432aab294761c32527bc5e96d@mail.gmail.com>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
	<20110122231528.GD11960@n2100.arm.linux.org.uk>
	<AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
	<alpine.LFD.2.00.1101230024240.8580@xanadu.home>
	<9dbba3c432aab294761c32527bc5e96d@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101230911350.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Jan 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> > arm-kernel-bounces at lists.infradead.org] On Behalf Of Nicolas Pitre
> > Sent: Sunday, January 23, 2011 11:01 AM
> > To: Eric Miao
> > Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 1/2] ARM: calculate VMALLOC_END by probing
> > inmdesc->map_io()
> >
> > On Sun, 23 Jan 2011, Eric Miao wrote:
> >
> > > On Sun, Jan 23, 2011 at 7:15 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > I'd instead suggest adding vmalloc_end to the machine
> > description
> > > > record.
> > > >
> > >
> > > And since all boards sharing a same machine_class is going to use
> > > the same value, I'd rather we first introduce struct machine_class
> > > like in the patch I posted months ago?
> >
> > Can we possibly get away with a global VMALLOC_END?  What if we were
> > to
> > decide it is fixed at 0xf0000000 for everyone?
> >
> Which would potentialy shrink the lowmem and vmalloc area. With
> current flexibility of adjustable VMALLOC_END, in 1G:3G model,
> we managed to  have almost ~ 896 MB virtual space available
> for lowmem + vmalloc. So keeping 128MB for vmalloc ~768MB of
> memory can be directly addressable without highmem support.

OK, I just wanted to see if people do think that the simplicity of a 
global definition would have made the per-architecture flexibility 
irrelevant.  But looking at some of the mappings it seems that quite a 
lot of virtual space wastage would be imposed in some cases.

Plus, moving vmalloc_end to the machine record is almost as simple while 
preserving the current flexibility.


Nicolas
