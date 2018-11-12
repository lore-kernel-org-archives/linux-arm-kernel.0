From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 12 Nov 2018 21:32:54 +0100
Subject: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
In-Reply-To: <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
 <4330cb5b-b1a5-5004-af51-39199943639d@gmail.com>
 <c067d321-c69e-706d-304a-04e1e477b47c@gmail.com>
Message-ID: <CAFBinCCmNYGp8kzy45ojjr27tEaPVs-QwMsLRrfXHCvw_taDOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiner,

On Fri, Nov 9, 2018 at 9:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 09.11.2018 21:33, Florian Fainelli wrote:
> > On 11/9/18 12:22 PM, Heiner Kallweit wrote:
> >> On 09.11.2018 21:13, Andrew Lunn wrote:
> >>> Hi Heiner
> >>>
> >>>> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> >>>> +{
> >>>> +  return phydrv->config_intr || phydrv->ack_interrupt;
> >>>> +}
> >>>
> >>> Should this be && not || ? I thought both needed to be provided for
> >>> interrupts to work.
> >>>
> >>>        Andrew
> >>>
> >> I've seen at least one driver which configures interrupts in
> >> config_init and doesn't define a config_intr callback
> >> (ack_interrupt callback is there)
> >
> > That driver should probably be fixed, while it most likely does not make
> > any significant difference during probe/connect, since config_init() and
> > config_intr() are virtually happening at the same time, this is not
> > necessarily true when disconnecting from the PHY where we really want
> > config_intr() to effectively disable the interrupts and not leaving
> > something enabled that would now become unmaskable, because no more
> > driver attached.
> >
> Found the driver: It's the IP101A/G in icplus.c
> It should be easy to fix the behavior and move the interrupt config
> to a config_intr callback. But the last real changes to the driver
> have been done 6 years ago, so I'm not sure there's anybody out
> there who can test.
if you want I can take care of the IP101A/G code.
I have at least one board with an IP101A/G (PHY ID: 0x02430c54,
according to the schematics it's an IP101GR-GP) where the interrupt is
routed to the SoC.

please let me know whether you'd like to work on it or if I should
give it a try.


Regards
Martin
