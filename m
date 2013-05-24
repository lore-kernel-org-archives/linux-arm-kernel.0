From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 12:20:29 +0100
Subject: [PATCH] ARM: at91: Fix: Change internal SRAM memory type to
 "MT_MEMORY_SO"
In-Reply-To: <B256D81BAE5131468A838E5D7A243641687BB93C@penmbx01>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
 <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
 <20130522001457.GA18614@n2100.arm.linux.org.uk>
 <B256D81BAE5131468A838E5D7A243641687BB93C@penmbx01>
Message-ID: <20130524112029.GW18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 07:11:04AM +0000, Yang, Wenyou wrote:
> The story is: for sama5d3x with Cortex-A5 core, if not so, when copying
> code snippet to the internal SRAM, then jump to run this code, but fail
> to run.

And that is where your mistake is - you forgot that you're working with
a CPU with harvard caches which will require some cache maintanence
between copying the code and executing it.

You want to look at flush_icache_range() rather than making this memory
strongly ordered.
