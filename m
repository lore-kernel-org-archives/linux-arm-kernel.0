From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Mon, 15 Oct 2012 15:51:53 +0000
Subject: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to
 use common clk drivers
In-Reply-To: <5077F466.6020707@ti.com>
References: <1348683037-9705-1-git-send-email-m-karicheri2@ti.com>
 <1348683037-9705-10-git-send-email-m-karicheri2@ti.com>
 <5076BAA2.6010404@ti.com>
 <3E54258959B69E4282D79E01AB1F32B7041FDB5B@DFLE12.ent.ti.com>
 <5077F466.6020707@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B704201DE5@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--Cut----

>> Subject: Re: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to use
>> common clk drivers
>> 
>> >>> You have chosen to keep all clock related data in platform files
>> >>> while using the common clock framework to provide just the
>> >>> infrastructure. If you look at how mxs and spear have been migrated, they have
>> migrated the soc specific clock data to drivers/clk as well.
>> >>> See "drivers/clk/spear/spear3xx_clock.c" or
>> >>> "drivers/clk/mxs/clk-imx23.c
>> >
>> > I have to disagree on this one. I had investigated these code already
>> > and came up with a way that we can re-use code across all of the
>> > davinci platforms as well as other architectures that re-uses the clk hardware IPs.
>> 
>> Which code you are talking about here? Even if you introduce clk-dm644x.c, clk-
>> keystone.c etc in drivers/clk/davinci/ you can reuse the code you introduce in patches 1-
>> 3. I cant see how that will be prevented.

I was talking about re-use of davinci_common_clk_init in drivers/clk/davinci/davinci-clock.c.
This is meant to be re-used across all of the DaVinci devices.

>> 
>> > spear3xx_clock.c has initialization code for each of the platforms and
>> > so is the case with imx23.c.
>> 
>> By each of the platforms, you mean they all cater to a family of devices? This depends on
>> how close together the family of devices are.
>> Otherwise, there would be a file per soc. DM644x also represents a family for that matter.
>> 
>> > By using platform_data approach, we are able to define clks for each of the SoC and
>> then use davinci_common_clk_init() to do initialize the clk drivers based on platform
>> data.
>> 
>> You need to define and register the clocks present on each SoC either which way. I don't
>> see why just the platform_data approach allows this.
>> And looking closely, you have defined platform data, but don't actually have a platform
>> device, making things more confusing.
>> 

Ok. There are multiple ways to implement this software. We had discussed this
internally and picked the platform_data approach. The clk drivers are written not
following the platform driver model. But I don't see why we can't use platform data
to configure this drivers. Down below, you have made two interesting points, one is
ARM code reduction. This patch already does this by moving the API that initializes
the clk drivers (davinci_common_clk_init()) out of ARM to drivers/clk/davinci. So
this + removal of existing clk driver under arm/mach-davinci/clock.[ch], we have
achieved this goal. The second point is the moving of SoC specific clk data out of SoC
code to drive. Are you 100% sure this is the right thing to do for these drivers. If so,
I can start working on this change right away. As I am working on this as a background
activity, I want to be double or triple sure before doing the rework of these patches :).
So please confirm.

>> > Later once we migrate to device tree, davinci_common_clk_init() will
>> > go way and also the clk structures defined in the SoC file. I have prototyped this on
>> one of the device that I am working on. davinci_common_clk_init() will be replaced with a
>> of_davinci_clk_init() that will use device tree to get all of the platform data for the clk
>> providers and do the initialization based on that. See highbank_clocks_init() in clk-
>> highbank.c. I have used this model for device tree based clk initialization.
>> 
>> I don't think we should wait till DT migration to get rid of clock data from platform code.
>> For many of the older DaVinci platforms, DT migration is a big if and when. This approach
>> you gave above might work for newer DT-only platforms, but even if there is one board
>> that is not migrated to DT, the entire clock data will have to stay. I have very less hope
>> this will happen for DaVinci (at least in the near term). So, I would rather take the
>> opportunity of common clock tree migration to move clock data out of mach-davinci.
>> 
>> Also, just moving soc-specific clk data to drivers/clk/davinci/* does not impede a future
>> DT conversion, no?
>> 
>> > So it make sense to keep the design the way it is. Otherwise we will
>> > end up writing dm644x_clk_init(), dm355_clk_init(), etc for each of the platforms and
>> these code will get thrown away once we migrate to device tree.
>> 
>> I still don't see why davinci/keystone cannot follow the same approach taken by multiple
>> other socs - spear, mxs and ux500. I am unconvinced that we have a significantly
>> different case.
>> 
>> >>> ". I feel the
>> >>> latter way is better and I also think it will simplify some of the
>> >>> look-up infrastructure you had to build. This will also help some real code reduction
>> from arch/arm/mach-davinci/.
>> >>>
>> >
>> > The look-up infrastructure is pretty much re-use of the existing code base in SoC
>> specific file.
>> 
>> Yes, but that's no reason to keep maintaining it.
>> 
>> > About code reduction, I can't say I agree, as we need to add platform_specific clock
>> initialization code if we follow spear3xx_clock.c model and end up probably adding more
>> code.
>> > SoC specific file (for example dm644x.c) has only data structures and all of SoC will re-
>> use davinci_common_clk_init() to do the initialization. So I am not sure how you conclude
>> we will have code reduction?
>> 
>> Is about code reduction from arch/arm/. That's what ARM community is working towards.
>> 
>> Thanks,
>> Sekhar
>> 
>> PS: When replying, can you please hit an enter after every 70 or so characters.
>> Otherwise quoting from your mails is becoming very difficult. I tried manually adjusting it
>> but finally gave up.
