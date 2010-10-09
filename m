From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Oct 2010 14:52:11 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20101009135210.GA25564@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 12:44:22PM +0300, Felipe Contreras wrote:
> For issues related to this:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/84454

This one nicely shows some of the problems which can occur with the
memory type attributes - and this is not attributable to ioremap().

ioremap() is used to map devices.  It creates device memory type mappings.
If what you're mapping doesn't support device memory type mappings, then
accesses via an ioremap()'d region isn't going to work - as this guy is
observing.

That's not because ioremap() is doing something wrong.  It's doing what
it's meant to do.  The use is wrong, and is completely unrelated to the
issue you've raised.

> http://article.gmane.org/gmane.linux.ports.sh.devel/8560

This one we know about, and as I've already said, it ends up with three
aliasing mappings each with different attributes thusly:

	cpu = dma_alloc_coherent(dev, size, &dma, GFP_KERNEL);
	dma_declare_coherent_memory(dev, dma, dma, size, DMA_MEMORY_MAP);
		==> ioremap(dma, size);
	...
	dma_alloc_coherent(dev, ...);

This wasn't spotted in the review of sh-mobile code because it's not part
of the sh-mobile code base, but some of the generic sh architecture code.
sh-mobile went into the kernel on March 12th, so it does pre-date the
change to ioremap, and is therefore technically a regression.

However, as can be seen from the link above, it's been known about since
8th August - two months ago.  The problem has been discussed, and we had
a good solution which would work.  But then an oar got thrown in which
basically resulted in that solution being rejected - on the basis that
"it's an established API and it must work".

Well, this usage of the API doesn't work on x86!

The result - progress on the issue hit a brick wall and is unable to
proceed because of personal viewpoints conflicting with reality.

> http://www.spinics.net/lists/linux-fbdev/msg01745.html

External user?  Unreviewed code?  You can't seriously be suggesting
that we should care about code we haven't seen which is sitting
externally to the kernel tree, and this is a valid reason to hold
off on changes to the kernel.

> http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/22271

"No file".
