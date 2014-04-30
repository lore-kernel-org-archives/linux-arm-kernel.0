From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Apr 2014 20:11:26 +0200
Subject: [PATCH] arm64: mm: Create gigabyte kernel logical mappings where
 possible
In-Reply-To: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
References: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
Message-ID: <4217068.6LErVYxoHJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 April 2014 12:36:22 Steve Capper wrote:
> We have the capability to map 1GB level 1 blocks when using a 4K
> granule.
> 
> This patch adjusts the create_mapping logic s.t. when mapping physical
> memory on boot, we attempt to use a 1GB block if both the VA and PA
> start and end are 1GB aligned. This both reduces the levels of lookup
> required to resolve a kernel logical address, as well as reduces TLB
> pressure on cores that support 1GB TLB entries.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Hello,
> This patch has been tested on the FastModel for 4K and 64K pages.
> Also, this has been tested with Jungseok's 4 level patch.
> 
> I put in the explicit check for PAGE_SHIFT, as I am anticipating a
> three level 64KB configuration at some point.
> 
> With two level 64K, a PUD is equivalent to a PMD which is equivalent to
> a PGD, and these are all level 2 descriptors.
> 
> Under three level 64K, a PUD would be equivalent to a PGD which would
> be a level 1 descriptor thus may not be a block.
> 
> Comments/critique/testers welcome.

It seems like a great idea. I have to admit that I don't understand
the existing code, but what are the page sizes used here?

Does the code always use the largest possible page size, or does
it just use either small pages or 1G pages?

In combination with the contiguous page hint, we should be able
to theoretically support 4KB/64KB/2M/32M/1G/16G TLBs in any
combination for boot-time mappings on a 4K page size kernel,
or 64KB/1M/512M/8G on a 64KB page size kernel.

	Arnd
