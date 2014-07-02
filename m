From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 16:34:18 +0100
Subject: drm/i2c: tda998x: Set CEC I2C address from TDA I2C address
In-Reply-To: <53B3E2E4.20209@arm.com>
References: <53B3D1F8.7080106@arm.com>
 <20140702102513.GF32514@n2100.arm.linux.org.uk> <53B3E2E4.20209@arm.com>
Message-ID: <20140702153418.GM32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:45:56AM +0100, Andrew Jackson wrote:
> On 07/02/14 11:25, Russell King - ARM Linux wrote:
> > You missed me as the maintainer of the driver:
> 
> Sorry, an over-sight on my part.
> 
> > NXP TDA998X DRM DRIVER
> > M:      Russell King <rmk+kernel@arm.linux.org.uk>
> > S:      Supported
> > F:      drivers/gpu/drm/i2c/tda998x_drv.c
> > F:      include/drm/i2c/tda998x.h
> >
> > On Wed, Jul 02, 2014 at 10:33:44AM +0100, Andrew Jackson wrote:
> >> @@ -1274,9 +1275,9 @@ tda998x_encoder_init(struct i2c_client *client,
> >>
> >>         priv->current_page = 0xff;
> >>         priv->hdmi = client;
> >> -       priv->cec = i2c_new_dummy(client->adapter, 0x34);
> >> -       if (!priv->cec)
> >> -               priv->cec = i2c_new_dummy(client->adapter, 0x35);
> >> +       /* CEC I2C address bound to TDA998x I2C addr by configuration pins */
> >> +       cec_addr = 0x34 + (client->addr & 3);
> >> +       priv->cec = i2c_new_dummy(client->adapter, cec_addr);
> >
> > We discussed the issue of the I2C CEC address when the DT binding first
> > came up...
> >
> > Do we know for certain that the above is always true for all the devices
> > that this driver supports?
> 
> I know that it is true for the following:
> 
>         * TDA9989 (Both lower LSBs are zero)
>         * TDA19988 (LSBs are set from configuration pins)
>         * TDA19989 (Both lower LSBs are zero)
> 
> I don't know about the N2 variants of the various devices.
> 
> I have tested the patch on board containing two TDA19988s.

Thanks, that's useful information to have.  Also, it's worth pointing out
that the patch is whitespace damaged - tabs are converted to spaces,
which makes it unable to be applied.  There's other reasons (see below)
that makes us unable to apply this patch too...

As we all know, email clients know better than us humans how to format
email messages, which gives them carte blanche to screw up patches in
this way.

I'd recommend that you talk to others in ARM Ltd about how they get
around this problem.

> -- IMPORTANT NOTICE: The contents of this email and any attachments
> are confidential and may also be privileged. If you are not the
> intended recipient, please notify the sender immediately and do
> not disclose the contents to any other person, use it for any
> purpose, or store or copy the information in any medium.  Thank you.

This means that I can't take the patch, since applying it into a git
tree and then publishing it would violate this statement.  Doing so
copies and stores the information, and makes it available to people
who were not the intended recipient of your email.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
