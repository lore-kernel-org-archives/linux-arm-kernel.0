From: stsp@list.ru (Stas Sergeev)
Date: Fri, 18 Sep 2015 14:29:34 +0300
Subject: mvneta: SGMII fixed-link not so fixed
In-Reply-To: <20150917231422.GY21084@n2100.arm.linux.org.uk>
References: <20150914103207.GH21084@n2100.arm.linux.org.uk>
 <55F6AA25.2070603@list.ru> <20150914114209.GL21084@n2100.arm.linux.org.uk>
 <20150917.151247.2129216999071943354.davem@davemloft.net>
 <20150917231422.GY21084@n2100.arm.linux.org.uk>
Message-ID: <55FBF59E.3010205@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

18.09.2015 02:14, Russell King - ARM Linux ?????:
> 3. Having DT specify a fixed-link with parameters along with in-band
>    negotiation results in the fixed-link parameters being ignored.
>    This means if a fixed-link DT declaration specifies a speed, that
>    declaration will be ignored.  What I'm basically saying is that:
> 
> 		phy-mode = "sgmii";
> 		fixed-link {
> 			speed = <1000>;
> 		};
> 
>    specifies a fixed-speed serdes link at 1000mbps, but:
> 
> 		phy-mode = "sgmii";
> 		managed = "in-band-status";
> 		fixed-link {
> 			speed = <1000>;
> 		};
> 
>    does not fix the speed at all.
I think the fixed-link DT parsing should be moved from of_mdio.c
to fixed-phy.c. Then fixed-phy will be able to back up the initial
values and use them whenever needed.
I can even do such a simple patch, but since it is not strictly
speaking a regression from my changes, I'd rather prefer someone
else do. :)


>  _But_ using the in-band status
>    property fundamentally requires this for mvneta to behave correctly:
> 
> 		phy-mode = "sgmii";
> 		managed = "in-band-status";
> 		fixed-link {
> 		};
> 
>    with _no_ phy node.
I don't understand this one.
At least for me it works without empty fixed-link.
There may be some bug.

> 
> 4. Going back to the SFP problem, the link is only up when the SFP
>    module pins indicate that there's no transmitter fault, no loss of
>    signal _and_ the PCS layer at the MAC indicates that it has completed
>    negotiation.  This pretty much rules out trying to emulate a SFP cage
>    as a software-based PHY.  I've code right now doing exactly that, and
>    it results in netif_carrier_on() being called far too early.
> 
> What I don't know is how many generations of the mvneta hardware have
> support for both serdes modes, but what I'm basically saying is that
> the solution we now have seems to be somewhat lacking - maybe it should
> have been "auto", "in-band-sgmii" and "in-band-1000base-x" with the
> ability to add additional modes later.
Well, you need to be quick with such a change, esp now when the patch
was queued to -stable.
What alternatives do we have here?
Will the following work too?
 		phy-mode = "1000base-x";
 		managed = "in-band-status";
