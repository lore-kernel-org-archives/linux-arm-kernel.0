From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Aug 2018 23:09:16 +0200
Subject: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
 <20180827203500.GN27483@lunn.ch>
 <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
Message-ID: <20180827210916.GP27483@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 01:52:42PM -0700, Florian Fainelli wrote:
> On 08/27/2018 01:35 PM, Andrew Lunn wrote:
> >> @@ -210,6 +228,17 @@
> >>  			reg = <4>;
> >>  		};
> >>  
> >> +		port at 5 {
> >> +			label = "sfp";
> >> +			phy-mode = "sgmii";
> >> +			reg = <5>;
> >> +			sfp = <&sfp>;
> >> +			fixed-link {
> >> +				speed = <1000>;
> >> +				full-duplex;
> >> +			};
> > 
> > Hi Florian
> > 
> > You might want to add a comment about why you are using fixed-link and
> > sgmii, which seems very odd. Is it even correct?
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

Hi Florian

I didn't need anything like this for the mv88e6xxx. I had patches
merged in -rc1 to make SFF work connected to the mv88e6390. The DT
change was not merged, but it is here:

https://patchwork.ozlabs.org/patch/955635/

+					port at 9 {
+						reg = <9>;
+						label = "sff2";
+						phy-mode = "sgmii";
+						managed = "in-band-status";
+						sfp = <&sff2>;
+					};

	Andrew
