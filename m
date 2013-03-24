From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 24 Mar 2013 11:24:49 +0100 (CET)
Subject: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
In-Reply-To: <Pine.LNX.4.64.1303241053150.3325@axis700.grange>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
 <20130323063215.GF6281@S2101-09.ap.freescale.net>
 <Pine.LNX.4.64.1303241053150.3325@axis700.grange>
Message-ID: <Pine.LNX.4.64.1303241121470.3325@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Mar 2013, Guennadi Liakhovetski wrote:

> On Sat, 23 Mar 2013, Shawn Guo wrote:
> 
> > On Fri, Mar 22, 2013 at 04:47:17PM +0100, Guennadi Liakhovetski wrote:
> 
> [snip]
> 
> > > Secondly you still run a danger, that 
> > > several platforms, built into a single image, register several devices for 
> > > different cpufreq drivers, or even for one... With a special call you know 
> > > there can be only one and you return -EBUSY to all further calls to that 
> > > function.
> > 
> > I do not see how this could happen.  The cpufreq device gets added in
> > target specific init function which will only be invoked when the kernel
> > is running on this target.  Check arch/arm/mach-imx/mach-imx6q.c or the
> > OMAP example given by Nishanth to see how this should be done.
> 
> Sorry, I meant buggy implementations, where an initcall is added without 
> checking, whether it's running on supported hardware.
> 
> Already before your patch for cpufreq-cpu0 to instantiate "mistakenly" on 
> unsupported hardware you had to have an "operating-points" property in 
> your "cpus" node, and you needed a clock attached to your cpu0 device. Do 
> you really think this was likely?
> 
> Anyway, I do find this an overkill and an abuse,

Look at this: in your now platform driver

static int cpu0_cpufreq_probe(struct platform_device *pdev)
{
	...

you get a DT node from "/cpus" with an "operating-points" property:

	for_each_child_of_node(of_find_node_by_path("/cpus"), np) {
		if (of_get_property(np, "operating-points", NULL))
			break;
	}

and then you patch your pseudo-, virtual platform device, that you're 
currently probing with this found DT node:

	cpu_dev = &pdev->dev;
	cpu_dev->of_node = np;

huh...

> but I'm not going to 
> fight over it. If I'm the only one with this impression - no problem, just 
> forget my ranting :)

Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
