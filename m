From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Feb 2015 15:07:50 +0000
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <20150218150602.GE22296@x1>
References: <20150217092020.GC4507@kwain> <20150217115447.GA3989@x1>
 <20150218084004.GD21937@kwain> <20150218090958.GA18042@x1>
 <20150218092225.GE21937@kwain> <20150218104023.GA22296@x1>
 <54E4730D.1060507@gmail.com> <20150218115853.GB22296@x1>
 <54E48EF0.4050807@gmail.com> <20150218150602.GE22296@x1>
Message-ID: <20150218150750.GF22296@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Feb 2015, Lee Jones wrote:

> On Wed, 18 Feb 2015, Sebastian Hesselbarth wrote:
> 
> > On 02/18/2015 12:58 PM, Lee Jones wrote:
> > >I do agree that using 'simple-bus' to describe only this IP would be
> > >an abuse.  However, my foundation thought/argument is unchanged.  This
> > >'driver' is a hack.  It has no functional use besides to work around a
> > >problem of semantics and as such has no place in MFD.
> > 
> > Lee,
> > 
> > sorry I don't get it. Here you say that using simple-bus is an abuse...
> > 
> > >Back onto the simple-bus theme, as this is a syscon device it is a bus
> > >of sorts.  Have you thought about making it a child of your its syscon
> > >node, then using simple-bus to get the OF framework to register the
> > >child devices?
> > 
> > ... and here you suggest to use simple-bus to register the child
> > devices?
> 
> Nope, that's not what I said:
> 
>   "I do agree that using 'simple-bus' to describe *ONLY THIS IP* would
>   be an abuse."
> 
> ... although I believe there is a need to treat syscon devices as
> simple buses.  There are examples of devices doing this already:
> 
> git grep -El 'syscon.*simple-bus' next/master
>   next/master:arch/arm/boot/dts/imx6qdl.dtsi
>   next/master:arch/arm/boot/dts/imx6sl.dtsi
>   next/master:arch/arm/boot/dts/imx6sx.dtsi
>   next/master:arch/arm/boot/dts/zynq-7000.dtsi
> 
> > I fundamentally disagree that either this registers or syscon in general
> > should in any way be seen as a bus. The chip control registers is an
> > highly unsorted bunch of bits that we try to match with cleanly
> > separated subsystems. This makes it a resource but no bus of any sort.
> 
> This is where my comment about semantics comes into play.  syscon may
> not be a bus is the truest sense; however, this is clearly a
> requirement for sub devices to be probed in the same way a simple-bus
> is currently.  So we're just missing a framework somewhere.  We can
> fix that.
> 
> > The problem that we try to solve here is not a DT problem but solely
> > driven by the fact that we need something to register platform_devices
> > for pinctrl and reset. The unit we describe in DT is a pinctrl-clock-
> > power-reset-unit - or short chip control.
> 
> I agree with the last part, but this is a DT problem.  It lacks the
> functionality to be able to cleanly register these types of
> (sub-)devices.  Devices which, in my opinion should be described
> inside the parent syscon node.
> 
> > If you argue that mfd is not the right place for this "driver" we'll
> > have to find a different place for it. I remember Mike has no problem
> > with extending early probed clock drivers to register additional
> > platform_devices - so I guess we end up putting it in there ignoring
> > mfd's ability to do it for us.
> 
> My argument is not that this fake driver doesn't belong in MFD, it's
> that it doesn't belong.  That includes shoving it in drivers/clk.  I
> will be only too happy to have a chat with Mike and provide him with
> my reasons why.
> 
> What I think we should do however, it write some framework code which
> can neatly handle these use-cases, which may just be a case of:
> 
>   s/of_platform_bus_probe/of_platform_subdevice_probe/
> 
> ... obviously I'm oversimplifying by quite some margin, but I'm sure
> you catch my drift.

I should extend that a little.

In the meantime I certainly wouldn't have a problem with you using the
"syscon", "simple-bus" approach as others have done already.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
