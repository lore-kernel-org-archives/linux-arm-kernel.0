From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 28 May 2015 15:04:21 +0200
Subject: [PATCH] arm/arm64: KVM: Propertly account for guest CPU time
In-Reply-To: <1432817349-17917-1-git-send-email-christoffer.dall@linaro.org>
References: <1432817349-17917-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20150528130421.GE18009@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 02:49:09PM +0200, Christoffer Dall wrote:
> Until now we have been calling kvm_guest_exit after re-enabling
> interrupts when we come back from the guest, but this has the
> unfortunate effect that CPU time accounting done in the context of timer
> interrupts doesn't properly notice that the time since the last tick was
> spent in the guest.
> 
> Inspired by the comment in the x86 code, simply move the
> kvm_guest_exit() call below the local_irq_enable() call and change
> __kvm_guest_exit() to kvm_guest_exit(), because we are now calling this
> function with interrupts enabled.  Note that AFAIU we don't need an
> explicit barrier like x86 because the arm/arm64 implementation of
> local_irq_(en/dis)able has an implicit barrier.
> 
> At the same time, move the trace_kvm_exit() call outside of the atomic
> section, since there is no reason for us to do that with interrupts
> disabled.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> This patch is based on kvm/queue, because it has the kvm_guest_enter/exit
> rework recently posted by Christian Borntraeger.  I hope I got the logic
> of this wrong, there were 2 slightly worrying facts about this:

Of course this should have been:

"I hope I got the logic of this *right*, but there..."

Damn it!
-Christoffer
