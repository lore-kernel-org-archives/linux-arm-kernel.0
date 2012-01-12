From: khilman@ti.com (Kevin Hilman)
Date: Thu, 12 Jan 2012 14:52:20 -0800
Subject: [PATCH V6 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20120112082300.GF2414@b20223-02.ap.freescale.net> (Richard
 Zhao's message of "Thu, 12 Jan 2012 16:23:01 +0800")
References: <1325213769-11752-1-git-send-email-richard.zhao@linaro.org>
 <1325213769-11752-5-git-send-email-richard.zhao@linaro.org>
 <87aa5t25ad.fsf@ti.com>
 <20120112082300.GF2414@b20223-02.ap.freescale.net>
Message-ID: <874nw0sfdn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> On Wed, Jan 11, 2012 at 03:22:34PM -0800, Kevin Hilman wrote:
>> Richard Zhao <richard.zhao@linaro.org> writes:
>> 
>> > The driver get cpu operation point table from device tree cpu0 node,
>> 
>> Since we already have an existing OPP infrastructure in the kernel,
>> seems like  this driver should get OPPs by asking the OPP layer.
>
> When I created the patch, there's only omap cpufreq driver using
> OPP. If it depends on OPP, it might prevent users who have not
> adopted OPP from using the driver.

Then they should probably adopt to OPP, since it was created exactly for
this purpose.   What this patch creates is an alternate way of adding
OPPs using the device tree.  

The point is using a static list of OPPs from boot time simply doesn't
work.  You need the ability to dynamically add/remove OPPs at runtime to
adjust for various operating conditons (or HW bugs) as well as for
thermal considerations.   The OPP layer provides this.

A generic driver should get available OPPs using the OPP layer.

The DT can certainly be used at boot time to create the initial list of
OPPs, but as the list of available OPPs changes at runtime, the only way
to track that is to use the OPP layer.


>> This approach assumes the OPP layer is static at boot time and not
>> changing, however that's not the case in practice.
>> 
>> The OPP layer could be extended to read boot-time OPPs from DT if
>> desired, but since the OPPs are also populated/enabled/disabled
>> dynamicaly on some platforms (e.g. OMAP), I think the any generic
>> CPUfreq driver should use the OPP interface and not DT directly.
>> 
>> > and adjusts operating points using clk and regulator APIs.
>> 
>> For a generic driver, the regulator used should also be configurable.
>> 
>> For example, this driver currently assumes a regulator named "cpu" for
>> all instances.   If you had separate clusters with independent voltage
>> control, you'd likely have a separate regulator for each cluster.
> The driver, for now, assumes all cpu cores uses the same clk and voltage.
> It's correct for most arm multi-core SoC.

Sure, but a "generic" driver such as the one proposed is not just for
ARM, and not just for today's SoCs.  
flexible enough

> Do you have real case to need different voltage/clk?

Sure, any system with independently scalable CPUs/clusters.

Kevin
