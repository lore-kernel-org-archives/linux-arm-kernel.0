From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 4 Jan 2012 15:35:36 -0800
Subject: [RFC PATCH v2 1/2] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <CAMXH7KGjOmebAPROEtZuc8dJU0oDKOZXjvB1E6UwavWmwhwcOw@mail.gmail.com>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-2-git-send-email-rob.lee@linaro.org>
 <4EF3B5EF.8030108@gmail.com>
 <CAMXH7KGjOmebAPROEtZuc8dJU0oDKOZXjvB1E6UwavWmwhwcOw@mail.gmail.com>
Message-ID: <CAJOA=zNFmAHDPJRfeihCo08B86re1X1LH=uTimam0uemwK+TNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 3:15 PM, Rob Lee <rob.lee@linaro.org> wrote:
> On 22 December 2011 16:57, Rob Herring <robherring2@gmail.com> wrote:
>> On 12/14/2011 01:02 AM, Robert Lee wrote:
>>> +static struct cpuidle_driver exynos4_idle_driver = {
>>> + ? ? .name ? ? ? ? ? = "exynos4_idle",
>>> + ? ? .owner ? ? ? ? ?= THIS_MODULE,
>>> + ? ? .states[0] = {
>>> + ? ? ? ? ? ? .enter ? ? ? ? ? ? ? ? ?= cpuidle_def_idle,
>>> ? ? ? ? ? ? ? .exit_latency ? ? ? ? ? = 1,
>>> ? ? ? ? ? ? ? .target_residency ? ? ? = 100000,
>>> ? ? ? ? ? ? ? .flags ? ? ? ? ? ? ? ? ?= CPUIDLE_FLAG_TIME_VALID,
>>> ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "IDLE",
>>> ? ? ? ? ? ? ? .desc ? ? ? ? ? ? ? ? ? = "ARM clock gating(WFI)",
>>> ? ? ? },
>>
>> As this is just plain wfi and shouldn't really be different per
>> platform, it would be nice to get rid of all of this state info. Perhaps
>> a macro with all the data since each driver needs to init each state.
>> The target residency value looks kind of suspect. You should only go to
>> wfi if you expect to be idle for 100ms?
>>
>
> Ok, I'll look at add a ARM specific macro for a generic WFI state in v3.
>
> For the target_residency value, I don't understand why the values
> being used are there other than some of the original ARM platform
> implementations were based on the Intel implementations per their
> comments, and the Intel value was used. ?From the comments in
> drivers/cpuidle/governors/menu.c: "state entry and exit have an energy
> cost, and a certain amount of time in the ?C state is required to
> actually break even on this cost. CPUIDLE provides us this duration in
> the target_residency field". ?The governor code uses it accordingly.
> I'm not aware that a pure WFI only state uses additional energy to
> enter and exit compared to spinning in a loop, so I think the
> "target_residency" of a pure WFI state value should 0 or 1. ?If a
> platform skips a pure WFI idle state and also implements additional
> platform specific power savings in their "WFI" idle state, then they
> may need to adjust exit_latency and target_residency accordingly.

Extra data point: on OMAP4 we chose .target_residency = 5 for simple WFI state:
http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/cpuidle44xx.c;h=383944076085f808b8764baf11df0589229010e5;hb=p-android-omap-3.0#l113

Regards,
Mike
