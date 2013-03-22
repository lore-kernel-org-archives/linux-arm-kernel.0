From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Mar 2013 11:01:30 -0500
Subject: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
In-Reply-To: <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1303221600060.12375@axis700.grange>
Message-ID: <20130322160038.GA4146@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-Anil as the mail id does not seem to be accepted by TI mail server
anymore.

On 16:47-20130322, Guennadi Liakhovetski wrote:
> On Tue, 29 Jan 2013, Shawn Guo wrote:
> 
> > As multiplatform build is being adopted by more and more ARM platforms,
> > initcall function should be used very carefully.  For example, when
> > GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> > will be called on all the platforms to initialize cpufreq-cpu0 driver.
> > 
> > To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> > driver to have it instantiated as a platform_driver.  Then it will only
> > run on platforms that create the platform_device "cpufreq-cpu0".
> 
> Sorry, confused. Before this used to be a generic cpufreq driver, usable 
> on all (DT-enabled only) platforms. You just had to provide an OPP table, 
> a clock, a regulator, similar to this
> 
> http://thread.gmane.org/gmane.linux.kernel.cpufreq/9510/focus=9509
> 
> (also see the complete thread for more information). Now this won't work 
> obviously. Instead we now need a pseudo platform device to instantiate 
> cpufreq-cpu0. This device cannot be put in DT, because it doesn't describe 
> real hardware. So, we have to add register it from the board specific .c 
> code, which we actually want to get rid of... Is this really what we want?
> 
> What about other cpufreq drivers? They have the same problem on 
> multiplatform builds, right? Say, s3c2416-cpufreq.c. It also just 
> initialises itself and starts looking for a clock, names "msysclk" with a 
> NULL device pointer etc. Don't we need a common approach for cpufreq 
> driver initialisation?
> 
> The decision which cpufreq driver to use is SoC-specific, right? We're 
> unlikely to have several boards, using the same SoC, wishing to use 
> different cpufreq drivers? The decision _whether_ or not to enable it and 
> _which_ resources to use might be board-specific. So, how about adding a 
> cpufreq call something like
> 
> cpufreq_driver_request("cpufreq-driver-name");
> 
> to be called by SoC-specific code. You can say it is not much different 
> from adding a virtual device, but firstly I think such a use of a platform 
> device is really an overkill. Secondly you still run a danger, that 
> several platforms, built into a single image, register several devices for 
> different cpufreq drivers, or even for one... With a special call you know 
> there can be only one and you return -EBUSY to all further calls to that 
> function.

Just an note on this specific patch - I made this generic handling for
OMAP OPP handling in my series:
http://marc.info/?l=linux-omap&m=136371580826031&w=2
Handling non-DT and DT enabled boots are key for us as well here.

-- 
Regards,
Nishanth Menon
