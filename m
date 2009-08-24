From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 24 Aug 2009 22:12:32 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
Message-ID: <20090824211232.GA9150@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> BTW, some time ago I sent a patch to clear the exclusive monitor at
> every exception entry (interrupt, aborts etc.) but wasn't accepted. The
> main reason for that was to be able to only use STR for atomic_set()
> rather than the combination of LDREX/STREX we have now.

Would CLREX+STR work, and would it be an improvement?

> A similar reason for STR used in application signal handlers which
> are usually invoked without a __switch_to call (unless the signal
> handler is in a different application from the running one).

How about adding CLREX to the signal handling path?  Not exception
entry, but the part which sets up the signal frame.

If userspace can use STR for atomic_set normally, it's quite obscure
(and very difficult to detect) that that's fine everywhere except in
signal handlers, and even more obscure if it means siglongjmp() and
setcontext() can cause unrelated atomic ops to fail.

-- Jamie
