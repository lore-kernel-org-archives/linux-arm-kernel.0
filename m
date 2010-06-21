From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 10:02:45 +0100
Subject: [PATCH 1/2] [ARM] Introduce 'struct machine_class' for SoC
	level abstraction
In-Reply-To: <AANLkTilUddhIW0C5LN4b7igh6vEDvelhnT8a3or677Zk@mail.gmail.com>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
	<201006211527.49786.jeremy.kerr@canonical.com>
	<AANLkTilUddhIW0C5LN4b7igh6vEDvelhnT8a3or677Zk@mail.gmail.com>
Message-ID: <20100621090245.GA7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 04:23:22PM +0800, Eric Miao wrote:
> So that from derivative POV, it can be expressed as:
> 
> 	if (mdesc->class && mdesc->class->map_io)
> 		mdesc->class->map_io();
> 	if (mdesc->map_io())
> 		mdesc->map_io();
> 
> But this seems to make things a bit over complicated, so for such cases
> I'd prefer:
> 
> 1. have a separate machine_class for mainstone
> 2. or move the board specific map_io() separatedly

How about making the presence of mdesc->map_io override the class
version?

So if mainstone provides its own map_io() function, it is still
responsible (as is today) for calling the PXA specific map_io().
The same behaviour seems sensible to apply to the other class
functions as well - allow platforms to override the class
version, and leave the replacement platform function responsible
for calling the class if that's what it needs to do.
