From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Jun 2018 01:14:18 -0700
Subject: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
In-Reply-To: <20180528111358.meyle364fy6wuruf@vireshk-i7>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
 <20180525211025.c73zdcdtyuvlewng@localhost>
 <20180528111358.meyle364fy6wuruf@vireshk-i7>
Message-ID: <20180602081418.jcl2vjc6saoj3z3d@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 04:43:58PM +0530, Viresh Kumar wrote:
> On 25-05-18, 14:10, Olof Johansson wrote:
> > On Fri, May 25, 2018 at 11:10:01AM +0530, Viresh Kumar wrote:
> > > The cooling device properties, like "#cooling-cells" and
> > > "dynamic-power-coefficient", should either be present for all the CPUs
> > > of a cluster or none. If these are present only for a subset of CPUs of
> > > a cluster then things will start falling apart as soon as the CPUs are
> > > brought online in a different order. For example, this will happen
> > > because the operating system looks for such properties in the CPU node
> > > it is trying to bring up, so that it can register a cooling device.
> > > 
> > > Add such missing properties.
> > 
> > This seems awkward compared to just having one cooling-cells in the /cpus node
> > instead.
> 
> Well, we don't allow that property to be present in /cpus node right
> now and it is per device. And then we may not want all the CPUs to be
> cooling devices really.

And what I am saying is that it sounds like a broken binding if you don't allow
that, especially since it'll be a super common case that all CPUs will specify
the same cooling-device specifier.

> > What's it used for? I don't see any properties in the device nodes on meson-gxm
> > that have any cooling-foo cells in them? So why should #cooling-cells be
> > needed?
> 
> This property is required to declare a device as a cooling-device and
> the device here is CPU. We use it as a cooling device by limiting its
> higher range of frequencies, so that it doesn't generate too much
> heat.
> 
> It is already there for CPU0 and CPU4, but it should really be there
> for all the CPUs, like we have clock, supply, caches, etc.

You have #cooling-cells in the cpu node, but the actual data is in the
thermal-zones nodes. Why isn't #cooling-cells under thermal-zones, next to
cooling-maps?


-Olof
