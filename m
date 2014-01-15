From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 15 Jan 2014 11:11:47 -0600
Subject: [PATCH v4 4/6] spmi: pmic_arb: add support for interrupt handling
In-Reply-To: <20140114234402.GD23276@sonymobile.com>
References: <cover.1389738151.git.joshc@codeaurora.org>
 <0f3e257f098d5f1ec6e9f09ba4dbf055291f2d83.1389738151.git.joshc@codeaurora.org>
 <20140114234402.GD23276@sonymobile.com>
Message-ID: <20140115171147.GX8153@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 03:44:03PM -0800, Courtney Cavin wrote:
> On Tue, Jan 14, 2014 at 07:41:38PM +0100, Josh Cartwright wrote:
> > The Qualcomm PMIC Arbiter, in addition to being a basic SPMI controller,
> > also implements interrupt handling for slave devices.  Note, this is
> > outside the scope of SPMI, as SPMI leaves interrupt handling completely
> > unspecified.
> > 
> > Extend the driver to provide a irq_chip implementation and chained irq
> > handling which allows for these interrupts to be used.
> > 
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > ---
> >  drivers/spmi/spmi-pmic-arb.c | 393 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 391 insertions(+), 2 deletions(-)
[..]
> > +struct spmi_pmic_arb_qpnpint_type {
> > +       u8 type; /* 1 -> edge */
> > +       u8 polarity_high;
> > +       u8 polarity_low;
> > +} __packed;
> > +
> 
> While the rest of this driver uses 'pmic' or 'spmi_pmic', this patch
> adds 'qpnpint'.  Can we please just leave the software fabricated name
> 'qpnp' out of any changes, as it isn't in any hardware spec?  Perhaps
> 'pmic_int' or something along those lines?

QPNP is not a software-created concept.  It is a hardware concept, where
it places requirements on the layout of a peripherals' register space,
and how interrupts are expected to behave, among other things.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
