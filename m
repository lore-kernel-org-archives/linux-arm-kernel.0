From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 23 Dec 2011 17:05:09 +0800
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
 <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
 <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
 <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
 <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
Message-ID: <CACVXFVOmVZH+cZ6fZhwMkTfzV02FfJDJDTE+4XabGPeqbsfJtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 4:45 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Fri, Dec 23, 2011 at 2:00 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> Hi Shilimkar,
>>
>> Sorry for the delay.
>>
>> On Mon, Dec 19, 2011 at 2:17 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>
>>> The patches are fine but I am surprised that 'dyndep.patch' is helping you.
>>> L3_2 dependency is always enabled with ISS or Camera and it
>>> should have worked.
>>> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm), shoudn't do anything since
>>> the bit is read-only.
>>
>> Yes, you are right. After some investigating, I found that
>> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm) returns failure, so clkdms_setup
>> is bypassed and the issue is avoided.
>>
> Good.
>
>>>
>>> Can you check value of CM_CAM_STATICDEP [ 0x4A009004],
>>
>> The value is 0x40 after and before the patch.
>>
>>> after your patch. I am suspecting that for some reason l3_1 dep.
>>> is getting enabled which might be helping your case.
>>
>> Seems no changes after adding clkdm_add_wkdep(iss_clkdm, l3_1_clkdm)
>> on the problem.
>>
>> The only change on iss(CAM) clock domain setting in your commit[1] is to
>> configure CLKTRCTRL as HW_AUTO, instead of previous ?SW_WKUP.
>> Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
>> fixed, so I am wondering if something is wrong about HW_AUTO mode
>> of CAM clock domain.
>>
> Now I recollect the issue and also track a patch in the internal product tree.
> Same is attached and also in the end of the email.
>
> I am lopping Miguel who wrote the patch and Benoit who acked it.
> This should sort out your issue as you have already verified it works.

Yes, I am sure.

> Regards
> Santosh
>
> From 972d7bb544d3197d7fc1a6c6eb0e2c9cc08d5e9d Mon Sep 17 00:00:00 2001
> From: Miguel Vadillo <vadillo@ti.com>
> Date: Tue, 21 Jun 2011 09:59:45 -0500
> Subject: [PATCH 1/2] OMAP: clockdomain: set iss clk domain to just SWSUP
>
> Since CAM domain(ISS) has no module wake-up dependency
> with any other clock domain of the device and the dynamic
> dependency from L3_main_2 is always disabled, the domain
> needs to be in force wakeup in order to be able to access
> it for configure(sysconfig) it or use it.
>
> Also since there is no clock in the domain managed automatically
> by the hardware, there is no use to configure automatic
> clock domain transition. SW should keep the SW_WKUP domain
> transition as long as a module in the domain is required to
> be functional.
>
> Signed-off-by: Miguel Vadillo <vadillo@ti.com>
> Acked-by: Benoit Cousson<b-cousson@ti.com>

Please feel free to add:

       Reported-and-tested-by: Ming Lei <ming.lei@canonical.com>

> ---
> ?arch/arm/mach-omap2/clockdomains44xx_data.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
> b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index 6ac8fe2..8d1a061 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -605,7 +605,7 @@ static struct clockdomain iss_44xx_clkdm = {
> ? ? ? ?.clkdm_offs ? ? ? = OMAP4430_CM2_CAM_CAM_CDOFFS,
> ? ? ? ?.wkdep_srcs ? ? ? = iss_wkup_sleep_deps,
> ? ? ? ?.sleepdep_srcs ? ?= iss_wkup_sleep_deps,
> - ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_HWSUP_SWSUP,
> + ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_SWSUP,
> ? ? ? ?.omap_chip ? ? ? ?= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
> ?};
>
> --
> 1.7.4.1


thanks,
-- 
Ming Lei
