From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Aug 2009 16:44:52 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1250890146.29685.18.camel@david-laptop>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
Message-ID: <1251128692.28977.17.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-08-21 at 14:29 -0700, David Xiao wrote:
> The DDI0406A ARM V7 Architecture Reference Manual (section A3.4.1) seems
> to indicate that the exclusive monitor is tagging/matching the physical
> memory address accessed by the LDREX/STREX instructions.
> 
> And in the same document (section A3.4.5), it seems to suggest that the
> reason we need to do CLREX during the context switch is that because the
> IsExclusiveLocal() implementation does not have to do memory
> address/size check, but just the exclusive state check.

Yes, that's correct. And the reason we don't need this in interrupt
handlers is that we would never call a STREX without a preceding LDREX
or just a LDREX without a being followed by a STREX and interrupt
handlers are in the worst case nested rather than freely preemptible.

-- 
Catalin
