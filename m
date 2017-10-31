From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 31 Oct 2017 05:55:19 +0000
Subject: [PATCH v4 18/21] KVM: arm64: Handle RAS SErrors from EL1 on guest
 exit
In-Reply-To: <20171019145807.23251-19-james.morse@arm.com> (James Morse's
 message of "Thu, 19 Oct 2017 15:58:04 +0100")
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-19-james.morse@arm.com>
Message-ID: <867evb50ag.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19 2017 at  4:58:04 pm BST, James Morse <james.morse@arm.com> wrote:
> We expect to have firmware-first handling of RAS SErrors, with errors
> notified via an APEI method. For systems without firmware-first, add
> some minimal handling to KVM.
>
> There are two ways KVM can take an SError due to a guest, either may be a
> RAS error: we exit the guest due to an SError routed to EL2 by HCR_EL2.AMO,
> or we take an SError from EL2 when we unmask PSTATE.A from __guest_exit.
>
> For SError that interrupt a guest and are routed to EL2 the existing
> behaviour is to inject an impdef SError into the guest.
>
> Add code to handle RAS SError based on the ESR. For uncontained errors
> arm64_is_blocking_ras_serror() will panic(), these errors compromise
> the host too. All other error types are contained: For the 'blocking'
> errors the vCPU can't make progress, so we inject a virtual SError.
> We ignore contained errors where we can make progress as if we're lucky,
> we may not hit them again.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
