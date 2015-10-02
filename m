From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Oct 2015 19:53:37 +0100
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <560EC863.8030600@free.fr>
References: <560EAA7C.3070302@free.fr> <yw1xoaghl099.fsf@unicorn.mansr.com>
 <560EB1EC.3020403@free.fr>
 <20151002171334.GB21513@n2100.arm.linux.org.uk>
 <560EC863.8030600@free.fr>
Message-ID: <20151002185337.GC21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 08:09:39PM +0200, Mason wrote:
> On 02/10/2015 19:13, Russell King - ARM Linux wrote:
> > On Fri, Oct 02, 2015 at 06:33:48PM +0200, Mason wrote:
> >> On 02/10/2015 18:10, M?ns Rullg?rd wrote:
> >>
> >>> Mason writes:
> >>>
> >>>> +		intc: intc at e000 {
> >>>> +			compatible = "sigma,tango-intc";
> >>>
> >>> Why do you insist on using other names than the ones I've been using for
> >>> months?  Just want to leave your own mark on the code?
> >>
> >> You're using "sigma,smp8640-intc".
> >> The SMP8640 is a Tango3 (MIPS-based) platform.
> > 
> > If it's the same device, then there's nothing wrong with re-using the
> > compatible.  The compatible property actually accepts multiple values,
> > so you can do:
> > 
> > 			compatible = "sigma,tango4-intc", "sigma,smp8640-intc";
> 
> I have access to resources unavailable to Mans. Since I know the
> interrupt controller is the same on Tango2, Tango3 and Tango4,
> doesn't it make sense to use the string "sigma,tango-intc"
> given that the driver is not even upstream yet?

You could do:
			compatible = "sigma,tango4-intc",
				     "sigma,tango-intc",
				     "sigma,smp8640-intc";

The advantage of using the most specific first is that if you then find
the hardware contains bugs, you can _just_ modify the device driver to
match on the specific ID, and implement workarounds based on that.  Older
device trees will then pick up those same workarounds without needing to
be modified.

Remember, device trees are supposed to describe the hardware.

> (If worse comes to worst, I suppose I can always write my own
> driver from scratch; I just find it silly to duplicate work.)

It's not about writing a separate driver.  What the above says is that
this device is first and foremost a "sigma,tango4-intc" device, but if
we don't have such a driver, it can be driven by a driver for
"sigma,tango-intc", but if we don't have one of those, then it can
be driven by a "sigma,smp8640-intc" driver.

Please read the quoted bit of the spec on this to get a proper
understanding of how these compatible strings are supposed to work:

> > See the ePAPR spec - I'll include the relevant bit:
> > 
> > Property: compatible
> > Value type: <stringlist>
> > Description: The compatible property value consists of one or more strings
> >  that define the specific programming model for the device. This list of
> >  strings should be used by a client program for device driver selection.
> >  The property value consists of a concatenated list of null terminated
> >  strings, from most specific to most general. They allow a device to
> >  express its compatibility with a family of similar devices, potentially
> >  allowing a single device driver to match against several devices. ...
> > Example: compatible = "fsl,mpc8641-uart", "ns16550";
> >  In this example, an operating system would first try to locate a device
> >  driver that supported fsl,mpc8641-uart. If a driver was not found, it
> >  would then try to locate a driver that supported the more general
> >  ns16550 device type.
> > 
> > Note also that vendor prefixes should be listed in
> > Documentation/devicetree/bindings/vendor-prefixes.txt.  If it's not there,
> > you need to propose a separate patch (to the devicetree mailing list) to
> > add it, which must be done with their agreement.  Right now, the use of
> > "sigma" as a prefix is entirely non-standard and not acceptable in DT
> > files until this is done.
> 
> As far as the upstreaming process is concerned, I speak for Sigma.

It doesn't matter who you speak for.  Your first patch should be to
_only_ add the vendor ID to that file above, and to get it acked by
the device tree maintainers.  That makes it "official" in the eyes of
the developers responsible for maintaining the sanity of device tree.

However, that has an impact on the above: you should therefore have
access to the folk who know the origins of the interrupt controller,
and whether it is a derivative of "sigma,smp8640-intc" or something
else.  If "sigma,smp8640-intc" and "sigma,tango-intc" are jointly
derived from a common ancestor, then you should not mention
"sigma,smp8640-intc" at all.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
