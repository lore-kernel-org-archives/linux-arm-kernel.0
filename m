From: Kyle.D.Moffett@boeing.com (Moffett, Kyle D)
Date: Wed, 23 Mar 2011 20:38:04 -0500
Subject: [RFC PATCH] et1011c: Replaced PHY driver by a small dm646x
	board fixup
In-Reply-To: <AANLkTin14WSZsc7+B-rK1dSn=XShNrF63k_47RXu-3G6@mail.gmail.com>
References: <091F7EC1-5D33-4C90-AFC1-D6E24EF3EEC6@boeing.com><1300919616-6780-1-git-send-email-Kyle.D.Moffett@boeing.com>
	<AANLkTin14WSZsc7+B-rK1dSn=XShNrF63k_47RXu-3G6@mail.gmail.com>
Message-ID: <60663E62-39F3-4F4E-9FF5-EDA9800B30D9@boeing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 23, 2011, at 20:24, Andy Fleming wrote:
> On Wed, Mar 23, 2011 at 5:33 PM, Kyle Moffett <Kyle.D.Moffett@boeing.com> wrote:
>> -
>> -static struct phy_driver et1011c_driver = {
>> -       .phy_id         = 0x0282f014,
>> -       .name           = "ET1011C",
>> -       .phy_id_mask    = 0xfffffff0,
>> -       .features       = (PHY_BASIC_FEATURES | SUPPORTED_1000baseT_Full),
>> -       .flags          = PHY_POLL,
>> -       .config_aneg    = et1011c_config_aneg,
>> -       .read_status    = et1011c_read_status,
>> -       .driver         = { .owner = THIS_MODULE,},
>> -};
> 
> Might I suggest that you not eliminate the whole driver?  If you leave
> just this part (and the init stuff below it), and convert the
> config_aneg and read_status pointers to use the genphy versions, the
> kernel will, at least, be able to report what type of PHY it is.  And
> maybe one day, someone who is familiar with the inner workings of this
> PHY will fill in a more correct driver.

Hmm, I suppose that's an option, but really that's missing the point of
the "genphy" driver, which gives full functionality with any PHY that
correctly implements that portion of the standard IEEE 802.3 spec.

I've looked through the ET1011C datasheet/programming-guide, and I can't
see anything (aside from hardware bugs/errata) that would interfere with
the proper operation of the PHY using the generic driver.

There are a *lot* of PHYs which don't have their own Linux drivers,
simply because a custom driver is mostly unnecessary for a properly
designed PHY.  The only exception is that PHYs supporting IRQ-driven
operation need .ack_interrupt() and .config_intr(), but that wasn't
included in the first driver either (IE: it is "PHY_POLL").

Looking at the representative sample of the PHY drivers in linux:
  bcm63xx: IRQ support
  bcm54xx: IRQ support, hardware errata, custom LED settings
  cicada: IRQ support, hardware errata
  davicom: IRQ support, hardware errata
  icplus: Ethernet switch posing as a PHY
  lxt: IRQ support, copper/fiber switching
  marvell: IRQ support, hardware errata, copper/fiber switching
  micrel: IRQ support
  national: IRQ support, hardware-specific initialization
  qsemi: IRQ support
  realtek: IRQ support
  ste10Xp: IRQ support
  vitesse: IRQ support, copper/fiber switching

Besides which, for just identifying unknown PHYs we can look in the PHY
registers 2 and 3, they're defined to contain a 22-bit manufacturer OUI
and some additional model/revision numbers.  We can map that to
human-readable strings in userspace today the same way as PCI, USB, etc.

Cheers,
Kyle Moffett
