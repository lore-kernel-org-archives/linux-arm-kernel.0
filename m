From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Aug 2009 09:33:50 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <20090824211232.GA9150@shareable.org>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<20090824211232.GA9150@shareable.org>
Message-ID: <1251189230.15678.9.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-08-24 at 22:12 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > BTW, some time ago I sent a patch to clear the exclusive monitor at
> > every exception entry (interrupt, aborts etc.) but wasn't accepted. The
> > main reason for that was to be able to only use STR for atomic_set()
> > rather than the combination of LDREX/STREX we have now.
> 
> Would CLREX+STR work, and would it be an improvement?

IMHO, yes. You use CLREX at every exception entry and make the
atomic_set() function simply use STR. But the argument was that
atomic_set() isn't used very often anyway.

> > A similar reason for STR used in application signal handlers which
> > are usually invoked without a __switch_to call (unless the signal
> > handler is in a different application from the running one).
> 
> How about adding CLREX to the signal handling path?  Not exception
> entry, but the part which sets up the signal frame.

Yes, that's the solution, only that I've never had the time to revisit
it and send another patch.

-- 
Catalin
