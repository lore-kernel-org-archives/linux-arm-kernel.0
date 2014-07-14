From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 11:22:03 +0100
Subject: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <20140714092434.GA9755@ulmo>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-2-git-send-email-ttynkkynen@nvidia.com>
 <CAL1qeaFF0ZpUFovxTuLXrBPRg2Lbf-754Z=ztD5HFZPbfnDsAw@mail.gmail.com>
 <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com> <20140714083854.GO2081@ulmo>
 <20140714091233.GC6800@sirena.org.uk> <20140714092434.GA9755@ulmo>
Message-ID: <20140714102203.GD6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 11:24:35AM +0200, Thierry Reding wrote:
> On Mon, Jul 14, 2014 at 10:12:33AM +0100, Mark Brown wrote:

> > The selector value is opaque, it's entirely up to the driver to define
> > it.  If you could tell me what "this" is I might be able to advise on
> > how to do it.

> Tegra124 (and later, also some earlier variants) have this DFLL clock
> that can program a PMIC automatically depending on the CPU frequency.
> This DT binding did propose putting this into device tree as a table of
> <frequency value> pairs where the frequency corresponds to the CPU
> frequency and the value is the register value to be programmed into the
> PMIC by the DFLL hardware (there are two additional properties to define
> the slave address and the register offset).

> Andrew proposed that this table could instead be built by using
> regulator_list_voltage() instead. However, due to the fact that the DFLL
> hardware needs to know the immediate value to write into a register, the
> requirement would be for a 1:1 mapping between selector and register
> value. Given that the API needs to cover the general case I don't see
> how it could practically ensure this.

Well, if you're going to do that you've already created a private API
between the regulator driver and the device since you're assuming that
the device is controlled only by register writes to a single register
bitfield which isn't always the case.

As with all these things it would also be better to extend the regulator
API so that users like this can discover the register address and so on
too rather than having to replicate that information in the device tree.
No sense in having to specify this information multiple times.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/8de78aaf/attachment.sig>
