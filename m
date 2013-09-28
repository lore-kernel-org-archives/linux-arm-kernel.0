From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Sep 2013 09:38:59 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <20130927202110.GI12758@n2100.arm.linux.org.uk>
References: <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
 <20130927190546.GG12758@n2100.arm.linux.org.uk>
 <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
 <CAHCPf3sv3wSbUc9QFVhmYsPc1kqiWYRuOMO7rreuiGSrwyepBQ@mail.gmail.com>
 <20130927202110.GI12758@n2100.arm.linux.org.uk>
Message-ID: <20130928083859.GQ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:21:10PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 27, 2013 at 02:48:16PM -0500, Matt Sealey wrote:
> > Ignore that. It's not totally wrong but it's weird. This is really
> > difficult to put into words...
> > 
> > GPR1[21] = 0 i.MX6 receives a clock from the PHY. You need to generate
> > a clock at the PHY as input to the MAC. The MAC won't run until the
> > PHY is out of reset and the clock is generated. You may need SION set
> > for RMII depending on the pin...
> > GPR1[21] = 1 implies we generate a clock from i.MX6 TO the PHY. The
> > clock is looped back through the pad to the MAC. SION is irrelevant.
> > 
> > Still want to know who's clock it is and where it should be going....
> 
> As I said, when Rabeeh is around, I will ask questions about this.
> I'm fairly certain that we don't need _all_ those ethernet pinmux
> settings (we just need the RGMII ones, and can omit the MII ones.)
> 
> Having hacked on this solidly since about 5pm yesterday, I'm not going
> to spend very much time on this until later next week, or I can talk to
> Rabeeh.

Okay, the answer is that yes, GPR1 bit 21 should be clear on this version
of the hardware, but there's plans to have the IMX6 generate the clock
and remove the crystal for the AR8035.

Now, here's the question for the IMX6 maintainers: how do I avoid having
GPR1 bit 21 set - it's unconditionally set by imx6q_1588_init() in
arch/arm/mach-imx/mach-imx6q.c.  Moreover, how do I control this from
DT?
