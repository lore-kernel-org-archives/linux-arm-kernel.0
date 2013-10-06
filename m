From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Oct 2013 23:41:50 +0100
Subject: [RFC] ARM: kernel: irq: Simplify allocation of stack frame
In-Reply-To: <1381098649-21417-1-git-send-email-joelf@ti.com>
References: <1381098649-21417-1-git-send-email-joelf@ti.com>
Message-ID: <20131006224150.GA25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 06, 2013 at 05:30:47PM -0500, Joel Fernandes wrote:
> On receiving IRQ exception in SVC mode, all the SVC mode registers are saved
> onto the stack very early on.
> 
> The stack frame allocation code for IRQ entry during SVC mode (svc_entry) is
> hard to read as 4-less is allocated initially only to be allocated later
> implicity using the mov r3, [sp, #-4]! instruction. We make code easier to read
> by allocating the 4 bytes on the stack frame in the beginning itself and remove
> all instances where 4 bytes is adjusted.

You omit to say that this results in saving one additional register
unnecessarily in the stmia.  We could use a stmib there instead which
would avoid that issue while keeping the rest of the change.
