From: kmcmarti@redhat.com (Kyle McMartin)
Date: Fri, 27 Mar 2015 13:40:44 -0400
Subject: [RFC v2 0/5] arm64: kvm: reset hyp context for kexec
In-Reply-To: <55157920.3050003@arm.com>
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
 <20150327153131.GK12400@redacted.bos.redhat.com>
 <55157920.3050003@arm.com>
Message-ID: <20150327174044.GL12400@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 03:37:04PM +0000, Marc Zyngier wrote:
> > [  236.260863] Kernel panic - not syncing: HYP panic:
> > [  236.260863] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006
> 
> It would be interesting if you could find out what you have at offset
> 0x830 of hyp-init.o (the stack trace is for EL1, and is not going to
> help much).
> 

Given the alignment, i'm going to assume i'm looking at the right thing:

0000000000000820 <__kvm_hyp_reset>:
     820:       d51c2000        msr     ttbr0_el2, x0
     824:       d5033fdf        isb
     828:       d50c871f        tlbi    alle2
     82c:       d5033f9f        dsb     sy
     830:       10000060        adr     x0, 83c <__kvm_hyp_reset+0x1c>
     834:       b3403c01        bfxil   x1, x0, #0, #16
     838:       d61f0020        br      x1
     83c:       d53c1000        mrs     x0, sctlr_el2

but it seems fairly implausible to be trapping on ADR x0, 1f...

--Kyle
