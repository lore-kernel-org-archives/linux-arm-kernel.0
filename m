From: stsp@list.ru (Stas Sergeev)
Date: Fri, 18 Sep 2015 19:04:09 +0300
Subject: mvneta: SGMII fixed-link not so fixed
In-Reply-To: <20150918154339.GJ21084@n2100.arm.linux.org.uk>
References: <20150914114209.GL21084@n2100.arm.linux.org.uk>
 <20150917.151247.2129216999071943354.davem@davemloft.net>
 <20150917231422.GY21084@n2100.arm.linux.org.uk> <55FBF59E.3010205@list.ru>
 <20150918121311.GD21084@n2100.arm.linux.org.uk> <55FC070A.6020707@list.ru>
 <20150918131257.GF21084@n2100.arm.linux.org.uk> <55FC151F.6040708@list.ru>
 <20150918135746.GG21084@n2100.arm.linux.org.uk> <55FC2387.9080304@list.ru>
 <20150918154339.GJ21084@n2100.arm.linux.org.uk>
Message-ID: <55FC35F9.9040403@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

18.09.2015 18:43, Russell King - ARM Linux ?????:
> On Fri, Sep 18, 2015 at 05:45:27PM +0300, Stas Sergeev wrote:
>> 18.09.2015 16:57, Russell King - ARM Linux ?????:
>>> On Fri, Sep 18, 2015 at 04:43:59PM +0300, Stas Sergeev wrote:
>>>> 18.09.2015 16:12, Russell King - ARM Linux ?????:
>>>>> On Fri, Sep 18, 2015 at 03:43:54PM +0300, Stas Sergeev wrote:
>>>>>> 18.09.2015 15:13, Russell King - ARM Linux ?????:
>>>>>>> On Fri, Sep 18, 2015 at 02:29:34PM +0300, Stas Sergeev wrote:
>>>>>>>> 18.09.2015 02:14, Russell King - ARM Linux ?????:
>>>>>>>>>  _But_ using the in-band status
>>>>>>>>>    property fundamentally requires this for mvneta to behave correctly:
>>>>>>>>>
>>>>>>>>> 		phy-mode = "sgmii";
>>>>>>>>> 		managed = "in-band-status";
>>>>>>>>> 		fixed-link {
>>>>>>>>> 		};
>>>>>>>>>
>>>>>>>>>    with _no_ phy node.
>>>>>>>> I don't understand this one.
>>>>>>>> At least for me it works without empty fixed-link.
>>>>>>>> There may be some bug.
>>>>>>>
>>>>>>>         if (cause_rx_tx & MVNETA_MISCINTR_INTR_MASK) {
>>>>>>>                 u32 cause_misc = mvreg_read(pp, MVNETA_INTR_MISC_CAUSE);
>>>>>>>
>>>>>>>                 mvreg_write(pp, MVNETA_INTR_MISC_CAUSE, 0);
>>>>>>>                 if (pp->use_inband_status && (cause_misc &
>>>>>>>                                 (MVNETA_CAUSE_PHY_STATUS_CHANGE |
>>>>>>>                                  MVNETA_CAUSE_LINK_CHANGE |
>>>>>>>                                  MVNETA_CAUSE_PSC_SYNC_CHANGE))) {
>>>>>>>                         mvneta_fixed_link_update(pp, pp->phy_dev);
>>>>>>>                 }
>>>>>>>
>>>>>>> pp->use_inband_status is set when managed = "in-band-status" is set.
>>>>>>> We detect changes in the in-band status, and call mvneta_fixed_link_update():
>>>>>>>
>>>>>>> mvneta_fixed_link_update() reads the status, and communicates that into
>>>>>>> the fixed-link phy:
>>>>>>>
>>>>>>>         u32 gmac_stat = mvreg_read(pp, MVNETA_GMAC_STATUS);
>>>>>>>
>>>>>>> 	... code setting status.* values from gmac_stat ...
>>>>>>>         changed.link = 1;
>>>>>>>         changed.speed = 1;
>>>>>>>         changed.duplex = 1;
>>>>>>> 	fixed_phy_update_state(phy, &status, &changed);
>>>>>>>
>>>>>>> fixed_phy_update_state() then looks up the phy in its list, comparing only
>>>>>>> the address:
>>>>>>>
>>>>>>>         if (!phydev || !phydev->bus)
>>>>>>>                 return -EINVAL;
>>>>>>>
>>>>>>>         list_for_each_entry(fp, &fmb->phys, node) {
>>>>>>>                 if (fp->addr == phydev->addr) {
>>>>>>>
>>>>>>> updating fp->* with the new state, calling fixed_phy_update_regs().  This
>>>>>>> updates the fixed-link phy emulated registers, and phylib then notices
>>>>>>> the change in link status, and notifies the netdevice attached to the
>>>>>>> PHY it found of the change.
>>>>>>>
>>>>>>> Now, one of two things happens as a result of this:
>>>>>>>
>>>>>>> 1. If pp->phy_dev is a fixed-link phy, this finds the correct fixed-link
>>>>>>>    phy to update its "fixed-link" properties, and the "not so fixed" phy
>>>>>>>    changes its parameters according to the new status.
>>>>>>>
>>>>>>> 2. If pp->phy_dev is a MDIO phy which matches the address of a fixed-link
>>>>>>>    phy,
>>>>>> Doesn't the above loop iterates only "fixed_mdio_bus platform_fmb"?
>>>>>> I don't think MDIO PHYs can appear there. If they can - the bug is
>>>>>> very nasty. Have you seen exactly when/why that happens?
>>>>>
>>>>> I think I explained it fully - please follow the code paths I've detailed
>>>>> above.
>>>> I try. What I don't understand is why both PHYs get the
>>>> same address on the "Fixed MDIO bus".
>>>
>>> They aren't both on the fixed MDIO bus - that's the whole point I'm
>>> making.  They get the same phydev->addr but on _different_ buses.
>>
>> So you have an MDIO phy for which mvneta seems to have
>> use_inband_status==true, correct?
> 
> That is one very real possibililty.  Cisco SGMII in-band status is for a
> SGMII PHY to inform the MAC about the properties of the link to which the
> PHY is attached.
> 
> So, specifying "managed = in-band-status" along with a real PHY is very
> much a _real_ possibility, as I've previously explained.
> 
>> AFAICS if it has use_inband_status==true,
>> then it went through of_phy_register_fixed_link(dn),
> 
> That's totally incorrect.  The test for setting use_inband_status in
> mvneta is:
> 
>         err = of_property_read_string(dn, "managed", &managed);
>         pp->use_inband_status = (err == 0 &&
>                                  strcmp(managed, "in-band-status") == 0);

Arrrr! I was looking at the branch without the last
patch applied, so it occurred to me as

	pp->use_inband_status = (phy_mode == PHY_INTERFACE_MODE_SGMII) &&
		fixed_phy;

Sorry for that.
So we seem to indeed have a nasty regression with the patch
that just went to stable. :( Great news.
Thanks for you time.

I still have problems with this part though:
> If there's neither a MDIO PHY nor a fixed-link, then the network driver
> fails to initialise the device.

I think I am looking into the right source this time, seems like
if we don't have both but still have managed="in-band-status", that
should go the fixed-link path and still work... no?
