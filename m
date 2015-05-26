From: atull@opensource.altera.com (atull)
Date: Tue, 26 May 2015 16:37:55 -0500
Subject: [PATCH v4 2/2] ARM: socfpga: dts: add sdram controller dt binding
 doc
In-Reply-To: <20150525123902.GE9943@amd>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-3-git-send-email-atull@opensource.altera.com>
 <20150525123902.GE9943@amd>
Message-ID: <alpine.DEB.2.02.1505261637120.19205@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 May 2015, Pavel Machek wrote:

> On Fri 2015-05-22 13:02:15, Alan Tull wrote:
> > Add binding doc for Altera SOCFPGA SDRAM controller.
> > 
> > Signed-off-by: Alan Tull <atull@opensource.altera.com>
> > ---
> > v4: Add bindings doc
> > ---
> >  .../arm/altera/socfpga-sdram-controller.txt        |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> > new file mode 100644
> > index 0000000..77ca635
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
> > @@ -0,0 +1,12 @@
> > +Altera SOCFPGA SDRAM Controller
> > +
> > +Required properties:
> > +- compatible : Should contain "altr,sdr-ctl" and "syscon".
> > +  syscon is required by the Altera SOCFPGA SDRAM EDAC.
> > +- reg : Should contain 1 register range (address and length)
> > +
> > +Example:
> > +	sdr: sdr at ffc25000 {
> > +		compatible = "altr,sdr-ctl", "syscon";
> 
> Is the syscon binding good idea? Should the EDAC driver be fixed to
> accept altr,sdr-ctl binding, instead?
> 							Pavel

What problems do you see here?  I'd like to avoid changing the
EDAC if possible.

We have 3 things (EDAC, fpga bridges, suspend) that need access
to the sdc.  They access 3 nonoverlapping sets of registers
within the sdc to get at 3 different sets of functionality.
Both EDAC and the fpga bridge are using syscon.  The suspend
code can't use syscon because it has to be assembly running
in OCRAM to enable self-refresh for the DDR.

Thor Thayer ended up using syscon for the EDAC after a thorough
discussion on lkml and several revisions of the EDAC driver that
tried it several different ways before finally ending up back
where he started.

Alan Tull

> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
