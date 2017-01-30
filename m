From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jan 2017 18:49:35 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485801299.1085.0.camel@crowfest.net>
References: <22169925.OhJ0QcnbHM@localhost>
 <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <20170130141308.GV27312@n2100.armlinux.org.uk>
 <CAKv+Gu98i4=COqr_Eikwja28U5MAL83rxe-_QBXWFhJ7v1E6yA@mail.gmail.com>
 <20170130165837.GE27312@n2100.armlinux.org.uk>
 <CAKv+Gu_jEvKdWFWB2Ofxb5ruoTYUEt1puZXBb=9Cn2kEOZO1hg@mail.gmail.com>
 <1485798092.484.5.camel@crowfest.net>
 <yw1xo9yofm41.fsf@unicorn.mansr.com>
 <1485801299.1085.0.camel@crowfest.net>
Message-ID: <20170130184934.GS16461@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:34:59AM -0800, Michael Zoran wrote:
> On Mon, 2017-01-30 at 18:17 +0000, M?ns Rullg?rd wrote:
> > Michael Zoran <mzoran@crowfest.net> writes:
> > > On Mon, 2017-01-30 at 17:09 +0000, Ard Biesheuvel wrote:
> > > > Well, the question is really how to deal with 32-bit
> > > > compatibility
> > > > given the fact that the ARM architecture will drop such
> > > > instructions
> > > > in its next revision. Whether we agree with that, and whether we
> > > > should argue our positions with the architects if we don't is not
> > > > relevant here.
> > > > 
> > > > What is relevant is whether we inform userspace if we spot such a
> > > > deprecated instruction, and I think we should.
> > > > 
> > > > Note that this is not only an issue for the arm64 kernel. The 32-
> > > > bit
> > > > kernel will have the exact same issue when you try to run it on
> > > > hardware that no longer has support for those instructions.
> > > 
> > > Just to inject two cents worth since I'm still on the thread and I
> > > originally started the topic...
> > > 
> > > The Intel comparison seems relevant.? I think in theory you can
> > > still
> > > run old MS-DOS software on an Intel PC if you were so inclined to
> > > do
> > > so.
> > > 
> > > I would think the best would be to turn the warnings off by default
> > > when running in 32 bit mode with the option to turn them back on.?
> > > Then
> > > as time progresses more of more of these instructions can be
> > > converted
> > > to software emulation and removed from the hardware.? And hopefully
> > > as
> > > time progresses, all the user mode software gets upgraded to 64 bit
> > > so
> > > that 32 bit get dropped.
> > > 
> > > The issue seems to me to be more that the kernel is screaming in
> > > the
> > > logs rather then if it's emulating the instructions in hardware or
> > > software.
> > 
> > Might warning once be an acceptable compromise?
> 
> Absolutely!

The problem with warning once is that you miss many of the places where
you're paying the cost of a trap to emulate the instruction. The purpose
of the prints is to notify the user that they're running on borrowed time:
in the next raspberry pi or the one after that, the instruction may be
removed from the hardware and every invocation will trap. The prints are
necessary to aid in code migration and are ratelimited already. If you
decide you don't like them then you can turn them off by writing to files
in sysfs and having the hardware execute the instructions for you, but
having that as the kernel default would be *less* helpful to userspace.

This was all discussed in some detail back in 2014:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/268504.html

and specifically:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/269675.html

I was initially against any emulation at all (which wasn't the right answer
to the problem), but there was a productive discussion and an agreed
solution. I'm really not keen to re-open that can of worms unless something
significant has changed.

Will
