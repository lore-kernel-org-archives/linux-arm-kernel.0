From: stsp@list.ru (Stas Sergeev)
Date: Fri, 18 Sep 2015 22:38:55 +0300
Subject: mvneta: SGMII fixed-link not so fixed
In-Reply-To: <55FC4A42.905@gmail.com>
References: <20150917231422.GY21084@n2100.arm.linux.org.uk>
 <55FBF59E.3010205@list.ru> <20150918121311.GD21084@n2100.arm.linux.org.uk>
 <55FC070A.6020707@list.ru> <20150918131257.GF21084@n2100.arm.linux.org.uk>
 <55FC151F.6040708@list.ru> <20150918135746.GG21084@n2100.arm.linux.org.uk>
 <55FC2387.9080304@list.ru> <20150918154339.GJ21084@n2100.arm.linux.org.uk>
 <55FC35F9.9040403@list.ru> <20150918172222.GL21084@n2100.arm.linux.org.uk>
 <55FC4A42.905@gmail.com>
Message-ID: <55FC684F.2060808@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

18.09.2015 20:30, Florian Fainelli ?????:
> On 18/09/15 10:22, Russell King - ARM Linux wrote:
>> On Fri, Sep 18, 2015 at 07:04:09PM +0300, Stas Sergeev wrote:
>>> 18.09.2015 18:43, Russell King - ARM Linux ?????:
>>>> On Fri, Sep 18, 2015 at 05:45:27PM +0300, Stas Sergeev wrote:
>>>>> AFAICS if it has use_inband_status==true,
>>>>> then it went through of_phy_register_fixed_link(dn),
>>>> That's totally incorrect.  The test for setting use_inband_status in
>>>> mvneta is:
>>>>
>>>>          err = of_property_read_string(dn, "managed", &managed);
>>>>          pp->use_inband_status = (err == 0 &&
>>>>                                   strcmp(managed, "in-band-status") == 0);
>>> Arrrr! I was looking at the branch without the last
>>> patch applied, so it occurred to me as
>>>
>>> 	pp->use_inband_status = (phy_mode == PHY_INTERFACE_MODE_SGMII) &&
>>> 		fixed_phy;
>>>
>>> Sorry for that.
>> Yay :)
>>
>>> So we seem to indeed have a nasty regression with the patch
>>> that just went to stable. :( Great news.
>> Yes.
>>
>>> Thanks for you time.
>>>
>>> I still have problems with this part though:
>>>> If there's neither a MDIO PHY nor a fixed-link, then the network driver
>>>> fails to initialise the device.
>>> I think I am looking into the right source this time, seems like
>>> if we don't have both but still have managed="in-band-status", that
>>> should go the fixed-link path and still work... no?
>> If we have no fixed-link and no phy, then you're correct.
>>
>> However, I really don't like the idea of abusing "fixed-link" as a
>> method to generate an ethtool/miitool/miidiag compatible output for
>> this, but I'm willing to let that pass for the moment. :)
> It is not just for that, you get all the goodies from the PHY library
> without modifying your Ethernet MAC driver specifically for it:
> phy_connect, adjust_link and phy_ethtool_{set,get}.
But you still need to modify the MAC driver, and in a bit
nasty way. Eg when you want the AN to work right, you
need to do of_phy_find_device() and feed the current AN
settings to fixed-phy manually, or, after phy_connect(), you'll
run with wrong link state for some time (and there is still
a bit of race anyway, as the link state could change between
of_phy_find_device() and phy_connect()).
So I am not sure what would the best API look like, but
my overall impression was it is currently not the one.
