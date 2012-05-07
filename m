From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 10:47:19 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507090858.GN26481@n2100.arm.linux.org.uk>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507075800.GL26481@n2100.arm.linux.org.uk>
 <20120507090127.GA2132@sirena.org.uk>
 <20120507090858.GN26481@n2100.arm.linux.org.uk>
Message-ID: <20120507094718.GD4415@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 10:08:58AM +0100, Russell King - ARM Linux wrote:
> On Mon, May 07, 2012 at 10:01:28AM +0100, Mark Brown wrote:

> > They've commonly been used for this, it's a fairly sane way for an MFD
> > to communicate with its subdevices.  The fix in this series isn't good,
> > though - providing a parent resource with a suitable range for all the
> > device resources should do the job much more sensibly.  This isn't great
> > but the infrastructure seems to do the right thing with it for now and
> > it only requires a bit of reinterpretation of what IORESOURCE_IO means.

> It's an abuse.  And it won't work unless PCMCIA, PCI or ISA is enabled.

What causes it to fail if these are disabled?  I've got a bunch of
systems here which don't appear to have any of those enabled as far as I
can tell (though I don't know exactly what I'm looking for with ISA) but
seem to be using this quite happily for some time now.

> This abuse must stop, and it must stop right now.  And I really don't
> care about "it's commonly been used for XYZ" because it's a totally fucked
> idea.

I'd agree we should do something a bit nicer (though just having a
separate resource tree for the chip registers like I suggested does seem
like a reasonable first approach there).

> What if you have two devices both claiming IO regions at 0?  Hint: it
> fails.

Don't think I've got any examples with regions beginning at 0 but other
regions seem to not run into any problems with overlap.  Note that all
these drivers do with the regions is use them to look up the base
register.

> It's buggered beyond belief and it needs to die right now, no questions
> about it.  And anyone who supports this idea needs to be...

We have a bunch of drivers which have been in production for some time
now.  Simply saying the above without offering a constructive
alternative doesn't really help move anything forward here.  We could
add a new resource type but it's not clear to me that there's any need
to do so as it should be possible to arrange to avoid conflicts between
the different address ranges, and obviously there's no little space in
the bitmask used for resource types.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/dfc545ad/attachment.sig>
