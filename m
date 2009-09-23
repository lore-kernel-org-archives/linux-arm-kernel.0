From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 23 Sep 2009 16:40:41 +0200
Subject: ixp4xx dmabounce
In-Reply-To: <19129.24807.954274.688709@pilspetsen.it.uu.se> (Mikael
	Pettersson's message of "Wed, 23 Sep 2009 01:42:31 +0200")
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<19129.24807.954274.688709@pilspetsen.it.uu.se>
Message-ID: <m33a6dk9li.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> I strongly suspect that something on the USB or networking side
> is allocating I/O buffers without observing the correct DMA APIs.

At least the network stack allocates buffers ignoring the DMA masks.
The buffers may be allocated by one device (driver) and passed to
another device. The only plausible way to fix it is IMHO limiting all
skb allocations to the common mask (drivers would be free to either
handle or drop skbs outside of their mask).

This is relatively easy to implement and I'm going to try it, when time
permits.

> I think Krzysztof Halasa mentioned running ixp4xx devices with 128MB
> RAM and a kernel hacked so kernel-private allocations would always be
> served from memory below 64MB. I think he mentioned doing that because
> of networking components that would ignore PCI DMA mask constraints.

Right. This works fine for network buffers because they aren't that
large. The current patch is suboptimal, though.
-- 
Krzysztof Halasa
