From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Oct 2012 11:21:21 +0530
Subject: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to
 use common clk drivers
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704201DE5@DFLE12.ent.ti.com>
References: <1348683037-9705-1-git-send-email-m-karicheri2@ti.com>
 <1348683037-9705-10-git-send-email-m-karicheri2@ti.com>
 <5076BAA2.6010404@ti.com>
 <3E54258959B69E4282D79E01AB1F32B7041FDB5B@DFLE12.ent.ti.com>
 <5077F466.6020707@ti.com>
 <3E54258959B69E4282D79E01AB1F32B704201DE5@DFLE12.ent.ti.com>
Message-ID: <507CF5D9.2050605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

On 10/15/2012 9:21 PM, Karicheri, Muralidharan wrote:
> --Cut----
> 
>>> Subject: Re: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to use
>>> common clk drivers
>>>
>>>>>> You have chosen to keep all clock related data in platform files
>>>>>> while using the common clock framework to provide just the
>>>>>> infrastructure. If you look at how mxs and spear have been migrated, they have
>>> migrated the soc specific clock data to drivers/clk as well.
>>>>>> See "drivers/clk/spear/spear3xx_clock.c" or
>>>>>> "drivers/clk/mxs/clk-imx23.c
>>>>
>>>> I have to disagree on this one. I had investigated these code already
>>>> and came up with a way that we can re-use code across all of the
>>>> davinci platforms as well as other architectures that re-uses the clk hardware IPs.
>>>
>>> Which code you are talking about here? Even if you introduce clk-dm644x.c, clk-
>>> keystone.c etc in drivers/clk/davinci/ you can reuse the code you introduce in patches 1-
>>> 3. I cant see how that will be prevented.
> 
> I was talking about re-use of davinci_common_clk_init in drivers/clk/davinci/davinci-clock.c.
> This is meant to be re-used across all of the DaVinci devices.
> 
>>>
>>>> spear3xx_clock.c has initialization code for each of the platforms and
>>>> so is the case with imx23.c.
>>>
>>> By each of the platforms, you mean they all cater to a family of devices? This depends on
>>> how close together the family of devices are.
>>> Otherwise, there would be a file per soc. DM644x also represents a family for that matter.
>>>
>>>> By using platform_data approach, we are able to define clks for each of the SoC and
>>> then use davinci_common_clk_init() to do initialize the clk drivers based on platform
>>> data.
>>>
>>> You need to define and register the clocks present on each SoC either which way. I don't
>>> see why just the platform_data approach allows this.
>>> And looking closely, you have defined platform data, but don't actually have a platform
>>> device, making things more confusing.
>>>
> 
> Ok. There are multiple ways to implement this software. We had discussed this
> internally and picked the platform_data approach. The clk drivers are written not
> following the platform driver model. But I don't see why we can't use platform data
> to configure this drivers. Down below, you have made two interesting points, one is
> ARM code reduction. This patch already does this by moving the API that initializes
> the clk drivers (davinci_common_clk_init()) out of ARM to drivers/clk/davinci. So
> this + removal of existing clk driver under arm/mach-davinci/clock.[ch], we have
> achieved this goal. The second point is the moving of SoC specific clk data out of SoC
> code to drive. Are you 100% sure this is the right thing to do for these drivers. If so,
> I can start working on this change right away. As I am working on this as a background
> activity, I want to be double or triple sure before doing the rework of these patches :).
> So please confirm.

Yes, this is the right way to go. And I don't see it as something
breaking new ground since there are already multiple SoCs in mainline
which are following this same approach. May be to start with just
convert one SoC and send for review.

Thanks for taking this up and helping clean-up mach-davinci.

Regards,
Sekhar
