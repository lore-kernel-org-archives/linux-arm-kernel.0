From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 3 Feb 2016 15:56:48 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <20160129114853.GQ10826@n2100.arm.linux.org.uk>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
Message-ID: <20160203155648.1c6fed8f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, 29 Jan 2016 11:48:53 +0000, Russell King - ARM Linux wrote:

> > Well, may be that's one more reason for fixing it before boards start to
> > ship and run distro kernels. If some boards are already in the wild running
> > on a BSP kernel, people will complain that mainline reorders their network
> > ports and will stick to the BSP kernel instead.
> 
> I've checked, and we believe not many people are using mainline kernels
> on clearfog.  I'll have to adjust my debian jessie setup to fix the
> resulting carnage though.  On the plus side, it means that mainline
> matches Marvell's kernel for interface naming.
> 
> However, I will point out that changing the DT order may fix it for now,
> but if there's changes to the kernel initialisation which results in a
> different probe order (eg, because of a change to the way probing works,
> which is something that's been discussed a few times) it's likely that
> the ethX names will change again...
> 
> In other words, what I'm saying is that there's no guarantee that
> changing the DT order will always result in the desired network device
> naming.

Yes, fully agreed, it is not a complete guarantee. But in "most cases",
it will still lead to something that is a bit more logical for normal
users.

In its vendor BSP, Marvell has gone all the way to changing the link
order of certain PCIe drivers, to make sure that the mvneta driver gets
probed first. And indeed, without this hack, if you plug an e1000e PCIe
NIC, it gets probed first and therefore assigned as eth0, while all the
built-in network interfaces get shifted at eth1, eth2, etc.

Really sad that the network subsystem doesn't follow the DT aliases to
name network interfaces, but it has been rejected multiple times by
Dave Miller as far as I know. In the absence of this, re-ordering the
DT nodes is a cheap hack that makes things look a bit more logical in
many situations.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
