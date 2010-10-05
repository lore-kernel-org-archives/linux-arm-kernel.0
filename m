From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 Oct 2010 16:09:47 +0900
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver for
	S/PDIF PCM audio
In-Reply-To: <20101005055937.GA19989@opensource.wolfsonmicro.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
	<20101005055937.GA19989@opensource.wolfsonmicro.com>
Message-ID: <AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 2:59 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 05, 2010 at 02:39:00PM +0900, Jassi Brar wrote:
>
>> Yes we can have a kconfig entry for 'Controllable EPLL' but that seems
>> orthogonal to ASoC because, for SMDKs, we choose to produce
>> accurate signals hence need to manipulate EPLL. The only point is
>> where to do it.
>
> Well, there's two approaches the driver can take: one is to change the
> EPLL to deliver the clock rates which allow maximum flexibility, the
> other is to constrain the clock rates offered to applications based on
> the frequencies that can be generated from the current EPLL setup.
For SMDKs(our reference platform) I would like to change EPLL in order
to be able to verify accuracy and provide all capabilities of the controllers.
For a final product, it would make sense to fix the EPLL to one optimal value
according to the type of h/w and s/w components(ex PA can be configured
to 48KHz after making sure EPLL can also be used to generate suitable
clocks for the SPI devices on board)

>> (our priority is accuracy of each IP's functioning rather than having
>> all parts of
>> SMDK playing nice with each other on such h/w design issues)
>
> That'd be the problem, kind of - it does mean people can get burned when
> they pick up the BSP code and use it as a reference for their systems.
I expect people to replace/modify/inspect board specific code before they
run the BSP on their systems. IMO reference platforms are not good for
integrated-testing.
Meanwhile, we should make sure the SoC specific stuff supports and is
tested with
as many configurations as are possible on SMDKs.

>> I hope you noticed that this clock hierarchy is a _very_ board specific thing.
>> We can easily place SoCs' shared stuff in arch/arm/plat-samsung (or similar)
>> Any suggestions, where do we place code shared by SMDK-boards ?
>
> plat-samsung would probably be fine for that also - create a file called
> common-smdk or something. ?Some other things have gone for a plat-smdk
> style approach too, though I'm not sure how tasteful I find that
> personally.
Even though I would personally like to have EPLL control for a device
in machine specific manner as part of its driver, I accept your opinion.

Claude, let us create one arch/arm/plat-samsung/smdk.c to do common
stuff for SMKDs like EPLL control. What do you think ?


Thanks.
