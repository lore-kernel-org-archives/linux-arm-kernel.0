From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 29 Sep 2013 13:01:04 +0800
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3sv3wSbUc9QFVhmYsPc1kqiWYRuOMO7rreuiGSrwyepBQ@mail.gmail.com>
References: <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
 <20130927190546.GG12758@n2100.arm.linux.org.uk>
 <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
 <CAHCPf3sv3wSbUc9QFVhmYsPc1kqiWYRuOMO7rreuiGSrwyepBQ@mail.gmail.com>
Message-ID: <20130929050101.GA26156@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 02:48:16PM -0500, Matt Sealey wrote:
> GPR1[21] = 0 i.MX6 receives a clock from the PHY. You need to generate
> a clock at the PHY as input to the MAC. The MAC won't run until the
> PHY is out of reset and the clock is generated. You may need SION set
> for RMII depending on the pin...
> GPR1[21] = 1 implies we generate a clock from i.MX6 TO the PHY. The
> clock is looped back through the pad to the MAC. SION is irrelevant.
> 
> Still want to know who's clock it is and where it should be going....

There are some fuzzy around the imx6 ENET reference clock.  I was not
completely understanding it until I had a talk with the designer.

The following is a simplified and modified 'Table 23-1. ENET External
Signals' from reference manual ENET chapter.  I renamed a few things
(marked with ^^^)to avoid confusion.

Signal           Description                             Mode        Pad 
-------------------------------------------------------------------------------------
ENET_REF_CLK     In RMII mode, this signal is the        RMII        GPIO_16
                 reference clock for receive, transmit,
                 and the control interface.

ENET_TX_REF_CLK  Input clock, which provides a timing    MII/RGMII   PAD_ENET_REF_CLK
        ^^^^     reference for TX_EN, TX_DATA[3:0],         ^^^^^^   ^^^^
                 and TX_ER.

There are two ENET reference clocks.  One is ENET_REF_CLK which is used
by RMII and PTP (Precision Time Protocol, IEEE 1588) sampling, and the
other is ENET_TX_REF_CLK which is used by MII and RGMII.

Clock ENET_REF_CLK can only comes from pad GPIO_16 (RGMII_TX_CTL option
is ignored in this discussion) with either external PHY/oscillator clock
input on the pad (GPR1[21] = 0), or internal ENET_PLL output on the pad
and loop back to ENET_REF_CLK (GPR1[21] = 1) through the pad.

Clock ENET_TX_REF_CLK can only comes from pad PAD_ENET_REF_CLK, which
can only receives a clock input from external source.  This external
source can be RGMII PHY, oscillator or pad GPIO_16.  That said, GPR1[21]
and ENET_PLL do not have any implication on pad PAD_ENET_REF_CLK but
only GPIO_16.  If a board design wants to have i.MX6Q/DL provide 125MHz
clock to RGMII PHY, it has to do something the following digram shows.

                         i.MX6Q/DL
        -------------------------+
                                 |
             ENET_PLL            |             +-----------+
                 |               |             |           |
                 +-----> GPIO_16 |------+----->| RGMII PHY |
                            /    |      |      |           |
            PTP <----------/     |      |      +-----------+
                                 |      |
                PAD_ENET_REF_CLK |<-----+
                 +---/           |
                 |               |
                 v               |
         ENET_TX_REF_CLK         |
                                 |
        -------------------------+

The pad GPIO_16 has to be externally routed to PAD_ENET_REF_CLK, so that
the ENET can get the RGMII reference clock.  There are related
discussions about that as below.

https://community.freescale.com/message/330757#330757
https://community.freescale.com/message/350327#350327

Hope it makes the thing a little bit clear.

Shawn
