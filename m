From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jan 2015 11:45:55 +0000
Subject: [next-20150119]regression (mm)?
In-Reply-To: <20150120001643.7D15AA8@black.fi.intel.com>
References: <54BD33DC.40200@ti.com> <20150119174317.GK20386@saruman>
 <20150120001643.7D15AA8@black.fi.intel.com>
Message-ID: <20150120114555.GA11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 02:16:43AM +0200, Kirill A. Shutemov wrote:
> Better option would be converting 2-lvl ARM configuration to
> <asm-generic/pgtable-nopmd.h>, but I'm not sure if it's possible.

Well, IMHO the folded approach in asm-generic was done the wrong way
which barred ARM from ever using it.

By that, I mean that the asm-generic stuff encapsulates a pgd into a pud,
and a pud into a pmd:

typedef struct { pgd_t pgd; } pud_t;
typedef struct { pud_t pud; } pmd_t;

This, I assert, is the wrong way around.  Think about it when you have a
real 4 level page table structure - a single pgd points to a set of puds.
So, one pgd encapsulates via a pointer a set of puds.  One pud does not
encapsulate a set of pgds.

What we have on ARM is slightly different: because of the sizes of page
tables, we have a pgd entry which is physically two page table pointers.
However, there are cases where we want to access these as two separate
pointers.

So, we define pgd_t to be an array of two u32's, and a pmd_t to be a
single entry.  This works fine, we set the masks, shifts and sizes
appropriately so that the pmd code is optimised away, but leaves us with
the ability to go down to the individual pgd_t entries when we need to
(eg, for section mappings, writing the pgd pointers for page tables,
etc.)

I think I also ran into problems with:

#define pmd_val(x)                              (pud_val((x).pud))
#define __pmd(x)                                ((pmd_t) { __pud(x) } )

too - but it's been a very long time since the nopmd.h stuff was
introduced, and I last looked at it.

In any case, what we have today is what has worked for well over a decade
(and pre-dates nopmd.h), and I'm really not interested today in trying to
rework tonnes of code to make use of nopmd.h - especially as it will most
likely require nopmd.h to be rewritten too, and we now have real 3 level
page table support (which I have no way to test.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
