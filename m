From: nm@ti.com (Nishanth Menon)
Date: Mon, 10 Mar 2014 12:11:44 -0500
Subject: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
In-Reply-To: <20140303035426.GC2411@sirena.org.uk>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk> <530B594F.2030500@ti.com>
 <20140303035426.GC2411@sirena.org.uk>
Message-ID: <531DF250.5060100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2014 09:54 PM, Mark Brown wrote:
> On Mon, Feb 24, 2014 at 08:38:07AM -0600, Nishanth Menon wrote:
> 
>> Intent here is to allow drivers such as cpufreq-cpu0 to be reused on
>> platforms such as TI's OMAP derivatives, and other SoCs which differ
>> only by the sequence involved in voltage scale operations. So, this
>> patch provides a framework for registering the underlying
>> implementation of the SoC specific voltage change methodology.
> 
> That bit is clear, what's very opaque from the code is how this is going
> to be accomplished.
The SoC specific voltage domain drivers register with
devm_voltdm_register. the fops provide the abstraction needed for the
SoC (example in patch #5 - which introduces OMAP specific voltage
domain which handles ABB and VDD regulators).

What would you suggest that we do to clarify the usage here?

>> Overall the sequence takes place after this patch is as follows:
>> a) voltage domain drivers such as those of TI or others register with
>> voltage domain with devm_voltdm_register.
>> b) cpufreq-cpu0/devfreq drivers:
>> of_pm_voltdm_notifier_register(introduced as part of patch #1) to
>> register notifiers around clk of interest. This request is linked to
>> the specific voltage domain using phandle in device tree.
>> c) when cpufreq-cpu0/devfreq does a clk_set_rate, the common clock
>> framework triggers notifiers in voltage domain core which in turn,
>> invokes the corresponding handlers for the voltage domain driver
>> ensuring the right dvfs sequence specific to the SoC is triggered.
> 
> So the first question I have here is what happens if multiple clocks
> need to be updated in lock step - if we're only triggering off clock
> notifiers that seems tricky.  The other thing here is that the fact that
Yes, that is true, however, there are ways to implement them, for
example: We could implement an higher level clock that takes care of
the multiple clock node control to handle this kind of scenario.

I can elaborate that in the commit message, if that is desirable.

> your API is "of_" suggests that it is in fact linked very srongly to DT
> - it'd be good to split out the layers to make sure things make sense
> standalone, the DT helpers are obviously good but the API should be able
> to stand separately.

You are correct, I had intended the RFC as purely "OF only". I will
make it independent of of in the next revision.

-- 
Regards,
Nishanth Menon
