From: nitinchaudhary1289@gmail.com (Nitin Chaudhary)
Date: Thu, 18 Aug 2016 17:34:50 -0700
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <1471395561-30389-1-git-send-email-Nitin.Chaudhary@zii.aero>
 <DB5PR04MB1430018C7BFB14A65517162C9F140@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <CAJOu_28674HsFLo45YnG1UT-Ocoz9oMuLh1uJ60UQ3ciW+YAPA@mail.gmail.com>
 <DB5PR04MB1430DE79735EE6106190CFD99F140@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <CAJOu_289cZ8jXDcH3FB3hShyUyOUMrNJ+BCrcAevEtK+2D26xg@mail.gmail.com>
 <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
Message-ID: <CAJOu_28=a6xGXxjc_EbhqiwJSvM-wP4JO_AfGE563QhhGkcfmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhengyu,

Thanks for your valuable inputs. I reworked on the patches and moved
the busy loop to deferred workqueue and it works for my board now. I
am publishing a new set of patches with the changes. It would be nice
if you could provide your valuable review.

On Thu, Aug 18, 2016 at 2:34 PM, Zhengyu Shen <zhengyu.shen@nxp.com> wrote:
> I believe you are correct on the bit[4]. I'm not the original creator of the driver,
> but from what I can tell, the MMDC should report that it is in power saving mode
> very quickly, if not immediately after the bit is written. I tested the value of timeout
> after a couple of a boots and it never goes under 1015 (0x3F7) for me.
>
>> -----Original Message-----
>> From: Nitin Chaudhary [mailto:nitinchaudhary1289 at gmail.com]
>> Sent: Thursday, August 18, 2016 3:17 PM
>> To: Zhengyu Shen <zhengyu.shen@nxp.com>
>> Subject: Re: Re:[PATCH v2] Added perf functionality to mmdc driver
>>
>> Hi Zhengyu,
>>
>> Thanks for reply. I was wondering if the Power saving status bit
>> [MMDC0_MAPSR bit[4]] shows whether the MMDC is in power saving mode
>> or not? Also in the driver, exiting if we don't find MMDC in the power saving
>> mode immediately after enabling the automatic power saving mode within
>> the timeout period, is ok? Is it possible it will go into power saving mode after
>> enabling the automatic power saving mode once the DRAM access requests
>> calm down after the device has finished booting and went to a stable/idle
>> state?
>>
>> On Wed, Aug 17, 2016 at 11:09 AM, Zhengyu Shen
>> <zhengyu.shen@nxp.com> wrote:
>> >> Hi Zhengyu,
>> >>
>> >> There are two main reasons why I made pmu_mmdc to be static:
>> >> 1. Since i.MX6Q has only a single MMDC IP, at any time there should
>> >> be only 1 instance of the same.
>> >> 2. Now as the code plugs itself into the perf core, it is very
>> >> unlikely we need to allow access to this  data structure from outside
>> >> the driver code. If we need to do for some reasons in kernel in the
>> >> future then  we can expose some wrapper APIs to achieve that in a
>> safeway.
>> >
>> > I was told that there is a possibility of having more than one MMDC on
>> > a Board and thus pmu_mmdc must not be static. I'll have to verify this
>> > in more detail though.
>> >
>> >> Also, I have a few questions regarding MMDC initialization.
>> >> 1. Is there any specific hardware initialization reason that we do a
>> >> busy loop while trying to enable Automatic
>> >>     power saving mode. Is it possible to move it to deferred workqueue?
>> >> 2. I am having an issue with the MMDC driver running Linux Kernel
>> >> 4.8-rc2 and its unable to successfully
>> >>     probe due to timeout waiting for MMDC automatic wait getting
>> enabled.
>> >> The below is the log message
>> >>     along with the debug messages I added to dump the read values for
>> >> MDMIC and MAPSR reg in MMDC
>> >>    connected to singel channel DDR3.
>> >> [    0.133162] imx_mmdc_probe MMDC_MDMISC: 0x40001740
>> >> [    0.133178] imx_mmdc_probe MMDC_MAPSR: 0x00001046 << Before
>> >> [    0.133871] imx_mmdc_probe: failed to enable automatic power saving
>> >> [    0.133969] imx-mmdc 21b0000.mmdc: No access to interrupts, using
>> timer.
>> >>
>> >> The code snippet where the debug logs are printed is as below:
>> >> static int imx_mmdc_probe(struct platform_device *pdev) <snip>
>> >>         val = readl_relaxed(reg);
>> >>         ddr_type = (val & BM_MMDC_MDMISC_DDR_TYPE) >>
>> >>                  BP_MMDC_MDMISC_DDR_TYPE;
>> >>
>> >>         printk(KERN_CRIT "%s MMDC_MDMISC: 0x%08x\n", __func__, val);
>> >>         reg = mmdc_base + MMDC_MAPSR;
>> >>         /* Enable automatic power saving */
>> >>         val = readl_relaxed(reg);
>> >>         printk(KERN_CRIT "%s MMDC_MAPSR: 0x%08x\n", __func__, val);
>> >>         val &= ~(1 << BP_MMDC_MAPSR_PSD);
>> >>         writel_relaxed(val, reg);
>> >>
>> >>         /* Ensure it's successfully enabled */
>> >>         while (!(readl_relaxed(reg) & 1 << BP_MMDC_MAPSR_PSS) && --
>> >> timeout)
>> >>                 cpu_relax();
>> >> <snip>
>> >>
>> >> Any help on the before mentioned issue will be welcomed.
>> > I'll look into it. I can't reproduce the bug with the (slightly older) kernel
>> version I'm using.
>>
>>
>>
>> --
>> Thanks & Regards
>>
>> Nitin Chaudhary
>> MS, Electrical Engineering
>> University of Southern California
>> Intern, Zodiac In-flight Innovations



-- 
Thanks & Regards

Nitin Chaudhary
MS, Electrical Engineering
University of Southern California
Intern, Zodiac In-flight Innovations
