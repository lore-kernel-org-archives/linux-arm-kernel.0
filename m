From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Dec 2014 18:24:43 +0000
Subject: using DMA-API on ARM
In-Reply-To: <20141205173839.GB31222@e104818-lin.cambridge.arm.com>
References: <5481794E.4050406@broadcom.com> <4565667.WCBuNmaazQ@wuerfel>
 <20141205111114.GQ11285@n2100.arm.linux.org.uk>
 <20141205173839.GB31222@e104818-lin.cambridge.arm.com>
Message-ID: <20141205182443.GX11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 05:38:39PM +0000, Catalin Marinas wrote:
> On Fri, Dec 05, 2014 at 11:11:14AM +0000, Russell King - ARM Linux wrote:
> > In any case, wouldn't using a u64 type for "address" be better - isn't
> > "long long" 128-bit on 64-bit architectures?
> 
> No, it's still 64-bit. There is no 128-bit integer in the C standard.

Actually, that's a fallicy.

The C99 standard (like previous versions) does not define exactly the
number of bits in each type.  It defines ranks of type, and says that
lower ranks are a subrange of integers with higher ranks (for the same
signed-ness.)  See section 6.2.5.

So, it merely states that:

range(char) <= range(short) <= range(int) <= range(long) <= range(long long)

So, an implementation could have:

char: 8  short: 16 int: 16 long: 32 long long: 64
char: 8  short: 16 int: 32 long: 32 long long: 64
char: 8  short: 16 int: 32 long: 64 long long: 64
char: 8  short: 16 int: 64 long: 64 long long: 64

or even:

char: 8  short: 16 int: 32 long: 64 long long: 128

and that would still be compliant with C99, since it continues to meet
the criteria about the required data types specified in the standard.

-- 
FTTC broadband for 0.8mile line: currently@9.5Mbps down 400kbps up
according to speedtest.net.
