From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 24 Feb 2014 21:50:58 +0100
Subject: [PATCH v3 0/2] regulator: core: Fix ops->enable/disable usage
In-Reply-To: <CAOMZO5BPvCcx_f09Khuw8MVxrR18fnv9e1xeuJ0c_8G22AR53g@mail.gmail.com>
References: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
 <20140223051209.GK25940@sirena.org.uk>
 <CAOMZO5BPvCcx_f09Khuw8MVxrR18fnv9e1xeuJ0c_8G22AR53g@mail.gmail.com>
Message-ID: <20140224205058.GA18317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Feb 24, 2014 at 02:23:50PM -0300, Fabio Estevam wrote:
> On Sun, Feb 23, 2014 at 2:12 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Feb 20, 2014 at 05:36:02PM +0100, Markus Pargmann wrote:
> >> Hi,
> >>
> >> These two patches replace all ops->enable/disable by
> >> _regulator_do_disable/enable function calls. These wrappers also handle gpio
> >> regulators.
> >
> > Applied both, thanks.
> 
> With these two patches applied I get the following error on
> mx6qsabresd running today's linux-next:
> 
> vdd1p1: failed to enable
> anatop_regulator regulator-1p1.2: failed to register vdd1p1
> anatop_regulator: probe of regulator-1p1.2 failed with error -22
> vdd3p0: failed to enable
> anatop_regulator regulator-3p0.3: failed to register vdd3p0
> anatop_regulator: probe of regulator-3p0.3 failed with error -22
> vdd2p5: failed to enable
> anatop_regulator regulator-2p5.4: failed to register vdd2p5
> anatop_regulator: probe of regulator-2p5.4 failed with error -22
> vddarm: 725 <--> 1450 mV at 1100 mV
> vddpu: 725 <--> 1450 mV at 1100 mV
> vddsoc: 725 <--> 1450 mV at 1175 mV
> ....
> 
> pfuze100-regulator 1-0008: Full layer: 1, Metal layer: 0
> pfuze100-regulator 1-0008: FAB: 0, FIN: 0
> SW1AB: failed to enable
> pfuze100-regulator 1-0008: register regulatorSW1AB failed
> pfuze100-regulator: probe of 1-0008 failed with error -22
> 
> 
> Reverting these two patches the regulators probe successfully.
> 
> Any ideas?

Thanks, I just searched for the reason and found it. My patches do not
handle dummy regulators correctly:

_regulator_do_enable() line 1764:
        if (rdev->ena_pin) {
                ret = regulator_ena_gpio_ctrl(rdev, true);
                if (ret < 0)
                        return ret;
                rdev->ena_gpio_state = 1;
        } else if (rdev->desc->ops->enable) {
                ret = rdev->desc->ops->enable(rdev);
                if (ret < 0)
                        return ret;
        } else {
                return -EINVAL;
        }

The only situation where this returns -EINVAL is a dummy regulator that
is not always_on. As it doesn't make sense to have a dummy regulator
that is not always_on, I will add a check for exactly this situation to
the regulator_register function and drop the "return -EINVAL" above.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/22a14332/attachment.sig>
