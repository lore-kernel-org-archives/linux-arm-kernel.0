From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Oct 2015 17:22:07 +0100
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <029601d1011a$026e1000$074a3000$@samsung.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <029601d1011a$026e1000$074a3000$@samsung.com>
Message-ID: <561546AF.90903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 17:05, Pavel Fedin wrote:
>  Hello!
> 
>  One more concern about the whole thing. I already replied to the previous series, but looks like my
> reply was missed.
>  Your implementation does not care about live migration at all. And there's one fundamental issue
> with it. In the redistributor LPIs can be only pending, but in the CPU interface they still can be
> active. And they have priorities, therefore they can be preempted, so we can have even more than one
> active LPI at once. How to migrate this state?
>  Here i am trying to prototype this by leaving active interrupts in LRs and allowing the userland to
> read/write them. This looks a bit stupid, additionally this will create problems if we are e. g.
> migrating from host with 8 LRs to host with 4 LRs, while having 6 active LPIs. Can anybody suggest
> better solution?
>  Technically LPI pending table has unused bits from 0 to 8191, and we have 8192 LPIs, so we could
> push active state there, just for migration. Would this be a big violation of specification? It says
> nothing about these bits at all.

LPIs do not have an active state, at the redistributor or otherwise.

	M.
-- 
Jazz is not dead. It just smells funny...
