From: balbi@ti.com (Felipe Balbi)
Date: Wed, 11 Apr 2012 11:56:39 +0300
Subject: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
In-Reply-To: <CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410162353.GA6217@core.coreip.homeip.net>
 <CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
Message-ID: <20120411085638.GC12064@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 02:19:48PM +0530, Poddar, Sourav wrote:
> >> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> >> +{
> >> + ? ? if (keypad_data->revision == KBD_REVISION_OMAP4)
> >> + ? ? ? ? ? ? return __raw_readl(keypad_data->base + offset);
> >> + ? ? else if (keypad_data->revision == KBD_REVISION_OMAP5)
> >> + ? ? ? ? ? ? return __raw_readl(keypad_data->base + offset + 0x10);
> >> +
> >> + ? ? return -ENODEV;
> >
> > Instead do:
> >
> > ? ? ? ?return __raw_readl(keypad_data->base + keypad_data->reg_offset +
> > ? ? ? ? ? ? ? ? ? ? ? ? ? offset);
> >> +}
> I have a couple of doubts on this:
> 1. Before using kbd_readl/kbd_write anywhere we
> need to populate the "keypad_data->reg_offset"  with the register address
> which we need to read or write.

no no... keypad_data->reg_offset would be 0 or 0x10 depending on the
scheme you decode from revision.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/c9cb20d9/attachment.sig>
