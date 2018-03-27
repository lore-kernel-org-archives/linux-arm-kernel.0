From: bp@alien8.de (Borislav Petkov)
Date: Tue, 27 Mar 2018 19:25:10 +0200
Subject: [PATCH 02/11] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <5AAFC939.3010309@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-3-james.morse@arm.com>
 <20180301150144.GA4215@pd.tnic>
 <87sh9jbrgc.fsf@e105922-lin.cambridge.arm.com>
 <20180301223529.GA28811@pd.tnic> <5AA02C26.10803@arm.com>
 <20180308104408.GB21166@pd.tnic> <5AAFC939.3010309@arm.com>
Message-ID: <20180327172510.GB32184@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Mon, Mar 19, 2018 at 02:29:13PM +0000, James Morse wrote:
> I don't think the die_lock really helps here, do we really want to wait for a
> remote CPU to finish printing an OOPs about user-space's bad memory accesses,
> before we bring the machine down due to this system-wide fatal RAS error? The
> presence of firmware-first means we know this error, and any other oops are
> unrelated.

Hmm, now that you put it this way...

> I'd like to leave this under the x86-ifdef for now. For arm64 it would be an
> APEI specific arch hook to stop the arch code from printing some messages,

... I'm thinking we should ignore the whole serializing of oopses and
really dump that hw error ASAP. If it really is a fatal error, our main
and only goal is to get it out as fast as possible so that it has the
highest chance to appear on some screen or logging facility and thus the
system can be serviced successfully.

And the other oopses have lower prio.

Hmmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
