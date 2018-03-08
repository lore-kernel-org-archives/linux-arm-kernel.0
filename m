From: bp@alien8.de (Borislav Petkov)
Date: Thu, 8 Mar 2018 11:44:08 +0100
Subject: [PATCH 02/11] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <5AA02C26.10803@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-3-james.morse@arm.com>
 <20180301150144.GA4215@pd.tnic>
 <87sh9jbrgc.fsf@e105922-lin.cambridge.arm.com>
 <20180301223529.GA28811@pd.tnic> <5AA02C26.10803@arm.com>
Message-ID: <20180308104408.GB21166@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 06:15:02PM +0000, James Morse wrote:
> Today its just x86 and arm64. arm64 doesn't have a hook to do this. I'm happy to
> add an empty declaration or leave it under an ifdef until someone complains
> about any behaviour I missed!

So I did some more staring at the code and I think oops_begin() is
needed mainly, as you point out, to prevent two oops messages from
interleaving. And yap, the other stuff with printk() is not true anymore
because the commit which added oops_begin():

  81e88fdc432a ("ACPI, APEI, Generic Hardware Error Source POLL/IRQ/NMI notification type support")

still saw an NMI-unsafe printk. Which is long taken care of now.

So only the interleaving issue remains.

Which begs the question: how are you guys preventing the interleaving on
arm64? Because arch/arm64/kernel/traps.c:200 grabs the die_lock too, so
interleaving can happen on arm64 too, AFAICT.

And by that logic, you should technically grab that lock here too in
_in_nmi_notify_one().

Or?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
