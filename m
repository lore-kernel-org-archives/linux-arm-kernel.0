From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 28 May 2018 16:46:51 +0530
Subject: [PATCH 1/6] arm64: dts: amlogic: Add missing cooling device
 properties for CPUs
In-Reply-To: <9f9cc086-6069-afbc-d3c6-46608ff35b79@baylibre.com>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <2a2eb28da9fecf129f6bc0ab3d3748d9f4d25a29.1527225682.git.viresh.kumar@linaro.org>
 <20180525211025.c73zdcdtyuvlewng@localhost>
 <9f9cc086-6069-afbc-d3c6-46608ff35b79@baylibre.com>
Message-ID: <20180528111651.s7xl7e46sfduqk6j@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-05-18, 10:37, Neil Armstrong wrote:
> Hi,
> 
> On 25/05/2018 23:10, Olof Johansson wrote:
> > On Fri, May 25, 2018 at 11:10:01AM +0530, Viresh Kumar wrote:
> >> The cooling device properties, like "#cooling-cells" and
> >> "dynamic-power-coefficient", should either be present for all the CPUs
> >> of a cluster or none. If these are present only for a subset of CPUs of
> >> a cluster then things will start falling apart as soon as the CPUs are
> >> brought online in a different order. For example, this will happen
> >> because the operating system looks for such properties in the CPU node
> >> it is trying to bring up, so that it can register a cooling device.
> >>
> >> Add such missing properties.
> > 
> > This seems awkward compared to just having one cooling-cells in the /cpus node
> > instead.
> > 
> > What's it used for? I don't see any properties in the device nodes on meson-gxm
> > that have any cooling-foo cells in them? So why should #cooling-cells be
> > needed?
> 
> 
> There is no reason to have the cooling-cells on these other CPUs, the DVFS is
> controlled on the first CPU of each cluster, here cpu0 and cpu4 and only
> cpu0 and cpu4 are used as cooling-cells.

First, this is an incomplete definition of the hardware as all the
CPUs are cooling-devices here and DT shouldn't be written assuming how
OS will interpret it.

And then it is broken right now. You can offline your second cluster
(4567 CPUs) and bring CPU5 up first. You will see things breaking.

I have explained more in detail here.

https://marc.info/?l=linux-kernel&m=152750569414761

-- 
viresh
