From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:39:03 +0100
Subject: [PATCH v4 10/40] KVM: arm64: Slightly improve debug save/restore
 functions
In-Reply-To: <20180215210332.8648-11-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-11-christoffer.dall@linaro.org>
Message-ID: <20180221173903.xlpwnlrnjlpatm5s@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:02PM +0100, Christoffer Dall wrote:
> The debug save/restore functions can be improved by using the has_vhe()
> static key instead of the instruction alternative.  Using the static key
> uses the same paradigm as we're going to use elsewhere, it makes the
> code more readable, and it generates slightly better code (no
> stack setups and function calls unless necessary).
> 
> We also use a static key on the restore path, because it will be
> marginally faster than loading a value from memory.
> 
> Finally, we don't have to conditionally clear the debug dirty flag if
> it's set, we can just clear it.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v1:
>      - Change dot to comma in comment
>      - Rename __debug_restore_spe to __debug_restore_spe_nvhe
> 
>  arch/arm64/kvm/hyp/debug-sr.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>

Maybe after this series is merged, if there are any hyp_alternate_select's
left, we can replace all the remaining ones with has_vhe() and then just
completely remove hyp_alternate_select.

Reviewed-by: Andrew Jones <drjones@redhat.com>
