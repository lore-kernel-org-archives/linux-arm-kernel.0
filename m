From: msalter@redhat.com (Mark Salter)
Date: Mon, 28 Apr 2014 15:44:57 -0400
Subject: [PATCH] arm64: fixmap: fix missing sub-page offset for earlyprintk
In-Reply-To: <1398711006-14943-1-git-send-email-marc.zyngier@arm.com>
References: <1398711006-14943-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1398714297.3010.79.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-28 at 19:50 +0100, Marc Zyngier wrote:
> Commit d57c33c5daa4 (add generic fixmap.h) added (among other
> similar things) set_fixmap_io to deal with early ioremap of devices.
> 
> More recently, commit bf4b558eba92 (arm64: add early_ioremap support)
> converted the arm64 earlyprintk to use set_fixmap_io. A side effect of
> this conversion is that my virtual machines have stopped booting when
> I pass "earlyprintk=uart8250-8bit,0x3f8" to the guest kernel.
> 
> Turns out that the new earlyprintk code doesn't care at all about
> sub-page offsets, and just assumes that the earlyprintk device will
> be page-aligned. Obviously, that doesn't play well with the above example.
> 
> Further investigation shows that set_fixmap_io uses __set_fixmap instead
> of __set_fixmap_offset. A fix is to introduce a set_fixmap_offset_io that
> uses the latter, and to remove the superflous call to fix_to_virt
> (which only returns the value that set_fixmap_io has already given us).
> 
> With this applied, my VMs are back in business. Tested on a Cortex-A57
> platform with kvmtool as platform emulation.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Mark Salter <msalter@redhat.com>
