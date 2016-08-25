From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 16:30:25 +0100
Subject: [PATCH v6 2/3] arm64: vmlinux.ld: Add mmuoff data sections and
 move mmuoff text into idmap
In-Reply-To: <1472059650-591-3-git-send-email-james.morse@arm.com>
References: <1472059650-591-1-git-send-email-james.morse@arm.com>
 <1472059650-591-3-git-send-email-james.morse@arm.com>
Message-ID: <20160825153024.GI20748@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 06:27:29PM +0100, James Morse wrote:
> Resume from hibernate needs to clean any text executed by the kernel with
> the MMU off to the PoC. Collect these functions together into the
> .idmap.text section as all this code is tightly coupled and also needs
> the same cleaning after resume.
> 
> Data is more complicated, secondary_holding_pen_release is written with
> the MMU on, clean and invalidated, then read with the MMU off. In contrast
> __boot_cpu_mode is written with the MMU off, the corresponding cache line
> is invalidated, so when we read it with the MMU on we don't get stale data.
> These cache maintenance operations conflict with each other if the values
> are within a Cache Writeback Granule (CWG) of each other.
> Collect the data into two sections .mmuoff.data.read and .mmuoff.data.write,
> the linker script ensures mmuoff.data.write section is aligned to the
> architectural maximum CWG of 2KB.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
