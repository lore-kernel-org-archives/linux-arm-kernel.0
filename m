From: steve.capper@arm.com (Steve Capper)
Date: Tue, 2 Jan 2018 08:57:08 +0000
Subject: [PATCH V2 2/7] arm64: mm: Flip kernel VA space
In-Reply-To: <20171218214736.13761-3-steve.capper@arm.com>
References: <20171218214736.13761-1-steve.capper@arm.com>
 <20171218214736.13761-3-steve.capper@arm.com>
Message-ID: <20180102085708.jbmyhvambtu5b7pa@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 09:47:31PM +0000, Steve Capper wrote:
> Put the direct linear map in the lower addresses of the kernel VA range
> and everything else in the higher ranges.
> 
> This allows us to make room for an inline KASAN shadow that operates
> under both 48 and 52 bit kernel VA sizes. For example with a 52-bit VA,
> if KASAN_SHADOW_END < 0xFFF8000000000000 (it is in the lower addresses
> of the kernel VA range), this will be below the start of the minimum
> 48-bit kernel VA address of 0xFFFF000000000000.
> 
> We need to adjust:
>  *) KASAN shadow region placement logic,
>  *) KASAN_SHADOW_OFFSET computation logic,
>  *) virt_to_phys, phys_to_virt checks,
>  *) page table dumper.
> 
> These are all small changes, that need to take place atomically, so they
> are bundled into this commit.

I need to tweak this to include changes to the HYP map logic
(specifically change the first AND to an EOR).

Cheers,
-- 
Steve
