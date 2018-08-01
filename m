From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 2 Aug 2018 00:18:09 +0200
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <af188f23-bbef-ed90-b42d-a680c07f3fd2@broadcom.com>
References: <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
 <20180801203846.GE19257@lunn.ch>
 <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
 <20180801215511.GG19257@lunn.ch>
 <af188f23-bbef-ed90-b42d-a680c07f3fd2@broadcom.com>
Message-ID: <20180801221809.GH19257@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > As Florian pointed out, the clk_ API is happy to take a NULL pointer
> > for a clock. So you don't need this last else.
> > 
> >     Andrew
> > 
> I do return with an error from the probe if the clk_prepare_enable() fails,
> so I was calling the prepare with a valid clock.

How many times do we need to say it?

NULL is a valid clock. 

int clk_prepare(struct clk *clk)
{
	if (!clk)
	   return 0;

	   return clk_core_prepare_lock(clk->core);
}

int clk_enable(struct clk *clk)
{
	if (!clk)
	   return 0;

	   return clk_core_enable_lock(clk->core);
}

clk_prepare_enable(NULL) returns 0, which is not an error.

	 Andrew
