From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Fri, 15 Apr 2016 06:40:42 -0300
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
In-Reply-To: <20160414143501.GA25212@rob-hp-laptop>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
 <20160414143501.GA25212@rob-hp-laptop>
Message-ID: <20160415064042.330406ab.m.chehab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, 14 Apr 2016 09:35:01 -0500
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Apr 12, 2016 at 05:12:55PM -0500, tthayer at opensource.altera.com wrote:
> > This patch set adds the memory initialization functions for Altera's
> > Arria10 peripherals, the first of which is the Ethernet EDAC. The
> > first 3 patches add the memory initialization functionality. The
> > last 3 patches add Ethernet EDAC support.  
> 
> The ethernet part seems a bit strange to me to put under EDAC as EDAC 
> is primarily memory controller ECC (and caches to some extent). Also you 
> would not halt the system in case of an UC, but rather just drop the 
> frame. This would need to be part of the ethernet driver in that case.
>  
> Of course, given that ethernet frames already have a CRC, ECC of the 
> FIFO seems a bit redundant.

Actually, EDAC was conceived to be a way to report hardware errors, and,
although the main use case is for memory and CPU errors, there are a few
drivers that report errors at PCI bus. So, I don't see much problems using
it to report other hardware errors, like the ones associated with the
Ethernet hardware.

That's said, things like Ethernet frame errors are better handled via the
network drivers. I would report via EDAC only errors associated with the
Ethernet hardware that would cause the hardware to malfunction.

Btw, an UC error won't cause the system to halt, except if a UC memory
error happens and the EDAC core is loaded with an special modprobe
parameter (edac_mc_panic_on_ue = 1).

-- 
Thanks,
Mauro
