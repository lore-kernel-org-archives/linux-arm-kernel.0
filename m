From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 27 Mar 2013 10:53:57 -0700
Subject: omap cpufreq driver in multi-platform kernels
In-Reply-To: <20130327170221.GA32231@kahuna> (Nishanth Menon's message of
 "Wed, 27 Mar 2013 12:02:21 -0500")
References: <5152503C.2050503@gmail.com>
 <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com>
 <20130327133220.GA30868@kahuna> <5153207A.4050109@gmail.com>
 <20130327170221.GA32231@kahuna>
Message-ID: <87d2uk91ai.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

Nishanth Menon <nm@ti.com> writes:

> On 11:38-20130327, Rob Herring wrote:
>> On 03/27/2013 08:32 AM, Nishanth Menon wrote:
>> > On 02:23-20130327, Paul Walmsley wrote:
>> >> Hi
>> >>
>> >> On Tue, 26 Mar 2013, Rob Herring wrote:
>> >>
>> >>> The omap cpufreq driver causes problems in multi-platform kernels
>> >>> because it unconditionally registers with the cpufreq core and does not
>> >>> check sufficiently that it is running on an omap platform. So on a
>> >>> kernel with highbank and omap drivers booted on highbank, the
>> >>> cpufreq-cpu0 driver fails to init. Any suggestions for how to fix? For
>> >>> DT this could just be several of_machine_is_compatible checks, but I'm
>> >>> not really sure for non-DT. Converting the driver to a platform driver
>> >>> would be another option.
>> >>
>> >> We could move the
>> >>
>> >> 	mpu_clk = clk_get(NULL, "cpufreq_ck");
>> >>
>> >> down to omap_cpufreq_init(), and bail out early if the clock alias doesn't 
>> >> exist.  (Presumably we'd also want to change the clock role name if we did 
>> >> that, to something like "omap_cpufreq_ck".)
>> >>
>> >> Experimental patch follows, comments welcome.
>> > We should deprecate usage on omap-cpufreq driver eventually, instead go
>> > towards embracing the SoC generic implementation of cpufreq-cpu0 driver
>> > IMHO.
>> > http://marc.info/?l=linux-omap&m=136371580826031&w=2
>> > is the series to support cpufreq_cpu0 driver in DT based boot.
>> > Would you think this approach is sane? 
>> 
>> That only solves the problem for DT, but not non-DT. My understanding is
>> non-DT omap platforms will be around for some time.
>> 
> Yes, that is true. There are multiple parts of the problem:
> part #1: DT boot:
> https://patchwork.kernel.org/patch/2303471/ prevents omap-cpufreq from
> interfering in DT enabled boot. (seeing DT entries for highbank it
> probably might help in the specific platform)
> part #2: non DT boot:
> you would not have cpu DT nodes in the system. So, cpufreq-cpu0 wont come
> into play[1]
> Now the conflict between omap-cpufreq Vs non-dt platform cpufreq driver:
> other than registering an dummy device and moving omap_cpufreq_init to
> it (similar to what was done in cpufreq-cpu0[2]) I dont see how we can
> continue to keep multiple platforms sane in mult-arch non-dt boot.
>
> [1] https://patchwork.kernel.org/patch/2351601/
> [2] https://patchwork.kernel.org/patch/2067751/

I think the platform_device conversion is the way to go.  I think you
should do that instead of PATCH 8/8 of your OMAP conversion to the
generic driver[1].

I'll have a closer look at that series also and comment there as well.

Kevin

[1] http://marc.info/?l=linux-omap&m=136371580826031&w=2
