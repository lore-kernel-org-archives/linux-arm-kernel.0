From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Oct 2010 13:15:58 +0200
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <AANLkTin7N8g1KdkyJ5ZsaKp=vUfvrffzvK8j+Z78bU0P@mail.gmail.com>
References: <1286279904-4378-1-git-send-email-yong.shen@linaro.org>
	<201010051425.06523.arnd@arndb.de>
	<AANLkTin7N8g1KdkyJ5ZsaKp=vUfvrffzvK8j+Z78bU0P@mail.gmail.com>
Message-ID: <201010061315.58771.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 October 2010, Yong Shen wrote:
> Hi Arnd,
> 
> Really appreciate your valuable comments. Most of them are accepted. I have
> different option about two comments.
> 1.
> 
> > It would be better to make this code a proper device driver,
> > probably a platform_driver unless you have a way to probe
> > the presence of the registers on another bus.
> >
> > Making it a driver that registers to a bus lets you separate
> > the probing from the implementation, and gives you a structure
> > to add your private variables to.
> >
> cpufreq is supposed to be registered using cpufreq_register_driver directly,
> so no other platform data is needed. You can also find out other cpufreq
> driver is designed this way, like omap cpufreq driver.

Ok, it is indeed different from what I thought.

My thought was that you have resources that need to be attached
to a device which then can get matched to a device_driver.

However, this is not how it works with the generic clock framework.
The device that you are controlling is not a random platform
device but the actual CPU, which has a node in the device tree
already (/sys/devices/system/cpu/*) and that gets controlled by
the generic cpufreq layer, while the resources are tied to the
struct clk that you are controlling.

So if anything, the clk is what needs to be a platform device,
not an artificial cpufreq device. You are only adding another
clock to the clock-mx51.c file and you are consistent with the
existing clocks in there, so I'm not asking you to change anything
here.

I wonder however if we can create a common cpufreq driver that
would work for all platforms that just need to call clk_set_rate
in the end and can operate from platform specific tables otherwise.
About half the cpufreq drivers in arm seem to be a variation of
this already, so we might be able to make the clock framework
good enough for this.

> 2.
> 
> > Don't use __raw_readl but readl/ioread32, which have more well-defined
> > behaviour.
> >
> I think __raw_readl is ok here, since in the platform related code, we know
> the register layout and length, this is more efficient. Also this is
> extensively used in arch/arm/.

I still disagree, but it's not important. IMHO most of the uses of
__raw_readl should be converted to readl or readl_relaxed if you are
worried about efficiency.

The main difference between __raw_readl and readl_relaxed is that the
endianess is well-defined on readl_relaxed.

	Arnd
