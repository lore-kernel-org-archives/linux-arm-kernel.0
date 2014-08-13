From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 Aug 2014 10:01:39 +0200
Subject: [PATCH 1/3] of: Add descriptions of thermtrip properties to
 Tegra PMC bindings
In-Reply-To: <53EB18E6.3070203@nvidia.com>
References: <1407226380-747-1-git-send-email-mperttunen@nvidia.com>
 <1407226380-747-2-git-send-email-mperttunen@nvidia.com>
 <20140813073541.GA17466@ulmo> <53EB18E6.3070203@nvidia.com>
Message-ID: <20140813080138.GB7735@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 10:51:02AM +0300, Mikko Perttunen wrote:
> On 13/08/14 10:35, Thierry Reding wrote:
> >On Tue, Aug 05, 2014 at 11:12:58AM +0300, Mikko Perttunen wrote:
[...]
> >>+Required properties for hardware-triggered thermal reset:
> >>+    (only tegra30, tegra114, tegra124)
> >>+- nvidia,thermtrip-pmu-i2c-addr : I2C address of the power management unit.
> >>+- nvidia,thermtrip-i2c-controller : Index of the I2C controller the PMU is
> >>+                                    attached to.
> >
> >This duplicates information already associated with the PMU device. Can
> >this be turned into something like:
> >
> >	nvidia,thermtrip-pmu: phandle to Power Management Unit
> >
> >Then we can query the relevant information from the I2C client resolved
> >from the phandle.
> 
> True, that would look nicer.
> 
> >
> >One problem with that might be that the I2C controller index may not
> >match the hardware ID.
> 
> Maybe we could resort to checking the controller address in this case. This
> is a safety feature, so programming the wrong controller index accidentally
> would be bad.

What we've done in the past (for the display controllers) is to add a
special property that has the "hardware index" of the controller. I
think in this case it would be appropriate to add one as well. That way
we could reach into the I2C adapter of the I2C client and parse it from
the associated device tree node (client->adapter->dev.of_node).

> >>+- nvidia,thermtrip-reg-addr : Address (byte) to send reset command to.
> >>+- nvidia,thermtrip-reg-data : Data (byte) to use as reset command.
> >>+
> >>+Optional properties for hardware-triggered thermal reset:
> >>+    (only tegra30, tegra114, tegra124)
> >>+- nvidia,thermtrip-pinmux : Pinmux ID used for I2C access.
> >
> >I suppose this takes a phandle? If so the description should probably
> >say so.
> 
> No, it takes a pinmux ID, described in the boot process (non-public in T124
> I guess..) section of the TRM. It seems, though, that all platforms
> supported by the downstream kernel have pinmux == 0.

Ugh... we'll need to get this documented publicly.

> >What exactly does "16-bit operations" mean? And isn't this a property of
> >the I2C device, therefore could be queried from the I2C slave via the
> >phandle?
> 
> That's how it's described in the TRM, but I just found a comment in the
> downstream kernel about it. Apparently it controls the amount of data sent
> to the PMIC. The downstream kernel says, though, that the option is not
> supported and must always be left as zero, so I guess it could be dropped.

Indeed. If ever it becomes necessary we can add it then (and fall back
to 8-bit "operations" if it's not present).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/c055f530/attachment.sig>
