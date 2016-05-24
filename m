From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 May 2016 14:49:31 +0200
Subject: [PATCH 6/7] arm64: KVM: vgic-v3: Prevent the guest from messing
 with ICC_SRE_EL1
In-Reply-To: <1464007023-11736-7-git-send-email-marc.zyngier@arm.com>
References: <1464007023-11736-1-git-send-email-marc.zyngier@arm.com>
 <1464007023-11736-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160524124931.GF3582@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 01:37:02PM +0100, Marc Zyngier wrote:
> Both our GIC emulations are "strict", in the sense that we either
> emulate a GICv2 or a GICv3, and not a GICv3 with GICv2 legacy
> support.
> 
> But when running on a GICv3 host, we still allow the guest to
> tinker with the ICC_SRE_EL1 register during its time slice:
> it can switch SRE off, observe that it is off, and yet on the
> next world switch, find the SRE bit to be set again. Not very
> nice.
> 
> An obvious solution is to always trap accesses to ICC_SRE_EL1
> (by clearing ICC_SRE_EL2.Enable), and to let the handler return
> the programmed value on a read, or ignore the write.
> 
> That way, the guest can always observe that our GICv3 is SRE==1
> only.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
