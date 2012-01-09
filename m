From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 14:12:14 +0000
Subject: [PATCH v4 2/2] dma/imx-sdma: convert _raw_readl/_raw_writel to
 readl/writel
In-Reply-To: <CAMPhdO84p=0D3KrrFnwup4igoh4oNWXOCbW+BOkoRiC8m=JnmQ@mail.gmail.com>
References: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
 <1326033862-25351-3-git-send-email-richard.zhao@linaro.org>
 <20120109115143.GL21765@n2100.arm.linux.org.uk>
 <CAMPhdO84p=0D3KrrFnwup4igoh4oNWXOCbW+BOkoRiC8m=JnmQ@mail.gmail.com>
Message-ID: <20120109141214.GP21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 09:25:12PM +0800, Eric Miao wrote:
> Does this also mean when endian conversion is not necessary, the __raw_*
> version will be better here? Or generally the _relaxed variants are more
> recommended as endian conversion will be optimized away anyway with
> these AMBA accesses as both sides are little-endian?

Useless endian conversions are always optimized away.  Here's the
definitions:

If your CPU is operating in little endian mode, for 32-bit and 16-bit:

#define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
#define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
#define __cpu_to_le16(x) ((__force __le16)(__u16)(x))
#define __le16_to_cpu(x) ((__force __u16)(__le16)(x))

So these are just casts to keep sparse happy and able to check this stuff.

#define __cpu_to_be32(x) ((__force __be32)__swab32((x)))
#define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
#define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
#define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))

These do the endian conversion.

If your CPU is running in big endian mode:

#define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
#define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
#define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))

So these do the endian conversion, and:

#define __cpu_to_be32(x) ((__force __be32)(__u32)(x))
#define __be32_to_cpu(x) ((__force __u32)(__be32)(x))
#define __cpu_to_be16(x) ((__force __be16)(__u16)(x))
#define __be16_to_cpu(x) ((__force __u16)(__be16)(x))

These are just casts.
