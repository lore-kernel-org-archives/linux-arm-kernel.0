From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 11 Oct 2012 14:58:26 +0000
Subject: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to
 use common clk drivers
In-Reply-To: <5076BAA2.6010404@ti.com>
References: <1348683037-9705-1-git-send-email-m-karicheri2@ti.com>
 <1348683037-9705-10-git-send-email-m-karicheri2@ti.com>
 <5076BAA2.6010404@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041FDB5B@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Thursday, October 11, 2012 8:25 AM
>> To: Karicheri, Muralidharan
>> Cc: mturquette at linaro.org; arnd at arndb.de; akpm at linux-foundation.org;
>> shawn.guo at linaro.org; rob.herring at calxeda.com; linus.walleij at linaro.org;
>> viresh.linux at gmail.com; linux-kernel at vger.kernel.org; Hilman, Kevin;
>> linux at arm.linux.org.uk; davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>> kernel at lists.infradead.org; linux-keystone at list.ti.com - Linux developers for Keystone
>> family of devices (May contain non-TIers); linux-c6x-dev at linux-c6x.org; Chemparathy,
>> Cyril
>> Subject: Re: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to use
>> common clk drivers
>> 
>> Murali,
>> 
>> On 9/26/2012 11:40 PM, Murali Karicheri wrote:
>> > The clock tree for dm644x is defined using the new structure davinci_clk.
>> > The SoC specific code re-uses clk-fixed-rate, clk-divider and clk-mux
>> > drivers in addition to the davinci specific clk drivers,
>> > clk-davinci-pll and clk-davinci-psc. Macros are defined to define the
>> > various clocks in the SoC.
>> >
>> > Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> 
>> You have chosen to keep all clock related data in platform files while using the common
>> clock framework to provide just the infrastructure. If you look at how mxs and spear
>> have been migrated, they have migrated the soc specific clock data to drivers/clk as well.
>> See "drivers/clk/spear/spear3xx_clock.c" or "drivers/clk/mxs/clk-imx23.c 

I have to disagree on this one. I had investigated these code already and came up with a way that we can re-use code across all of the davinci platforms as well as other architectures that re-uses the clk hardware IPs. spear3xx_clock.c has initialization code for each of the platforms and so is the case with imx23.c. By using platform_data approach, we are able to define clks for each of the SoC and then use davinci_common_clk_init() to do initialize the clk drivers based on platform data. Later once we migrate to device tree, davinci_common_clk_init() will go way and also the clk structures defined in the SoC file. I have prototyped this on one of the device that I am working on. davinci_common_clk_init() will be replaced with a of_davinci_clk_init() that will use device tree to get all of the platform data for the clk providers and do the initialization based on that. See highbank_clocks_init() in clk-highbank.c. I have used this model for device
tree based clk initialization.

So it make sense to keep the design the way it is. Otherwise we will end up writing dm644x_clk_init(), dm355_clk_init(), etc for each of the platforms and these code will get thrown away once we migrate to
device tree. 

>>". I feel the
>> latter way is better and I also think it will simplify some of the look-up infrastructure you
>> had to build. This will also help some real code reduction from arch/arm/mach-davinci/.
>>

The look-up infrastructure is pretty much re-use of the existing code base in SoC specific file. About code reduction, I can't say I agree, as we need to add platform_specific clock initialization code if we follow spear3xx_clock.c model and end up probably adding more code. SoC specific file (for example dm644x.c) has only data structures and all of SoC will re-use davinci_common_clk_init() to do the initialization. So I am not sure how you conclude we will have code reduction?

- Murali

>> Thanks,
>> Sekhar
