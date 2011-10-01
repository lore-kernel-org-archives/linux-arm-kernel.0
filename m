From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 17:35:11 +0100
Subject: [PATCH] Add missing include of linux/ftrace.h
In-Reply-To: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
References: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111001163511.GI11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 04:13:22PM +0100, Jamie Iles wrote:
> __exception_irq_entry uses __irq_entry which is defined in
> linux/ftrace.h.
> 
> Reported-by: Zoltan Devai <zdevai@gmail.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

This introduces a circular dependency:

linux/ftrace.h -> linux/kallsyms.h -> linux/kernel.h -> linux/bitops.h
 -> asm/bitops.h -> asm/system.h -> linux/ftrace.h

This is not good as it means that we end up with indeterminant effects
happening depending on where in that cycle the first include happens.
