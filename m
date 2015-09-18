From: stsp@list.ru (Stas Sergeev)
Date: Fri, 18 Sep 2015 15:43:54 +0300
Subject: mvneta: SGMII fixed-link not so fixed
In-Reply-To: <20150918121311.GD21084@n2100.arm.linux.org.uk>
References: <20150914103207.GH21084@n2100.arm.linux.org.uk>
 <55F6AA25.2070603@list.ru> <20150914114209.GL21084@n2100.arm.linux.org.uk>
 <20150917.151247.2129216999071943354.davem@davemloft.net>
 <20150917231422.GY21084@n2100.arm.linux.org.uk> <55FBF59E.3010205@list.ru>
 <20150918121311.GD21084@n2100.arm.linux.org.uk>
Message-ID: <55FC070A.6020707@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

18.09.2015 15:13, Russell King - ARM Linux ?????:
> On Fri, Sep 18, 2015 at 02:29:34PM +0300, Stas Sergeev wrote:
>> 18.09.2015 02:14, Russell King - ARM Linux ?????:
>>>  _But_ using the in-band status
>>>    property fundamentally requires this for mvneta to behave correctly:
>>>
>>> 		phy-mode = "sgmii";
>>> 		managed = "in-band-status";
>>> 		fixed-link {
>>> 		};
>>>
>>>    with _no_ phy node.
>> I don't understand this one.
>> At least for me it works without empty fixed-link.
>> There may be some bug.
> 
>         if (cause_rx_tx & MVNETA_MISCINTR_INTR_MASK) {
>                 u32 cause_misc = mvreg_read(pp, MVNETA_INTR_MISC_CAUSE);
> 
>                 mvreg_write(pp, MVNETA_INTR_MISC_CAUSE, 0);
>                 if (pp->use_inband_status && (cause_misc &
>                                 (MVNETA_CAUSE_PHY_STATUS_CHANGE |
>                                  MVNETA_CAUSE_LINK_CHANGE |
>                                  MVNETA_CAUSE_PSC_SYNC_CHANGE))) {
>                         mvneta_fixed_link_update(pp, pp->phy_dev);
>                 }
> 
> pp->use_inband_status is set when managed = "in-band-status" is set.
> We detect changes in the in-band status, and call mvneta_fixed_link_update():
> 
> mvneta_fixed_link_update() reads the status, and communicates that into
> the fixed-link phy:
> 
>         u32 gmac_stat = mvreg_read(pp, MVNETA_GMAC_STATUS);
> 
> 	... code setting status.* values from gmac_stat ...
>         changed.link = 1;
>         changed.speed = 1;
>         changed.duplex = 1;
> 	fixed_phy_update_state(phy, &status, &changed);
> 
> fixed_phy_update_state() then looks up the phy in its list, comparing only
> the address:
> 
>         if (!phydev || !phydev->bus)
>                 return -EINVAL;
> 
>         list_for_each_entry(fp, &fmb->phys, node) {
>                 if (fp->addr == phydev->addr) {
> 
> updating fp->* with the new state, calling fixed_phy_update_regs().  This
> updates the fixed-link phy emulated registers, and phylib then notices
> the change in link status, and notifies the netdevice attached to the
> PHY it found of the change.
> 
> Now, one of two things happens as a result of this:
> 
> 1. If pp->phy_dev is a fixed-link phy, this finds the correct fixed-link
>    phy to update its "fixed-link" properties, and the "not so fixed" phy
>    changes its parameters according to the new status.
> 
> 2. If pp->phy_dev is a MDIO phy which matches the address of a fixed-link
>    phy,
Doesn't the above loop iterates only "fixed_mdio_bus platform_fmb"?
I don't think MDIO PHYs can appear there. If they can - the bug is
very nasty. Have you seen exactly when/why that happens?


> Now, a fixed-link phy is only created in mvneta when there is no MDIO phy
> specified, but when there is a fixed-link specification in DT:
> 
>         phy_node = of_parse_phandle(dn, "phy", 0);
>         if (!phy_node) {
>                 if (!of_phy_is_fixed_link(dn)) {
>                         dev_err(&pdev->dev, "no PHY specified\n");
>                         err = -ENODEV;
>                         goto err_free_irq;
>                 }
> 
>                 err = of_phy_register_fixed_link(dn);
>                 if (err < 0) {
>                         dev_err(&pdev->dev, "cannot register fixed PHY\n");
>                         goto err_free_irq;
>                 }
> 
> If there's neither a MDIO PHY nor a fixed-link, then the network driver
> fails to initialise the device.
But it does.
In fact, of_mdio.c has this code:

        err = of_property_read_string(np, "managed", &managed);
        if (err == 0) {
                if (strcmp(managed, "in-band-status") == 0) {
                        /* status is zeroed, namely its .link member */
                        phy = fixed_phy_register(PHY_POLL, &status, np);
                        return IS_ERR(phy) ? PTR_ERR(phy) : 0;
                }
        }

Which is exactly for the case you describe.


>>> What I don't know is how many generations of the mvneta hardware have
>>> support for both serdes modes, but what I'm basically saying is that
>>> the solution we now have seems to be somewhat lacking - maybe it should
>>> have been "auto", "in-band-sgmii" and "in-band-1000base-x" with the
>>> ability to add additional modes later.
>>
>> Well, you need to be quick with such a change, esp now when the patch
>> was queued to -stable.
>> What alternatives do we have here?
>> Will the following work too?
>>  		phy-mode = "1000base-x";
>>  		managed = "in-band-status";
> 
> There's no chance of being "quick" here - the issues are complex and not
> trivial to solve in a day - I've already spent all week thinking about
> the issues here, and I'm only _just_ starting to come up with a potential
> solution this morning, though I haven't yet assessed whether it'll be
> feasible.
> 
> The problem I have with the above is that it fixes the phy mode to either
> SGMII or 1000base-X, whereas what we need for the SFP case is to have the
> down-link object tell the MAC driver whether it wants SGMII or 1000base-X
> mode.
Not that I understand that SFP business at all.
Maybe if some downlink tells the MAC what autoneg protocol will
be used, you can have:
  		phy-mode = "1000base-x" | "sgmii" | "serdes-auto";
  		managed = "in-band-status";

and "serdes-auto" will use either "1000base-x" or "sgmii", depending
on what the downlink says?
