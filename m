From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Aug 2013 10:00:09 -0400
Subject: [PATCH 7/7] watchdog: orion: Update device-tree binding
 documentation
In-Reply-To: <20130823100450.GA2389@localhost>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377182518-12554-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823012621.GD13964@titan.lakedaemon.net>
 <20130823100450.GA2389@localhost>
Message-ID: <20130826140009.GH13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 07:04:51AM -0300, Ezequiel Garcia wrote:
> On Thu, Aug 22, 2013 at 09:26:21PM -0400, Jason Cooper wrote:
> > On Thu, Aug 22, 2013 at 11:41:58AM -0300, Ezequiel Garcia wrote:
> > > Change the 'reg' property meaning, by defining three required cells.
> > > It's important to note this commit breaks DT-compatibility for this
> > > device.
> > > 
> > > Cc: devicetree at vger.kernel.org
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> > > index 5dc8d30..bb7f1a2 100644
> > > --- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> > > +++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> > > @@ -3,7 +3,10 @@
> > >  Required Properties:
> > >  
> > >  - Compatibility : "marvell,orion-wdt"
> > > -- reg		: Address of the timer registers
> > > +- reg		: Three cells are required.
> > > +		  First  cell contains the global timer control register.
> > > +		  Second cell contains the watchdog counter register.
> > > +		  Third  cell contains the RSTOUT register.
> > >  
> > >  Optional properties:
> > >  
> > > @@ -13,7 +16,9 @@ Example:
> > >  
> > >  	wdt at 20300 {
> > >  		compatible = "marvell,orion-wdt";
> > > -		reg = <0x20300 0x28>;
> > > +		reg = <0x20300 0x4
> > > +		       0x20324 0x4
> > > +		       0x20108 0x4>;
> > 
> > I don't like this.  It reaches outside of the wdt register.  I think a
> > more clean way to do this is to do a provider/consumer relationship as
> > in reset.txt.  eg, here you would retain the original reg binding, and
> > add a reset phandle.
> > 
> 
> Mmm... I can't see how this fits a reset-controller usage.

Sorry, I wasn't clear.  'as in reset.txt' should have probably been
'similar to reset.txt'.

> The watchdog simply "enables" the RSTOUT bit that allows the whole SoC
> to be reset when the watchdog counter expires.

right.

> The reset-controller seems to be meant to send reset signals to devices,
> which is not this case.

yes, I was thinking (and drinking) of a node for the whole register
(0x20108), with an eventual driver.  Then the phandle in the wdt node.
This hypothetical driver could also incorporate the CPU_SOFT_RESET
(0x2010c) register from orion5x...

> What am I missing?

A suitable application of alcohol and Sun. :)

thx,

Jason.
