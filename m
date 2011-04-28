From: pullip.cho@samsung.com (KyongHo Cho)
Date: Thu, 28 Apr 2011 16:24:30 +0900
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1303940737.2513.190.camel@pasglop>
References: <201104212129.17013.arnd@arndb.de>
	<BANLkTinPbZZS9F1tRCA73fgoD-y__jSfCA@mail.gmail.com>
	<1303940737.2513.190.camel@pasglop>
Message-ID: <BANLkTi=8fh97S00HwcCvXe84v=0i+BQ74Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 6:45 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Don't you have a risk where speculative loads or prefetches might bring
> back some stuff into the cache via the cachable mapping ? Is that an
> issue ? As long as it's non-dirty and the cachable mapping isn't
> otherwise used, I suppose it might be a non-issue, tho I've seen in
> powerpc land cases of processors that can checkstop if a subsequent non
> cachable access "hits" the stuff that was loaded in the cache.
>
> Cheers,
> Ben.
>
As far as I know, ARM processors does not have the capability
to detect non-cacheable access hits the stuff in  the cache.

IMHO, speculative prefetch becomes a problem
when a coherent buffer (that is not-cacheable in ARM) is modified by a
DMA transaction
while old data is already loaded in the cache via another cacheable
mapping onto the buffer
even though it is never touched by CPU.
We can avoid this problem if the kernel removes 'executable' property
from the cacheable mapping.
But it is not able to modify page table entries in the direct mapping area.

Regards,
KyongHo
