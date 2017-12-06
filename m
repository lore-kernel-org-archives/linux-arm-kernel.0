From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Dec 2017 17:25:51 +0000
Subject: [PATCH] arm64: kvm: Prevent restoring stale PMSCR_EL1 for vcpu
In-Reply-To: <1512580189-5921-1-git-send-email-julien.thierry@arm.com>
References: <1512580189-5921-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20171206172551.GD25408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 05:09:49PM +0000, Julien Thierry wrote:
> When VHE is not present, KVM needs to save and restores PMSCR_EL1 when
> possible. If SPE is used by the host, value of PMSCR_EL1 cannot be saved
> for the guest.
> If the host starts using SPE between two save+restore on the same vcpu,
> restore will write the value of PMSCR_EL1 read during the first save.
> 
> Make sure __debug_save_spe_nvhe clears the value of the saved PMSCR_EL1
> when the guest cannot use SPE.

Ok, so the problem is that we have a stale (non-zero) saved pmscr_el1,
and therefore the restore code unconditionally restores that even though
SPE is no longer in use by the host. Well spotted!

> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm64/kvm/hyp/debug-sr.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
