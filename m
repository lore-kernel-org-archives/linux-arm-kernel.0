From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2012 11:43:10 +0100
Subject: [PATCH 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <1345799361-23735-4-git-send-email-gregory.clement@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
 <1345799361-23735-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120824104309.GE5400@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 10:09:18AM +0100, Gregory CLEMENT wrote:
> +static void __init aurora_broadcast_l2_commands(void)
> +{
> +       __u32 u;
> +       /* Enable Broadcasting of cache commands to L2*/
> +       __asm__ __volatile__("mrc p15, 1, %0, c15, c2, 0" : "=r"(u));
> +       u |= 0x100;             /* Set the FW bit */
> +       __asm__ __volatile__("mcr p15, 1, %0, c15, c2, 0\n" : : "r"(u));
> +}

Couple of questions about this code:

1. Is this register r/w from non-secure?
2. I'm surprised that there aren't barriers and/or maintenance operations
   needed around this operation. It might be worth checking in the
   documentation that you have (you probably need at least an isb()
   following the mcr).

Will
