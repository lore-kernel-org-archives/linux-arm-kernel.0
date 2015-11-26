From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 23:37:20 +0000
Subject: armv7 + lpae broken in 4.1.12+ ?
In-Reply-To: <5657952E.906@heeltoe.com>
References: <5657952E.906@heeltoe.com>
Message-ID: <20151126233720.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 06:26:38PM -0500, Brad Parker wrote:
> I found that the pte entries were garbage, which really confused me.  I
> finally discovered that the code in proc-v7-3level.S expects data in r0, r2
> & r3, but in fact it comes in on r0, r1 & r2.

This seems wrong.  If you're building LPAE, then you should have AEABI
enabled, which means you're using EABI.  (ARM_LPAE should depend on
AEABI, but it doesn't.)

EABI places 64-bit arguments in an even/odd register pair.  So:

void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);

ptep is in r0, and if pte_t is 64-bit, then pte is passed in r2 and r3.
Not r1 and r2.  ext is passed on the stack.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
