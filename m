From: brian@walsh.ws (Brian Walsh)
Date: Thu, 24 Sep 2009 18:15:59 -0400
Subject: ixp4xx dmabounce
In-Reply-To: <19131.41836.967832.872623@pilspetsen.it.uu.se>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<19129.24807.954274.688709@pilspetsen.it.uu.se>
	<m33a6dk9li.fsf@intrepid.localdomain>
	<a104b22c0909240902g31da6983w26be4526cbdfc16c@mail.gmail.com>
	<19131.41836.967832.872623@pilspetsen.it.uu.se>
Message-ID: <a104b22c0909241515oc2a878dw435c9e5fccb4f46b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 12:50 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Brian Walsh writes:
> ?> On Wed, Sep 23, 2009 at 10:40 AM, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> ?> > Mikael Pettersson <mikpe@it.uu.se> writes:
> ?> >
> ?> >> I strongly suspect that something on the USB or networking side
> ?> >> is allocating I/O buffers without observing the correct DMA APIs.
> ?> >
> ?> > At least the network stack allocates buffers ignoring the DMA masks.
> ?> > The buffers may be allocated by one device (driver) and passed to
> ?> > another device. The only plausible way to fix it is IMHO limiting all
> ?> > skb allocations to the common mask (drivers would be free to either
> ?> > handle or drop skbs outside of their mask).
> ?> >
> ?> > This is relatively easy to implement and I'm going to try it, when time
> ?> > permits.
> ?> >
> ?> >> I think Krzysztof Halasa mentioned running ixp4xx devices with 128MB
> ?> >> RAM and a kernel hacked so kernel-private allocations would always be
> ?> >> served from memory below 64MB. I think he mentioned doing that because
> ?> >> of networking components that would ignore PCI DMA mask constraints.
> ?> >
> ?> > Right. This works fine for network buffers because they aren't that
> ?> > large. The current patch is suboptimal, though.
> ?> > --
> ?> > Krzysztof Halasa
> ?> >
> ?>
> ?> I tried Krzysztof's patch and it had no noticeable affect. ?I am still getting
> ?> about 6.3 Mbps IP data throughput when only using the ohci controller and
> ?> about 3.6 Mbps when the device is attached to the ehci controller. ?This
> ?> device works fine when running the same testing attached to an x86
> ?> configured machine and gets about 18 Mbps IP data throughput.
>
> If your application can operate in 64MB RAM, you may want to try
> a kernel that includes only my ixp4xx disable dmabounce patch,
> and boot it with mem=64M. (Look in the kernel boot log and verify
> that it only sees 64M of RAM.)
>
> If performance increases, then your performance loss is due to bounces.
>

Mikael

I used your patch to disable legacy bounce, disabled support for > 64MB RAM,
and used the mem=64M kernel option.  There was no change in the data
throughput.

I am not sure where this leaves me.

Brian
