From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Aug 2018 14:09:20 -0700
Subject: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
 <20180827203500.GN27483@lunn.ch>
 <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
Message-ID: <455621d9-5021-5d54-12d6-661dfe152bde@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2018 01:52 PM, Florian Fainelli wrote:
> On 08/27/2018 01:35 PM, Andrew Lunn wrote:
>>> @@ -210,6 +228,17 @@
>>>  			reg = <4>;
>>>  		};
>>>  
>>> +		port at 5 {
>>> +			label = "sfp";
>>> +			phy-mode = "sgmii";
>>> +			reg = <5>;
>>> +			sfp = <&sfp>;
>>> +			fixed-link {
>>> +				speed = <1000>;
>>> +				full-duplex;
>>> +			};
>>
>> Hi Florian
>>
>> You might want to add a comment about why you are using fixed-link and
>> sgmii, which seems very odd. Is it even correct?
> 
> Probably not, this is kind of left over from before adding the sfp
> phandle, but if I do remove it, and I can see the DSA slave network
> device fail to initialize, likely because we destroy the PHYLINK instance.
> 
> AFAIR, when we talked about this with Russell, I did not see why we had
> to comment out the following:
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 962c4fd338ba..f3ae16dbf8d8 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1227,7 +1227,7 @@ static int dsa_slave_phy_setup(struct net_device
> *slave_dev)
>                         netdev_err(slave_dev,
>                                    "failed to connect to port %d: %d\n",
>                                    dp->index, ret);
> -                       phylink_destroy(dp->pl);
> +                       //phylink_destroy(dp->pl);
>                         return ret;
>                 }
>         }
> 
> maybe you know?

Stupid question, if we have a "sfp" phandle, must one also specify a
managed = "in-band-status" property? Under what circumstances are not
these two things implying one another (SFF maybe)?

That would explain why the code path taken from phylink_of_phy_connect()
would not return 0 and we would indeed fail to connect to the built-in
DSA MDIO bus.
-- 
Florian
