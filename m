From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jun 2011 11:16:10 +0100
Subject: DMA setup for ARM platform with hole low in memory
In-Reply-To: <315025466.1505794.1308000719987.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <1347566644.1505253.1308000163643.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
	<315025466.1505794.1308000719987.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <20110614101610.GA12419@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 09:31:59PM +0000, johnlinn at comcast.net wrote:
> I'm trying to decide the best way to setup this ARM platform DMA to
> deal with the fact that the lowest 512K of memory can not be DMAed
> into.  The rest of memory space is fine.
> 
> From my digging and prototyping it seems like a DMA zone will do the
> job, but maybe there's an easier way. The DMA mask doesn't seem to
> really help with this hole in memory and would still need to be
> 0xFFFFFFFF it appears.

The DMA zone won't help because it assumes that it is always at the
bottom of the RAM. The simples way is to mark that area as reserved and
never use it. It's not that bad since I suspect you already have the
kernel and swapper_pg_dir using most of it.

Have a look at arch/arm/mach-integrator/core.c - integrator_reserve().

-- 
Catalin
