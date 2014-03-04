From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Mar 2014 20:04:24 +0100
Subject: [PATCHv3 1/4] net: phy: decouple PHY id and PHY address in
 fixed PHY driver
In-Reply-To: <CAGVrzcYF0g-vDpkP_fnqb13faPtOOSy_Pqfo-Pgti0S26-1nSg@mail.gmail.com>
References: <1393930704-24374-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1393930704-24374-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAGVrzcYF0g-vDpkP_fnqb13faPtOOSy_Pqfo-Pgti0S26-1nSg@mail.gmail.com>
Message-ID: <20140304200424.66a6171f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Tue, 4 Mar 2014 10:43:12 -0800, Florian Fainelli wrote:

> >  struct fixed_phy {
> > -       int id;
> > +       int addr;
> >         u16 regs[MII_REGS_NUM];
> >         struct phy_device *phydev;
> >         struct fixed_phy_status status;
> > @@ -104,8 +104,8 @@ static int fixed_phy_update_regs(struct fixed_phy *fp)
> >         if (fp->status.asym_pause)
> >                 lpa |= LPA_PAUSE_ASYM;
> >
> > -       fp->regs[MII_PHYSID1] = fp->id >> 16;
> > -       fp->regs[MII_PHYSID2] = fp->id;
> > +       fp->regs[MII_PHYSID1] = 0xdead;
> > +       fp->regs[MII_PHYSID2] = 0xbeef;
> 
> I am still scratching my head as to whether we want that change to be
> in this particular version of changes, or if we want that to happen at
> a later time when (if?) we can finally get some proper OUI number
> allocation.
> 
> Technically we are presenting some sort of ABI to user-space, although
> detecting a fixed PHY device by reading its MII_PHYSID1/2 and matching
> it against its PHY address on the fixed MDIO bus would have been a
> little "weak" (especially when you can check that the parent device in
> sysfs is the fixed-0 bus).

Well the problem is that fp->id really isn't an id, it's the fake
address of the PHY on the fake fixed MDIO bus. So it would mean that
the MII_PHYSID of the first fixed PHY would probably be 0x0, then the
second would have 0x1, then 0x2, and so on.

Probably not worse than what is done today, though.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
