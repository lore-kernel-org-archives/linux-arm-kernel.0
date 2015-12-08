From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Dec 2015 12:06:26 +0000
Subject: ARM64: kernel oops in 4.4-rc4+
In-Reply-To: <20151208105152.GB19612@arm.com>
References: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
 <20151208103013.GA19612@arm.com> <20151208105152.GB19612@arm.com>
Message-ID: <20151208120625.GA26759@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 10:51:52AM +0000, Will Deacon wrote:
> On Tue, Dec 08, 2015 at 10:30:13AM +0000, Will Deacon wrote:
> > On Tue, Dec 08, 2015 at 02:30:33PM +0800, Ming Lei wrote:
> > > The attached kernel oops can be triggered immediately after
> > > running the following command on APM Mustang:
> > > 
> > >         $stress-ng --all 8 -t 10m
> > > 
> > > [1] kernel oops log
> > > stress-ng: info:  [5220] 5 failures reached, aborting stress process
> > > [  265.782659] kernel BUG at ./arch/arm64/include/asm/pgtable.h:282!
> > 
> > Yikes, this means we're replacing a writable pte with a clean pte, so
> > there's a potential race w/ hardware DBM.
> > 
> > Could you dump pte and *ptep please?
> 
> I tried running this on my Juno and pretty quickly saw the OOM killer
> coming in. Perhaps, in your case, pte is a swap entry and its confusing
> the checks (so pte_dirty/pte_young are looking at random bits of the
> file offset)?

It could indeed be that the new pte is swap or file and the check misses
that. The easiest is to move the check inside the if (pte_valid_user(pte))
block:

--------------8<------------------------
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e074f93f383..12d89ee5ab7f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -269,17 +269,17 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			pte_val(pte) &= ~PTE_RDONLY;
 		else
 			pte_val(pte) |= PTE_RDONLY;
-	}
 
-	/*
-	 * If the existing pte is valid, check for potential race with
-	 * hardware updates of the pte (ptep_set_access_flags safely changes
-	 * valid ptes without going through an invalid entry).
-	 */
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
-	    pte_valid(*ptep)) {
-		BUG_ON(!pte_young(pte));
-		BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
+		/*
+		 * If the existing pte is valid, check for potential race with
+		 * hardware updates of the pte (ptep_set_access_flags safely
+		 * changes valid ptes without going through an invalid entry).
+		 */
+		if (IS_ENABLED(CONFIG_DEBUG_VM) && IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
+		    pte_valid(*ptep)) {
+			BUG_ON(!pte_young(pte));
+			BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
+		}
 	}
 
 	set_pte(ptep, pte);
--------------8<------------------------

-- 
Catalin
