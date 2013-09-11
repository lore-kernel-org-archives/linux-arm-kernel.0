From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 11 Sep 2013 19:06:06 +0100
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2 page
 fault
In-Reply-To: <1378806670-2467-1-git-send-email-marc.zyngier@arm.com>
References: <1378806670-2467-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAFEAcA_xWvZa3fizTNPfaH97V02Ktvrn2EPq-UkA2B-YsMnHzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 September 2013 10:51, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Anup Patel recently brought up the fact that when we run a guest
> with cache disabled, we don't flush the cache to the Point of
> Coherency, hence possibly missing bits of data that have been
> written in the cache, but have not reached memory.
>
> There are several approaches to this issue:
> - Using the DC bit when caches are off: this breaks guests assuming
>   caches off while doing DMA operations. Bootloaders, for example.
> - Fetch the memory attributes on translation fault, and flush the
>   cache while handling the fault. This relies on using the PAR_EL1
>   register to obtain the Stage-1 memory attributes.
>
> While this second solution is clearly not ideal (it duplicates what
> the HW already does to generate HPFAR_EL2), it is more correct than
> not doing anything.

Are you confident that extending the current very limited
set of circumstances where we re-do the address translation
operation doesn't introduce any new races if the guest
page tables change between taking the fault and redoing
the translation? I remember being this a pain to think through
last time around :-)

thanks
-- PMM
