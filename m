From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 08:53:46 +0100
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <alpine.LFD.2.00.1104281925500.24613@xanadu.home>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
Message-ID: <20110429075346.GU17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 09:00:08PM -0400, Nicolas Pitre wrote:
> On Thu, 28 Apr 2011, Russell King - ARM Linux wrote:
> 
> > If/when we move to DT, do people think that Linus is going to accept
> > having the DT files in the kernel for all these platforms, and will he
> > be happy to see stuff like the files containing the OMAP clock definitions
> > being constantly patched?  Remember, it's *exactly* this data which Linus
> > wants out of the kernel source.
> 
> Well, here's what he said:
> 
> |But trust me, if you start doing a better job at platform code, I
> |won't be complaining when I get lots of deleted code, or when I start
> |getting devicetree descriptions instead of new drivers.
> (http://article.gmane.org/gmane.linux.kernel/1121387)
> 
> So of course this "getting devicetree descriptions" might be interpreted 
> to mean different things.
> 
> OTOH, the device tree source files can be arranged with common 
> definitions in something like a header file that is included by board 
> specific files.  So, at least in theory, differences between similar 
> boards should be small, hopefully smaller than the equivalent in C.
> 
> Also, DT files should be a representation of the hardware which is meant 
> to be stable.  If it wasn't stable, there would be no point using a data 
> structure that can also be used outside of the kernel.  Remember that 
> one of the selling point for DT is to be able to boot an existing kernel 
> binary on yet-to-be-created hardware simply by creating the appropriate 
> DT description for it.  Hence the DT files for existing hardware 
> shouldn't have to change even if the kernel side implementation does.
>
> > I suspect the answer to that is no.  So I think we should start right now
> > with the idea that putting DT files - even the core SoC ones - into the
> > kernel isn't going to be acceptable.
> 
> Well, if you look at arch/powerpc/boot/dts/* you'll find a bunch of 
> board specific DT files in there already, and Linus has identified PPC 
> as one architecture that did it right in his mind.

Sigh, you really don't understand.

For OMAP we're likely to see several dts files around 200K in size
describing _just_ the clock trees.  As we've seen, the OMAP clock tree
information is modified fairly regularly, adding new clocks, changing
flags, and so forth.

Linus wants this information _out_ of the kernel tree (remember he
referred to the "crazy clock files") which in his opinion should be in
some kind of pre-loader to the kernel and not the kernel itself.
Remember that this is what sparked this whole shebang in the first
place.

Merely moving it from a .c file to a .dts file doesn't move it out of
the kernel tree, and with the constant changes to it, it doesn't solve
the problem of the merge conflicts which Linus ultimately has to fix
up either.

Merely moving it from a .c file to a .dts file in the kernel tree
doesn't solve anything.  At all.  And it isn't going to make Linus
feel any happier about ARM.
