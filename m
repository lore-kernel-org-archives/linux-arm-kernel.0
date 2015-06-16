From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Jun 2015 17:49:15 +0100
Subject: [PATCH v2 01/11] KVM: arm: plug guest debug exploit
In-Reply-To: <557DA811.8090705@linaro.org>
References: <1433046432-1824-1-git-send-email-zhichao.huang@linaro.org>
 <1433046432-1824-2-git-send-email-zhichao.huang@linaro.org>
 <556C3A68.8050903@arm.com> <557449EA.7040003@linaro.org>
 <5576BFF7.3070706@arm.com> <557DA6E4.7090609@linaro.org>
 <557DA811.8090705@linaro.org>
Message-ID: <20150616164914.GM30522@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 14, 2015 at 05:13:05PM +0100, zichao wrote:
> I and marc are talking about how to plug the guest debug exploit in an
> easier way.
> 
> I remembered that you mentioned disabling monitor mode had proven to be
> extremely fragile in practice on 32-bit ARM SoCs, what if I save/restore
> the debug monitor mode on each switch between the guest and the host,
> would it be acceptable?

If you're just referring to DBGDSCRext, then you could give it a go, but
you'll certainly want to predicate any writes to that register on whether
or not hw_breakpoint managed to reset the debug regs on the host.

Like I said, accessing these registers always worries me, so I'd really
avoid it in KVM if you can. If not, you'll need to do extensive testing
on a bunch of platforms with and without the presence of external debug.

Will
