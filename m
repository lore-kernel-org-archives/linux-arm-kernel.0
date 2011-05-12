From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 May 2011 22:10:36 -0700
Subject: [RFC 2/3] ARM: Tegra: Device Tree Support: Add i2c devices
In-Reply-To: <BANLkTinvDRDfdGawFBb=OE8DqG_DW7L6qQ@mail.gmail.com>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232659.10362.45811.stgit@riker>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA2C5@HQMAIL01.nvidia.com>
	<BANLkTinvDRDfdGawFBb=OE8DqG_DW7L6qQ@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AA2C9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Wednesday, May 11, 2011 10:47 PM:
> On Thu, May 12, 2011 at 6:34 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > John Bonesio wrote at Wednesday, May 11, 2011 5:27 PM:
> >> This patch initializes i2c controller devices in board-dt.c. The i2c controller
> >> is added to tegra250.dtsi so later on-board i2c devices can be found and
> >> initialized based on the device tree information.
> >>...
> >> @@ -598,6 +609,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
> >> ? ? ? i2c_dev->adapter.algo = &tegra_i2c_algo;
> >> ? ? ? i2c_dev->adapter.dev.parent = &pdev->dev;
> >> ? ? ? i2c_dev->adapter.nr = pdev->id;
> >> + ? ? i2c_dev->adapter.dev.of_node = of_node_get(pdev->dev.of_node);
> >
> > It seems like users of this of_node (i.e. the probe function) could just
> > access pdev->dev.of_node directly (since pdev is already passed in)
> > rather than storing a copy here. At least, sdhci-tegra.c works that way.
> > Still, this isn't a big deal, I think.
> 
> Actually, using of_node_get() here is the right thing since it
> increases the reference count on the of_node.  However, the patch
> should also do an of_node_put() in the remove hook, or in the .probe
> error path.

Ah OK, I was missing that the later all of of_i2c_register_devices()
uses i2c_dev->adapter.dev.of_node; I was thinking that it'd just use
i2c_dev->adapter.dev.parent->of_node directly, in which case we
wouldn't need to copy the pointer, nor increment the refcount.

So, I agree this is OK.

-- 
nvpublic
