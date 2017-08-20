From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 20 Aug 2017 16:25:45 +0200
Subject: [PATCH v3 3/4] net: stmmac: register parent MDIO node for
 sun8i-h3-emac
In-Reply-To: <20170820065757.GA6081@Red>
References: <20170818122118.4925-1-clabbe.montjoie@gmail.com>
 <20170818122118.4925-4-clabbe.montjoie@gmail.com>
 <CAGb2v66KcZkiDDHryMmVzm4WroXePPy3V44SLpVdoO3ZEjgC=g@mail.gmail.com>
 <20170819185025.GB13266@Red> <20170819203836.GA21567@lunn.ch>
 <20170820065757.GA6081@Red>
Message-ID: <20170820142545.GB24150@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think we cannot use mdio-mux-mmioreg since the register for doing
> the switch is in middle of the "System Control" and shared with
> other functions.  This is why we use a sycon/regmap for selecting
> the MDIO.

You could add a mdio-mux-regmap.c.

However, it probably need restructuring of the stmmac mdio code, to
make the mdio bus usable as a separate driver. You need stmmac mdio
to probe first, then mdio-mux-remap should probe, and then lastly
stmmmac mac driver.

With stmmac mdio and stmmac mac being in one driver, there is no time
in the middle to allow the mux driver to probe.

It is some effort, but a nice cleanup and generalization.

   Andrew
