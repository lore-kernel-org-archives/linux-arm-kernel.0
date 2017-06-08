From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Jun 2017 18:55:46 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
Message-ID: <20170608165546.GC20216@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 09:42:21AM -0700, Florian Fainelli wrote:
> On 06/08/2017 02:26 AM, Antoine Tenart wrote:
> > This patch adds the xMDIO interface support in the mvmdio driver. This
> > interface is used in Ethernet controllers on Marvell 370, 7k and 8k (as
> > of now). The xSMI interface supported by this driver complies with the
> > IEEE 802.3 clause 45 (while the SMI interface complies with the clause
> > 22). The xSMI interface is used by 10GbE devices.
> 
> In the previous version you were properly defining a new compatibles
> strings for xmdio, but now you don't and instead you runtime select the
> operations based on whether MII_ADDR_C45 is set in the register which is
> fine from a functional perspective.
> 
> If I get this right, the xMDIO controller is actually a superset of the
> MDIO controller and has an extra MVMDIO_XSMI_ADDR_REG register to
> preform C45 accesses?
> 
> If that is the case (and looking at patch 8 that seems to be the case),
> you probably still need to define a new compatible string for that
> block, because it has a different register layout than its predecessor.

Yes, i think you need the compatible string to return -EOPNOSUP when
somebody tries to do a C45 access on the older IP which only has C22.

	 Andrew
