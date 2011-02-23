From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 23 Feb 2011 13:53:27 -0700
Subject: [PATCH 4/6] ARM: tegra: harmony: register sdhci devices
In-Reply-To: <AANLkTi=mjR6dnxcTxYzTvJK4DgEW7mO+p4TUeu6kq6fn@mail.gmail.com>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-5-git-send-email-olof@lixom.net>
	<4D635EC4.2030102@compulab.co.il>
	<AANLkTi=mjR6dnxcTxYzTvJK4DgEW7mO+p4TUeu6kq6fn@mail.gmail.com>
Message-ID: <20110223205327.GV14597@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 07:44:58AM -0800, Olof Johansson wrote:
> On Mon, Feb 21, 2011 at 10:59 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> > Hi Olof,
> > Sorry for jumping late, haven't thought about the proposal below yesterday.
> > I'm not objecting to applying the patch as is, we can refactor the code
> > afterwards as well.
> 
> Thanks for the input. And yeah, I'd say we can refactor later when we
> see how things will fit well with flat devicetrees. More below.
> 
> 
> >> ?static void __init tegra_harmony_init(void)
> >> ?{
> >> ? ? ? tegra_common_init();
> >> @@ -85,6 +111,10 @@ static void __init tegra_harmony_init(void)
> >>
> >> ? ? ? harmony_pinmux_init();
> >>
> >> + ? ? tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
> >> + ? ? tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
> >> + ? ? tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
> >> +
> >
> > I think that instead of copying explicit initialization of the platform_data
> > member from board to board we can do something similar to what PXA does. The
> > board file would have to call something like
> > tegra_set_device_X_info(struct tegra_device_X_platform_data *data);
> > and then static registration of platform devices in the board files can be dropped.
> >
> > For instance, the devices.c would have
> >
> > void __init tegra_register_device(struct platform_device *dev, void *data)
> > {
> > ? ? ? ?int ret;
> >
> > ? ? ? ?dev->dev.platform_data = data;
> >
> > ? ? ? ?ret = platform_device_register(dev);
> > ? ? ? ?if (ret)
> > ? ? ? ? ? ? ? ?dev_err(&dev->dev, "unable to register device: %d\n", ret);
> > }
> >
> > void __init tegra_set_sdhci1_info(struct tegra_sdhci_platform_data *info)
> > {
> > ? ? ? ?tegra_register_device(&tegra_sdhci_device1, info);
> > }
> >
> > and the board files would just call tegra_set_sdhci1_info to pass the platform
> > data for the tegra_sdhci_device1 and register the device.
> >
> > This way we could reduce amount of copy/paste between the board files. Besides,
> > if/when tegra will be using device trees, handling of the device registration in
> > common place would make the transition easier.
> 
> I don't see how that reduces the amount of copy and paste
> (significantly), since you still need the platform_data defined per
> board so you'll need to add the calls there. Maybe a generic
> "set_platform_data" hook instead of doing the pointer assignment
> open-coded would be an improvement though.

Option 3 is to use a bus notifier to attach additional platform data
when the device gets registered.  That is turning out to be the
cleanest solution when it comes to getting additional pdata to a
device that is pulled out of the dt, and this sounds like a similar
situation.

> 
> I'm personally not a fan of the style where data is described as code,
> i.e. where there would be a tegra_set_<dev>_info function for every
> possible device out there. If anything that adds to the amount of
> copy-and-paste (per device), when it could just be handled with one
> common function being passed the appropriate data (i.e. like
> tegra_register_device).

+1

> 
> Anyway, I'm not looking to argue over it. :) I think we'll see when
> the FDT pieces start to take shape what kind of model will work well,
> and there's no reason to do premature refactoring.
> 
> 
> -Olof
