From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 7 Nov 2013 10:12:12 +0100
Subject: [PATCH v7] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <CAHCPf3v3dsTyk9Cd93GBLBKQLSQ+Mb0mpq134X7Ko4U8m-b-qg@mail.gmail.com>
References: <1382950843-26066-3-git-send-email-mpa@pengutronix.de>
 <1383057139-25304-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdYKgA5E4-APSTHsM=zVbb3X2R4v+V4EeK3+W1tKPR1FeA@mail.gmail.com>
 <CAHCPf3v3dsTyk9Cd93GBLBKQLSQ+Mb0mpq134X7Ko4U8m-b-qg@mail.gmail.com>
Message-ID: <20131107091212.GH15098@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:54:02AM -0600, Matt Sealey wrote:
> On Tue, Oct 29, 2013 at 11:00 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > On Tue, Oct 29, 2013 at 7:32 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> >
> >> imx27 pincontrol driver using the imx1 core driver. The DT bindings are
> >> similar to other imx pincontrol drivers.
> >>
> >> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> >> ---
> >> Hi,
> >>
> >> another binding documentation update. The MUX_ID components are described more
> >> detailed now.
> >
> > Patch tentatively applied unless someone has very fundamental
> > issues with it, it stays in. I really want a full transfer of i.MX
> > pin controllers to the subsystem, using device tree so we can
> > get rid of the old i.MX cruft in arch/arm.
> 
> I think this is a rush-in patch. I actually read the manual last night
> and found some serious weirdness.
> 
> The i.MX27 doesn't have a dedicated IOMUX controller so actually
> having a whole separate node for it in the device tree - or even a
> separate driver - makes very little sense. I understand pinctrl and
> gpiolib are somewhat separated as software, but this is encoding a
> Linuxism into the tree.
> 
> In fact, the binding will conflict with actual binding of the GPIO
> (i.e. setting data, receiving interrupts) module since it's all one
> register set, and the "fsl,imx27-iomuxc" compatible property does not
> represent reality except to collect data in a different spot. There's
> no reason for it except to cut the documentation and tree definition
> in half, and have two nodes for Linux.

Yes this is potentially conflicting. But in reality the used registers
are not the same. The GPIO driver uses GPIO Data Register, Data
Direction register and some interrupt registers. IOMUX is using input
configuration, output configuration, GPIO in use and data direction
registers. So it is conflicting in exactly one register that is
controlling the data direction.

> 
> Would it be so bad to implement this as a regmap and have two drivers
> access the same regmap on the Linux side? You don't need two nodes for
> that, and the IOMUX definitions can live under the GPIO node. There is
> NOTHING stopping two drivers on Linux matching the same compatible
> property. Locking and coordination in software of a single IP block
> used by two drivers shouldn't be arbitrated by the device tree.

I am not sure if it is practical to use the GPIO nodes for the IOMUX
driver. There are actually 6 GPIO nodes. This would lead to 6
iomux controllers? The different pin functions may be distributed over
different controllers then.

The first version of this series [1] was designed to have a iomux node
with 6 gpio subnodes.

Regards,

Markus


[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/257180/focus=257184

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
