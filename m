From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 29 Dec 2017 22:41:12 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171228185920.GW10595@n2100.armlinux.org.uk>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171227224252.GB2626@kwain>
 <20171227231959.GU10595@n2100.armlinux.org.uk>
 <20171228100416.GD2626@kwain>
 <20171228185920.GW10595@n2100.armlinux.org.uk>
Message-ID: <20171229214112.GB4835@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Dec 28, 2017 at 06:59:21PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 28, 2017 at 11:04:16AM +0100, Antoine Tenart wrote:
> > 
> > That's not what I remembered. You had some valid points, and others
> > related to PHY modes the driver wasn't supporting before the phylink
> > transition. My understanding of this was that you wanted a full
> > featured support while I only wanted to convert the already supported
> > modes.
> 
> You are mistaken - you can get a full refresher on where things were
> at via https://patchwork.kernel.org/patch/9963971/

I read it again and still have the same feeling. There's been a
misunderstanding at some point. Anyway, let's move forward :)

> 1. I asked for details about what mvpp2.c supports that phylink does
>    not (as you indicated that there were certain things that mvpp2
>    supports that phylink does not.)  I'm still awaiting a response.

I don't remember PHY modes supported in the PPv2 driver that aren't
supported in PHYLINK. I think this point is the main misunderstanding. I
thought you wanted me to support modes unsupported in the PPv2 driver
before. But you explained quite well what these comments were about
below.

So I guess this point is resolved (aka I'll have to take your comments
into account for the v2).

> 2. 25th Sept, you indicated that you would get someone to test
>    an issue related to in-band AN. No results of that testing have
>    been forthcoming.

That's right. I asked someone to make a test, but did not get an answer.
And because the PHYLINK patch stalled on my side I kinda forget about
it. I'll try again to have this test made.

> I am not after a full featured support, what I'm after is ensuring
> that phylink is (a) used correctly and (b) implementations using it
> are correct.  Part of that is ensuring that users don't introduce
> unexpected failure conditions.
> 
> So, when you do this in the validate() callback:
> 
>  +       phylink_set(mask, 1000baseX_Full);
> 
> and then do this in the mac_config() callback:
> 
>  +       if (!phy_interface_mode_is_rgmii(port->phy_interface) &&
>  +           port->phy_interface != PHY_INTERFACE_MODE_SGMII)
>  +               return;
> 
> and this in the link_state() callback:
> 
>  +       if (!phy_interface_mode_is_rgmii(port->phy_interface) &&
>  +           port->phy_interface != PHY_INTERFACE_MODE_SGMII)
>  +               return 0;
> 
> the result is that phylink thinks that you support 1000base-X modes,
> and it will call mac_config() asking for 1000base-X, but you silently
> ignore that, leaving the hardware configured in whatever state it was.
> That leads to a silent failure as far as the user is concerned.
> 
> So, if you do not intend to support 1000base-X initially, don't
> allow it in the validate callback until you do.
> 
> It gets worse, because the return in link_state() means that phylink
> thinks that the link is up if it has requested 1000base-X, which it
> won't be unless you've properly configured it.
> 
> It's this kind of unreliability that I was concerned about in your
> patch.  I'm not demanding "full featured implementation" but I do
> want you to use it correctly.

Thanks for the detailed explanations!

> > > What I'm most concerned about, given the bindings for comphy that
> > > have been merged, is that Free Electrons is pushing forward seemingly
> > > with no regard to the requirement that the serdes lanes are dynamically
> > > reconfigurable, and that's a basic requirement for SFP, and for the
> > > 88x3310 PHYs on the Macchiatobin platform.
> > 
> > The main idea behind the comphy driver is to provide a way to
> > reconfigure the serdes lanes at runtime. Could you develop what are
> > blocking points to properly support SFP, regarding the current comphy
> > support?
> 
> If it supports serdes lane mode reconfiguration (iow, switching between
> 1000base-X, 2500base-X, SGMII, 10G-KR), then that's all that's required.

It does, and the PPv2 driver already ask the COMPHY driver to perform
these reconfigurations (when using the 10G/1G interface on the mcbin for
example).

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
