From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 1 Aug 2018 22:38:46 +0200
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <20180801202313.GH30658@n2100.armlinux.org.uk>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
Message-ID: <20180801203846.GE19257@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 09:23:14PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 01, 2018 at 10:07:12PM +0200, Andrew Lunn wrote:
> > You might want to consider adding clk_optional_get() and
> > devm_clk_optional_get().
> 
> I think there's attempts to add such APIs but I don't think it's
> trivial - it seems to require a _lot_ of discussion.
> 
> I think part of that is because of the quirky use of error codes.
> If you look at clk_get(), it calls __of_clk_get_by_name() which
> returns:
> 
>  -ENOENT if DT is disabled
>  -ENOENT if the device has no DT node
>  -EPROBE_DEFER if the lookup in DT succeeds but there's no registered
>    clock
>  -EINVAL if the device has a DT node but the lookup of the name
>    failed (in otherwords, the optional clock was omitted)
>  -ENOENT if the clocks = property has not enough clocks for the
>     clock-names property
>  -ENOMEM if we fail to allocate the clk
>  -ENOENT if __clk_get() fails

That makes it hard. I added phy_optional_get() early on, when the
error cases were simple. Hopefully they remain simple...

      Andrew
