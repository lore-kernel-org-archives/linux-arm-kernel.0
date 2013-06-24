From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Jun 2013 20:20:01 +0100
Subject: [PATCH 3/3] Documentation: Add documentation for APM X-Gene
 clock binding.
In-Reply-To: <CAPw-ZTmJVYU8tPqNGpDSENWKLVkMesDG7m0G_cZ8rCggN3H+gw@mail.gmail.com>
References: <1371828605-18053-1-git-send-email-lho@apm.com>
 <1371828605-18053-2-git-send-email-lho@apm.com>
 <1371828605-18053-3-git-send-email-lho@apm.com>
 <1371828605-18053-4-git-send-email-lho@apm.com>
 <20130624085423.GD19489@e106331-lin.cambridge.arm.com>
 <CAPw-ZTmJVYU8tPqNGpDSENWKLVkMesDG7m0G_cZ8rCggN3H+gw@mail.gmail.com>
Message-ID: <20130624192001.GA11204@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 06:57:14PM +0100, Loc Ho wrote:
> HI,
> 
> 
> >> +Required properties for PLL clocks:
> >> +- reg : shall be the physical PLL register address for the pll clock.
> >> +- clocks : shall be the input parent clock phandle for the clock. This should
> >> +     be the reference clock.
> >> +- #clock-cells : shall be set to 1.
> >> +- clock-output-names : shall be the name of the PLL referenced by derive
> >> +  clock.
> >> +- type : shall be 1 for SoC PLL and 0 for PCP PLL.
> >
> > That makes the binding very difficult for a human to read, could this not be
> > part of the compatible string? e.g. "apm,xgene-pcp-pll-clock".
> [Loc Ho]
> I guess I could by they will only differ by one function in term of
> rate computation.

Having a clear binding is useful, and it's just as easy to do a
comparison on the compatible string as it is to deal with the an opaque
type parameter. Another option would be to make the type parameter a
string (i.e type = "soc" or type = "pcp"), if you feel that they are
similar enough to not warrant separate bindings.

> 
> >
> >> +Optional properties for PLL clocks:
> >> +- clock-names : shall be the name of the PLL. If missing, use the device name.
> >> +
> >> +Required properties for device clocks:
> >> +- reg : shall be the physical CSR reset address base and physical CSR divider
> >> +        address base. If one does not exist, specify 0 for address and 0 for
> >> +        size.
> >> +- clocks : shall be the input parent clock phandle for the clock.
> >> +- #clock-cells : shall be set to 1.
> >> +- clock-output-names : shall be the name of the device referenced.
> >> +Optional properties for device clocks:
> >> +- clock-names : shall be the name of the device clock. If missing, use the
> >> +                device name.
> >> +- flags : Any clock flags. ie. use 0x8 to leave clock un-touch if not
> >> +          referenced. Default is 0.
> >
> > What flags are these? We should *not* be exporting Linux-internal flags as
> > devicetree bindings.
> [Loc Ho]
> I need the CLK ignore if un-used. This is needed in case an subsystem
> - such as PCIE is NOT powered on. With different board design, some IP
> may not have power. Accessing the clock registers will cause exception
> in the kernel. I guess I could just add the clock IGNORE by default
> and not require this.

In cases where the clocks (or any devices) are unusable on a system for
some reason (e.g.  they are unpowered), you could instead set their
status property to "disabled" in a board-specific dts to describe this
(or deafualt them to "disabled" and override this to "okay" in a board
file). That's the conventional way of doing it, and there's already
framework for this in the kernel that prevents them from getting probed
(though I'm not enitrely sure if this is the case when using
*_OF_DECLARE).

Thanks,
Mark.
