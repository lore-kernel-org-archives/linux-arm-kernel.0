From: nitinchaudhary1289@gmail.com (Nitin Chaudhary)
Date: Wed, 17 Aug 2016 10:40:15 -0700
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <CAJOu_2-fmRzt42stPCrXC4fEzcPnGCgT1B-HpY7U37WTFjMA7w@mail.gmail.com>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <1471395561-30389-1-git-send-email-Nitin.Chaudhary@zii.aero>
 <DB5PR04MB1430018C7BFB14A65517162C9F140@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <CAJOu_2-fmRzt42stPCrXC4fEzcPnGCgT1B-HpY7U37WTFjMA7w@mail.gmail.com>
Message-ID: <CAJOu_2_2vh575Om8dgaHMzLu9oJW8i06UaVkob_R7pRyQRe7KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Typo correction.

2. I am having an issue with the MMDC driver running Linux Kernel
4.8-rc2 and its unable to successfully probe due to timeout waiting for
MMDC automatic power saving mode getting enabled.

On Wed, Aug 17, 2016 at 10:36 AM, Nitin Chaudhary
<nitinchaudhary1289@gmail.com> wrote:
> Hi Zhengyu,
>
> There are two main reasons why I made pmu_mmdc to be static:
> 1. Since i.MX6Q has only a single MMDC IP, at any time there should be
> only 1 instance of the same.
> 2. Now as the code plugs itself into the perf core, it is very
> unlikely we need to allow access to this
>  data structure from outside the driver code. If we need to do for
> some reasons in kernel in the future then
>  we can expose some wrapper APIs to achieve that in a safeway.
>
> Also, I have a few questions regarding MMDC initialization.
> 1. Is there any specific hardware initialization reason that we do a
> busy loop while trying to enable Automatic
>     power saving mode. Is it possible to move it to deferred workqueue?
> 2. I am having an issue with the MMDC driver running Linux Kernel
> 4.8-rc2 and its unable to successfully
>     probe due to timeout waiting for MMDC automatic wait getting
> enabled. The below is the log message
>     along with the debug messages I added to dump the read values for
> MDMIC and MAPSR reg in MMDC
>    connected to singel channel DDR3.
> [    0.133162] imx_mmdc_probe MMDC_MDMISC: 0x40001740
> [    0.133178] imx_mmdc_probe MMDC_MAPSR: 0x00001046 << Before
> [    0.133871] imx_mmdc_probe: failed to enable automatic power saving
> [    0.133969] imx-mmdc 21b0000.mmdc: No access to interrupts, using timer.
>
> The code snippet where the debug logs are printed is as below:
> static int imx_mmdc_probe(struct platform_device *pdev)
> <snip>
>         val = readl_relaxed(reg);
>         ddr_type = (val & BM_MMDC_MDMISC_DDR_TYPE) >>
>                  BP_MMDC_MDMISC_DDR_TYPE;
>
>         printk(KERN_CRIT "%s MMDC_MDMISC: 0x%08x\n", __func__, val);
>         reg = mmdc_base + MMDC_MAPSR;
>         /* Enable automatic power saving */
>         val = readl_relaxed(reg);
>         printk(KERN_CRIT "%s MMDC_MAPSR: 0x%08x\n", __func__, val);
>         val &= ~(1 << BP_MMDC_MAPSR_PSD);
>         writel_relaxed(val, reg);
>
>         /* Ensure it's successfully enabled */
>         while (!(readl_relaxed(reg) & 1 << BP_MMDC_MAPSR_PSS) && --timeout)
>                 cpu_relax();
> <snip>
>
> Any help on the before mentioned issue will be welcomed.
>
> On Wed, Aug 17, 2016 at 8:31 AM, Zhengyu Shen <zhengyu.shen@nxp.com> wrote:
>>> The following series of patch resolve the kernel compilation errors with the
>>> proposed perf functionality integration into MMDC driver by Zhengyu Shen.
>>> These provide the working code which can be enhanced upon as per the
>>> reviews from Mark and Peter but will make sure that code compiles without
>>> errors and still retains working as was proposed by Zhengyu. I suggest further
>>> improvements from review comments could be done on top of it from
>>> further on with this being used as a base.
>>>
>>> Nitin Chaudhary (2):
>>>   Error: Fix mmdc compilation errors due to cpu notifier
>>>   [i.MX6Q] Code cleanup & verification after fixing compilation error
>>>
>>>  arch/arm/mach-imx/mmdc.c   | 95 ++++++++++++++++++++++++------------
>>> ----------
>>>  include/linux/cpuhotplug.h |  1 +
>>>  2 files changed, 50 insertions(+), 46 deletions(-)
>>>
>>> --
>>> 2.7.4
>>
>> Hi, thanks for the help. Is it impossible for two pmus to be created? I wasn't sure
>> about that, which is why I didn't have pmu_mmdc set to static.
>
>
>
> --
> Thanks & Regards
>
> Nitin Chaudhary
> Nitin Chaudhary
> MS, Electrical Engineering
> University of Southern California
> Intern, Zodiac In-flight Innovations



-- 
Thanks & Regards

Nitin Chaudhary
Nitin Chaudhary
MS, Electrical Engineering
University of Southern California
Intern, Zodiac In-flight Innovations
