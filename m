From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 7 Mar 2015 10:18:46 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150305115307.GA14093@leverpostej>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
Message-ID: <20150307091846.GN23367@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 11:53:08AM +0000, Mark Rutland wrote:
> If everyone else is happy with this using IRQF_NO_SUSPEND for now then
> don't let my comments above block this patch.

Yeah, I'm really not happy with NO_SUSPEND + enable_irq_wake().

I really want that combo to BUG/WARN -- esp. since there's so much cargo
culted crap out there.

We should make robust interfaces, not randomly toggle flags until it
mostly works by accident rather than by design -- which is what this
feels like.

And while I appreciate the watchdog use-case; I think the easiest
solution for now is to simply disable the wathdog over suspend until
we've come up with something that makes sense.

As it is, you need to 'suspend' the watchdog at some point anyhow; you
don't want that thing to wake you from whatever suspend state you're in.
