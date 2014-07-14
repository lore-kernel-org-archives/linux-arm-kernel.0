From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 11:24:35 +0200
Subject: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <20140714091233.GC6800@sirena.org.uk>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-2-git-send-email-ttynkkynen@nvidia.com>
 <CAL1qeaFF0ZpUFovxTuLXrBPRg2Lbf-754Z=ztD5HFZPbfnDsAw@mail.gmail.com>
 <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com> <20140714083854.GO2081@ulmo>
 <20140714091233.GC6800@sirena.org.uk>
Message-ID: <20140714092434.GA9755@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 10:12:33AM +0100, Mark Brown wrote:
> On Mon, Jul 14, 2014 at 10:38:56AM +0200, Thierry Reding wrote:
> > On Fri, Jul 11, 2014 at 08:21:27PM +0300, Tuomas Tynkkynen wrote:
> 
> > > I don't think we can assume that each selector maps to a concrete register
> > > value, though I'm not sure. include/linux/regulator/driver.h documents for
> > > @list_voltage "Selectors range from zero to one less
> > > regulator_desc.n_voltages." but maybe the consumer API could take different
> > > values.
> 
> > I don't think the regulator API makes any guarantees that the selector
> > corresponds to a register value. Adding Mark Brown, maybe he can help
> > figure out the best way to do this.
> 
> The selector value is opaque, it's entirely up to the driver to define
> it.  If you could tell me what "this" is I might be able to advise on
> how to do it.

Tegra124 (and later, also some earlier variants) have this DFLL clock
that can program a PMIC automatically depending on the CPU frequency.
This DT binding did propose putting this into device tree as a table of
<frequency value> pairs where the frequency corresponds to the CPU
frequency and the value is the register value to be programmed into the
PMIC by the DFLL hardware (there are two additional properties to define
the slave address and the register offset).

Andrew proposed that this table could instead be built by using
regulator_list_voltage() instead. However, due to the fact that the DFLL
hardware needs to know the immediate value to write into a register, the
requirement would be for a 1:1 mapping between selector and register
value. Given that the API needs to cover the general case I don't see
how it could practically ensure this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/b65d67c0/attachment.sig>
