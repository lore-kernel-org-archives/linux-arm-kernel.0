From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2017 14:46:48 +0000
Subject: [PATCHv2 net-next 10/16] net: mvpp2: handle register mapping and
 access for PPv2.2
In-Reply-To: <1482943592-12556-11-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-11-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170106144648.GE14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 05:46:26PM +0100, Thomas Petazzoni wrote:
> This commit adjusts the mvpp2 driver register mapping and access logic
> to support PPv2.2, to handle a number of differences.
> 
> Due to how the registers are laid out in memory, the Device Tree binding
> for the "reg" property is different:
> 
>  - On PPv2.1, we had a first area for the common registers, and then one
>    area per port.
> 
>  - On PPv2.2, we have a first area for the common registers, and a
>    second area for all the per-ports registers.
> 
> In addition, on PPv2.2, the area for the common registers is split into
> so-called "address spaces" of 64 KB each. They allow to access the same
> registers, but from different CPUs. Hence the introduction of cpu_base[]
> in 'struct mvpp2', and the modification of the mvpp2_write() and
> mvpp2_read() register accessors. For PPv2.1, the compatibility is
> preserved by using an "address space" size of 0.

I'm not entirely sure this is the best solution - every register access
will be wrapped with a preempt_disable() and preempt_enable().  At
every site, when preempt is enabled, we will end up with code to:

- get the thread info
- increment the preempt count
- access the register
- decrement the preempt count
- test resulting preempt count and branch to __preempt_schedule()

If tracing is enabled, it gets much worse, because the increment and
decrement happen out of line, and are even more expensive.

If a function is going to make several register accesses, it's going
to be much more efficient to do:

	void __iomem *base = priv->cpu_base[get_cpu()];

	...

	put_cpu();

which means we don't end up with multiple instances of the preempt code
consecutive accesses.

I think this is an example where having driver-private accessors for
readl()/writel() is far from a good idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
