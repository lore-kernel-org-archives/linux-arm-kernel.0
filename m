From: rob@landley.net (Rob Landley)
Date: Tue, 13 Aug 2013 03:37:31 -0500
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <20130812164548.GE23006@n2100.arm.linux.org.uk> (from
 linux@arm.linux.org.uk on Mon Aug 12 11:45:49 2013)
Message-ID: <1376383051.2737.20@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 11:45:49 AM, Russell King - ARM Linux wrote:
> On Mon, Aug 12, 2013 at 05:24:50PM +0100, Peter Maydell wrote:
> > On 12 August 2013 01:40, Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 08/11/2013 03:04 PM, Russell King - ARM Linux wrote:
> > >> It could be that it's qemu's PCI routing is wrong - it's not the  
> first
> > >> time that qemu has got something wrong.
> >
> > QEMU 1.5 has had its Versatile PCI routing code rewritten to
> > correspond with the hardware (cross-tested versus Arnd Bergmann's
> > patchset
> > http://marc.info/?l=linux-arm-kernel&m=128707282403376&w=2
> > which was run on real versatilePB backplane hardware and
> > could handle a PCI SATA card). I believe it to be correct,
> > and I spent a fairly long time wading through the various bits
> > of documentation and testing those kernel patches on h/w.
> 
> The documentation is totally useless - I've been through it several  
> times
> and it just doesn't give the necessary information to work out what  
> the
> routing actually is.  The only place that's documented is in the  
> circuits,
> which are impossible to get hold of (even asking ARM for them doesn't  
> get
> anywhere: basically, all information has been destroyed.)

We had this argument on the qemu list. See this and Peter's reply  
message to it:

   http://lists.nongnu.org/archive/html/qemu-devel/2013-07/msg01202.html

I got my images working by setting a magic value to a register to  
convince current qemu that it was running an old kernel, and then using  
the IRQ mapping of the old kernel before Linux went through multiple  
different random things that didn't work on the emulator _or_ any  
hardware.

Peter says he knows somebody who knows somebody who dug some instance  
of this hardware out of some landfill or something. Me, I want to get  
something that works on new qemu _and_ last year's qemu, and that's  
what I got. I think that's far more interesting since the point of  
qemu's versatile emulation is really just "an arm board QEMU can stick  
a PCI bus in and thus attach arbitrary devices like network cards and  
hard drives to in a somewhat flexible way".

> > If somebody would like to fix the kernel I am happy to
> > locate the PCI backplane and test everything (again).
> > I would suggest that producing some patches which work
> > with QEMU 1.5 or later would be a good start; then we
> > can test on h/w as confirmation before they are applied.
> 
> If someone is willing to send me some definitive information, then
> the kernel will get fixed.  All the time that there is no definitive
> information, there is no point what so ever changing the kernel.

Because working with old and new qemu, like it used to before everybody  
fiddled with it to not actually match hardware nobody _has_, is  
definitely not an interesting goal. If it was, I'd point you to:

   http://landley.net/hg/aboriginal/rev/c756b708583f

Rob
