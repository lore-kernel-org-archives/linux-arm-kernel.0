From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 12:24:20 +0100
Subject: your mail
In-Reply-To: <20150421111042.GB3996@e103592.cambridge.arm.com>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
 <20150421111042.GB3996@e103592.cambridge.arm.com>
Message-ID: <20150421112420.GV12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 12:10:43PM +0100, Dave P Martin wrote:
> On Tue, Apr 21, 2015 at 11:50:02AM +0100, Ard Biesheuvel wrote:
> > OK, that makes sense. But it does appear that the local cross-section
> > references are working just fine, i.e., references from other sections
> > in the same .o have the thumb bit set correctly even without BSYM()
> 
> For branch targets, the set of situations where BSYM must be used and
> the set of situations where it must not be used are mutually exclusive:
> 
>  * If the assembler resolves the address and the address will be used as a
>    branch target, BSYM() must be used.  This applies to non-cross-section
>    references within in single object only.
> 
>  * If the linker resolves the address, BSYM() must not be used and the
>    target label must be annotated with ENDPROC().  This applies to
>    all cross-section or cross-object references.

Yes, that agrees with the situation we have for the initfunc stuff.

> For any address that won't be used as a branch target, BSYM() must not
> be used.
> 
> Cross-section non-cross-object references where the target is missing
> ENDPROC() and BSYM _is_ used will also work, but this should be avoided
> -- it's an abuse really.

We should probably create a badr macro to complement the adr pseudo-op
which incorporates the BSYM thing so make this clearer - and a comment
before it.  This is really the case where BSYM should be used.

We have one case in the kernel source which is probably buggy:

arch/arm/kvm/interrupts.S:      ldr     r2, =BSYM(panic)

and killing BSYM in favour of a badr macro would prevent this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
