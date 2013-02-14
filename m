From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Feb 2013 17:16:15 +0000
Subject: [BUG] v7_coherent_kern_range broken on big.LITTLE
In-Reply-To: <1360861663.3266.58.camel@linaro1.home>
References: <1360861663.3266.58.camel@linaro1.home>
Message-ID: <20130214171615.GH12629@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tixy,

On Thu, Feb 14, 2013 at 05:07:43PM +0000, Jon Medhurst (Tixy) wrote:
> The function v7_coherent_kern_range uses the macro icache_line_size to
> read the current CPUs icache line size for the purpose of invalidating
> all cache lines in the given range.
> 
> Unfortunately, on the TC2 big.LITTLE test chip, the A15 icache line size
> is 64 bytes, but the A7 size is only 32 bytes. So when the function
> executes on the A15 it will miss out every alternate cache line for the
> A7.

There is a signal (IMINLN) to the core which allows A15 to behave as though
it has a 32-byte line size and this should be driven correctly for big/little.

Can you confirm that on your TC2 the I-line size is advertised differently
depending on the cluster? This really shouldn't be the case.

Will
