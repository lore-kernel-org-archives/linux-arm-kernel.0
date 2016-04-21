From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Apr 2016 17:18:59 +0100
Subject: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
In-Reply-To: <44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
Message-ID: <20160421161859.GK929@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 06:13:00PM +0100, Robin Murphy wrote:
> Whilst commit 9439eb3ab9d1 ("asm-generic: io: implement relaxed
> accessor macros as conditional wrappers") makes the *_relaxed forms of
> I/O accessors universally available to drivers, in cases where writeq()
> is implemented via the io-64-nonatomic helpers, writeq_relaxed() will
> end up falling back to writel() regardless of whether writel_relaxed()
> is available (identically for s/write/read/).
> 
> Add corresponding relaxed forms of the nonatomic helpers to delegate
> to the equivalent 32-bit accessors as appropriate.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Darren Hart <dvhart@linux.intel.com>
> CC: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/io-64-nonatomic-hi-lo.h | 25 +++++++++++++++++++++++++
>  include/linux/io-64-nonatomic-lo-hi.h | 25 +++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
> index 11d7e84..1a85566 100644
> --- a/include/linux/io-64-nonatomic-hi-lo.h
> +++ b/include/linux/io-64-nonatomic-hi-lo.h
> @@ -21,6 +21,23 @@ static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
>  	writel(val, addr);
>  }
>  
> +static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
> +{
> +	const volatile u32 __iomem *p = addr;
> +	u32 low, high;
> +
> +	high = readl_relaxed(p + 1);
> +	low = readl_relaxed(p);
> +
> +	return low + ((u64)high << 32);
> +}
> +
> +static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
> +{
> +	writel_relaxed(val >> 32, addr + 4);
> +	writel_relaxed(val, addr);
> +}

Could we not generate the _relaxed variants with some macro magic?

Will
