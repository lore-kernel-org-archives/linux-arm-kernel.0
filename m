From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Jan 2017 14:51:12 +0000
Subject: [RFC] tty: pl011: Work around stuck BUSY bit on QDF2400
In-Reply-To: <20170130234417.20855-1-cov@codeaurora.org>
References: <20170130234417.20855-1-cov@codeaurora.org>
Message-ID: <20170131145112.GF22283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 06:44:17PM -0500, Christopher Covington wrote:
> N.B. I'm not confident that this patch is ready to be included as-is.
> Rather I'm hoping for guidance from reviewers and maintainers on
> broad implementation choices--whether A) the bitmask of flags to invert
> makes sense or B) vendor-specific is_busy() function pointers or C)
> hot-patching using the alternatives framework or D) some other
> approach would be best.
> 
> The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
> custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
> BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
> and 2400v1 SoCs. Checking that the Transmit FIFO Empty (TXFE) bit is 0,
> instead of checking that the BUSY bit is 1, works around the issue. To
> facilitate this substitution, introduce vendor-specific inversion of
> Feature Register bits.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> Based on https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
> ---
>  Documentation/arm64/silicon-errata.txt |  2 ++
>  arch/arm64/Kconfig                     | 11 +++++++++
>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>  arch/arm64/include/asm/cputype.h       |  2 ++
>  arch/arm64/kernel/cpu_errata.c         | 16 +++++++++++++

This isn't a bug in the CPU, so please don't reuse the CPU errata code to
workaround it. You can handle it all privately in the pl011 driver, but
do keep the update to silicon-errata.txt.

Will
