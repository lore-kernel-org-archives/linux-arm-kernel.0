From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Sep 2013 11:00:24 +0200
Subject: [PATCH 00/10] pwm-backlight: Add GPIO and power supply support
In-Reply-To: <20130924081446.GA11981@verge.net.au>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <20130924081446.GA11981@verge.net.au>
Message-ID: <20130924090023.GA13971@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 05:14:46PM +0900, Simon Horman wrote:
> [ Cc: Olof Johansson, Kevin Hilman and Arnd Bergman: arm-soc maintainers ]
> 
> On Mon, Sep 23, 2013 at 11:40:57PM +0200, Thierry Reding wrote:
> > This series adds the ability to specify a GPIO and a power supply to
> > enable a backlight.
> > 
> > Patch 1 refactors the power on and power off sequences into separate
> > functions in preparation for subsequent patches.
> > 
> > Patch 2 adds an optional GPIO to enable a backlight. This patch only
> > includes the field within the platform data so that it can be properly
> > setup before actually being put to use.
> > 
> > Patches 3 to 7 convert all users of the pwm-backlight driver to use the
> > new field. For most of them, this just initializes the field to -1,
> > marking the field as unused.
> >
> > Patch 8 uses the new field within the pwm-backlight driver and at the
> > same time allows it to be parsed from device tree.
> > 
> > Patch 9 implements support for an optional power supply. This relies on
> > the regulator core to return a dummy regulator when no supply has been
> > otherwise setup so the driver doesn't have to handle that specially nor
> > require all users to be updated.
> > 
> > Patch 10 adds a way to keep a backlight turned off at boot. This is
> > useful when hooking up a backlight with a subsystem such as DRM which
> > has more explicit semantics as to when a backlight should be turned on.
> > 
> > Due to the dependencies within the series, I propose to take all these
> > patches through the PWM tree, so I'll need acks from OMAP, PXA, Samsung,
> > shmobile and Unicore32 maintainers.
> 
> I received some feedback regarding shmobile conflicts when
> arm-soc was merged between v3.11 and v3.12-rc1. With this
> in mind I now have a strong preference for changes inside
> arch/arm/mach-shmobile/ to be taken through my renesas
> tree and thus more importantly through arm-soc if possible.

I understand. Unfortunately the nature of patche series such as this is
that they require the whole series to be applied atomically (or at least
in a very specific order). So the patch that uses the new enable_gpio
field can only be applied after all previous patches. The only
reasonable way to ensure that is to take all of the patches through one
tree. Furthermore this patch is tiny (it adds a single line) and touches
code that's unlikely to be modified by anyone else.

But if it makes you more comfortable, I could provide a stable branch
that contains this series for you to merge into the shmobile tree. That
should enable you to handle all conflict resolution prior to submitting
to arm-soc.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/7b1d7aee/attachment.sig>
