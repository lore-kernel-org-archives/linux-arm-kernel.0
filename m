From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Oct 2012 12:44:54 +0100
Subject: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
In-Reply-To: <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
 <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
Message-ID: <20121001114454.GA9170@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 05:00:06PM +0530, ABRAHAM, KISHON VIJAY wrote:
> On Mon, Oct 1, 2012 at 4:31 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:

Delete irrelevant context from your replies, it makes it much easier to
find new text.

> > +static int smsc_i2c_remove(struct i2c_client *i2c)
> > +{
> > +       struct smsc *smsc = i2c_get_clientdata(i2c);
> > +
> > +       mfd_remove_devices(smsc->dev);

> IMO, this should have resulted in an abort (hint: see
> mfd_remove_devices_fn()). Trying to do mfd_remove_devices without
> mfd_add_devices(). Use device_for_each_child here to remove the
> device.

No, this is not at all sensible - if there's an mfd_remove_devices()
function we really ought to be able to use it to remove the children.
If we can't do that we should fix the API usability, not open code the
same stuff in every user.
