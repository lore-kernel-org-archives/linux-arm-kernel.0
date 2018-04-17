From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Tue, 17 Apr 2018 10:37:32 +0100
Subject: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
In-Reply-To: <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
Message-ID: <1523957852.3250.9.camel@HansenPartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-17 at 00:08 -0400, Sinan Kaya wrote:
> parisc architecture seems to be mapping readX() and readX_relaxed()
> APIs
> to __raw_readX() API.
> 
> __raw_readX() API doesn't provide any kind of ordering guarantees.
> commit 032d59e1cde9 ("io: define stronger ordering for the default
> readX()
> implementation") changed asm-generic implementation to use a more
> conservative approach towards the readX() API.

I don't follow your logic here.  function calls (even inline ones) are
sequence points and the compiler guarantees volatile variables are
stable before sequencing, so these two rules strictly compile order the
raw_read/write because the address is volatile.

> Place a barrier() after the register read so that compiler doesn't
> optimize across the regiter operation.

barrier() provides exactly the same guarantees as the sequence
point/volatile already above, so it seems to be completely unnecessary.

Perhaps if you gave an example of the actual problem you're trying to
fix we could assess if it affects parisc.

James


> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
> ?arch/parisc/include/asm/io.h | 23 +++++++++++++++++++----
> ?1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/io.h
> b/arch/parisc/include/asm/io.h
> index 2ec6405..e04c4ef 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -179,19 +179,34 @@ static inline void __raw_writeq(unsigned long
> long b, volatile void __iomem *add
> ?
> ?static inline unsigned char readb(const volatile void __iomem *addr)
> ?{
> -	return __raw_readb(addr);
> +	unsigned char ret;
> +
> +	ret = __raw_readb(addr);
> +	barrier();
> +	return ret;
> ?}
> ?static inline unsigned short readw(const volatile void __iomem
> *addr)
> ?{
> -	return le16_to_cpu((__le16 __force) __raw_readw(addr));
> +	unsigned short ret;
> +
> +	ret = le16_to_cpu((__le16 __force) __raw_readw(addr));
> +	barrier();
> +	return ret;
> ?}
> ?static inline unsigned int readl(const volatile void __iomem *addr)
> ?{
> -	return le32_to_cpu((__le32 __force) __raw_readl(addr));
> +	unsigned int ret;
> +	ret = le32_to_cpu((__le32 __force) __raw_readl(addr));
> +	barrier();
> +	return ret;
> ?}
> ?static inline unsigned long long readq(const volatile void __iomem
> *addr)
> ?{
> -	return le64_to_cpu((__le64 __force) __raw_readq(addr));
> +	unsigned long long ret;
> +
> +	ret = le64_to_cpu((__le64 __force) __raw_readq(addr));
> +	barrier();
> +	return ret;
> ?}
> ?
> ?static inline void writeb(unsigned char b, volatile void __iomem
> *addr)
