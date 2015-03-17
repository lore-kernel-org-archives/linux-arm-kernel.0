From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 17 Mar 2015 19:22:41 +0100
Subject: Is cpufreq-dt safe without regulator support?
In-Reply-To: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
References: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
Message-ID: <1426616561.3392.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 17.03.2015, 15:45 +0800 schrieb wens Tsai:
> Hi Viresh,
> 
> The sunxi platform added cpufreq support in 4.0.0-rc1 using
> the generic cpufreq-dt driver. One issue we've run into is
> the default OPPs we use include an overclocked/overvoltage
> setting.
> 
> If the cpu is missing a regulator supply phandle, or the
> kernel is built without regulators, cpufreq can increase
> the clock rate without the needed voltage increase.
> 
> The former issue can be resolved by providing a dummy
> regulator with the default voltage, effectively disabling
> cpufreq.
> 
> The latter is possible. Without regulator support built-in,
> even a correct, complete DTS can still fail. Should I just
> remove the offending OPP? Still that does not fix the
> problem when we actually do want overclocking.
> 
> To summarize, should cpufreq-dt probe fail when regulator
> support isn't available? Should we differentiate between
> not having a regulator phandle vs no regulator support?
> 
If you have an OPP in the DTS that is not stable with the boot voltage
then you need to handle this case in you platform code by disabling this
OPP if no regulator support is built into the kernel.

You can look at the i.MX code to see how this can be done. It is used
there to disable an OPP depending on fuse settings.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
