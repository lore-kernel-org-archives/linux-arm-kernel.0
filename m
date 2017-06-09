From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Jun 2017 10:25:41 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
Message-ID: <20170609082541.GC31464@kwain>
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

This is also a mistake. It's not a superset as the register offsets are
different. So we can't use the same smi operations in both cases. We
would need dedicated xmdio smi operations, but I don't think there is a
board where a c22 PHY is connected to the xMDIO interface.

I'll add smi and xsmi flags and return -ENOTSUPP based on the
MII_ADDR_C45 bit and flags combination. If the need to support smi
operations on the xMDIO bus arise it will be fairly easy to implement in
the future. I'll rename the ops functions as well to differentiate mdio
and xmdio operations.

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/4782d8b0/attachment-0001.sig>
