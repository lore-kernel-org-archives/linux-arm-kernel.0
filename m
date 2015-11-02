From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Nov 2015 10:17:50 +0000
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <yw1xpozvavui.fsf@unicorn.mansr.com>
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
 <56325C67.8000007@free.fr> <yw1xeggdd007.fsf@unicorn.mansr.com>
 <5633CF2A.4040504@free.fr> <yw1xpozvavui.fsf@unicorn.mansr.com>
Message-ID: <20151102101750.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2015 at 03:41:57PM +0000, M?ns Rullg?rd wrote:
> The best value to use depends on the workload, so it would be nice to be
> able to control all the purely performance related bits.  I see no
> possible benefit in restricting the non-secure kernel from writing
> these.

For the most case, the auxiliary control register settings are static.
Once the L2 cache is enabled, you can't write to the control register
until the L2 cache is disabled, and you can't sensibly do that on a
running system without taking the system down.

Those which can be tuned at runtime (the prefetch enables) are also
available in the prefetch control register, along with the prefetch
offset.

The auxiliary control register is really to do with configuring the
cache to the system its in rather than about performance.

Eg, you could have the FLZ bit set in the L2 cache auxiliary register
if its wired to a Cortex A9 CPU and the FLZ signal is wired.  That
would be perfectly reasonable, provided the FLZ bit in the Cortex
A9's control register is disabled when the L2 cache is otherwise
disabled.

(I guess I ought to quieten down the pr_err() in that case...)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
