From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Sep 2016 15:20:51 +0100
Subject: [PATCH] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <20160912125710.GA13899@leverpostej>
References: <1473604714-5512-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160912125710.GA13899@leverpostej>
Message-ID: <20160912142051.GB2492@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 01:57:10PM +0100, Mark Rutland wrote:
> On Sun, Sep 11, 2016 at 03:38:34PM +0100, Ard Biesheuvel wrote:
> > Move the statically allocated zero page from the .bss section to right
> > before swapper_pg_dir. This allows us to refer to its physical address
> > by simply reading TTBR1_EL1 (which always points to swapper_pg_dir and
> > always has its ASID field cleared), and subtracting PAGE_SIZE.
> 
> On a conflicting note, I was hoping to move the zero page into .rodata
> so as to catch any erroneous modification.
> 
> Given that we can't rely on TTBR1 poiting at the swapper_pg_dir, that
> leaves us with Image size reduction vs RO-ification.

I think zero page in .rodata + reserved_ttbr0 would increase the image
size by 2 pages vs current mainline. That's not much but I'm not sure
it's worth; we have other types of writable data with security
implications, probably more than the zero page.

-- 
Catalin
