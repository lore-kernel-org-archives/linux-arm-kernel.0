From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 22:23:01 +0200
Subject: [Linaro-mm-sig] [PATCH 6/8] drivers: add Contiguous Memory
	Allocator
In-Reply-To: <alpine.LFD.2.00.1107061459520.14596@xanadu.home>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107061831.59739.arnd@arndb.de>
	<alpine.LFD.2.00.1107061459520.14596@xanadu.home>
Message-ID: <201107062223.01940.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011 21:10:07 Nicolas Pitre wrote:
> If you get a highmem page, because the cache is VIPT, that page might 
> still be cached even if it wasn't mapped.  With a VIVT cache we must 
> flush the cache whenever a highmem page is unmapped.  There is no such 
> restriction with VIPT i.e. ARMv6 and above.  Therefore to make sure the 
> highmem page you get doesn't have cache lines associated to it, you must 
> first map it cacheable, then perform cache invalidation on it, and 
> eventually remap it as non-cacheable.  This is necessary because there 
> is no way to perform cache maintenance on L1 cache using physical 
> addresses unfortunately.  See commit 7e5a69e83b for an example of what 
> this entails (fortunately commit 3e4d3af501 made things much easier and 
> therefore commit 39af22a79 greatly simplified things).

Ok, thanks for the explanation. This definitely makes the highmem approach
much harder to get right, and slower. Let's hope then that Marek's approach
of using small pages for the contiguous memory region and changing their
attributes on the fly works out better than this.

	Arnd
