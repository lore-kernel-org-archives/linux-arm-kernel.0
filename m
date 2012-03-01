From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 18:25:43 +0000
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <20120301140817.GG7363@n2100.arm.linux.org.uk>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201203011352.36067.arnd@arndb.de>
 <20120301140817.GG7363@n2100.arm.linux.org.uk>
Message-ID: <201203011825.44049.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 01, 2012 at 01:52:35PM +0000, Arnd Bergmann wrote:
> > Ok. I've looked up the manual for IOP134x and it's very clear there that
> > it has only two 64k I/O windows but no more (developer manual, sections
> > 2.2.2.1 and 3.3.2.1). Limiting the virtual space to 64k would result in
> > seeing only one of the buses, but 1 MB is enough if we map both buses
> > in there.
> 
> I think it was the 80312, and the manual does limit the window to 64k.

I can't see where we suport that one in Linux, was it removed at some
point? I also can't find any documentation for it on the web.

This makes it hard to figure out now what exactly the problem was,
but at least we don't have to worry about breaking that machine now.

The iop variants in the kernel today only map 64kb of I/O window
today, so I can't see how we would regress.
That leaves us still with Kirkwood/Dove and ixp2000 to figure out.

I can imagine that ixp2000 has a similar problem to the one you describe
because of the way it uses the second 64kb in the resource instead of
the first 64kb. I would suggest that for ixp2000 we just make the first
1MB of of the 32MB window, which covers the 64kb resource and more.
I've checked that none of the ixp2000 specific drivers use PC-style
I/O anywhere outside of PCI and that the only IO resource that is
registered is the one for the PCI bus, so I'm rather optimistic about this
one.

For Kirkwood and Dove, an easy way out would be to extend the I/O
space window to 2MB right away and just map both as before, but we
can also try just using the two lower 64k windows in each and see what
breaks, as those seem to be widely available for testing still.

	Arnd
