From: geoff@infradead.org (Geoff Levand)
Date: Fri, 13 Dec 2013 16:20:23 -0800
Subject: [PATCH 4/5] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <20131213164958.GO19177@mudshark.cambridge.arm.com>
References: <cover.1386879684.git.geoff@infradead.org>
 <51cf7ba0aab8ae3677673cab65ec560d78a645ce.1386879684.git.geoff@infradead.org>
 <20131213164958.GO19177@mudshark.cambridge.arm.com>
Message-ID: <1386980423.1002.95.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Will,

On Fri, 2013-12-13 at 16:49 +0000, Will Deacon wrote:
> On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> > Add missing AT() macros to vmlinux.lds to generate the sections
> > properly.  Some elf file tools expect correct paddr values in
> > vmlinux.
> > 
> > Fixes bad paddr values written to vmlinux like these:
> > 
> >   Program Header:
> >     LOAD off 0x0000000000010000 vaddr 0xffffffc000080000 paddr 0xffffffc000080000 align 2**16
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> > ---
> >  arch/arm64/kernel/vmlinux.lds.S | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 6563b64..065fe40d 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -48,11 +48,11 @@ SECTIONS
> >  
> >  	. = PAGE_OFFSET + TEXT_OFFSET;
> >  
> > -	.head.text : {
> > +	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
> 
> Since LOAD_OFFSET is PAGE_OFFSET, does this assume that physical memory
> starts at 0x0?

Well, LOAD_OFFSET defaults to zero, so as of this patch, no, but
please see my comments to patch 5/5 (arm64: Add LOAD_OFFSET
symbol for linker scripts) where I do set LOAD_OFFSET...

The pre-defined macros from include/asm-generic/vmlinux.lds.h that we
use in our arm64 vmlinux.lds.S, like INIT_TEXT_SECTION() and BSS_SECTION(),
are all constructed using AT().  This patch is really just making all
the sections in the arm64 linker script consistent.  As I mentioned, when
LOAD_OFFSET is zero not having AT() macros on some sections doesn't cause
problems, but if LOAD_OFFSET is non-zero then some sections are not located
correctly resulting in a link error.

-Geoff
