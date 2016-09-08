From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 8 Sep 2016 11:44:28 +0200
Subject: [PATCH 00/19] Handle guest-generated SErrors/Aborts
In-Reply-To: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160908094428.GW23592@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 02:01:58PM +0100, Marc Zyngier wrote:
> A little known "feature" of giving guest access to real memory mapped
> HW is that it could trigger asynchronous aborts (SError on ARMv8) if
> the guest accesses it in a non-conventional way (and depending on how
> HW and firmware have been integrated). So far, KVM lacks any support
> to handle this gracefully.
> 
> This series introduces a set of mechanisms to catch such a fault and
> deliver a vSError (or Virtual Abort for 32bit) to the offending vcpu.
> 
> These aborts can either trigger at EL1 (whilst the guest is running),
> or at EL2 (during the handling of an exit). The first case is pretty
> easy to handle (use the ad-hoc vectors on arm64, or decode the EA bit
> on arm), but the second one is a bit more fiddly, as we need to ensure
> that the exception is pending by the time we unmask it. This is
> achived by using some heavy DSBs on the hot path, with the following
> caveats:
> 
> - I've only been able to trigger the EL2 handling on A57 (Seatle,
>   Juno).
> - I've measured a 40/50 cycles hit on Juno (A57), but I haven't
>   measured the impact on bigger systems
> 
> The last patch of this series adds a missing feature to the
> GICV-proxying series, delivering a vSError to a guest that performed
> an illegal access to the GIC.
> 
> Patches on top of current kvmarm/queue + the GICV przying series.

przying?  proxying?  Or something in Polish perhaps?

For the series:
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Applied, thanks.
-Christoffer
