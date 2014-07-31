From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 18:44:00 +0100
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <CAFEAcA8RjmjoaEpjoDE5YJdKagtZYZe9TpCdsRPf86W=WCxCsA@mail.gmail.com>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
 <53DA7583.2030504@redhat.com>
 <CAFEAcA9cT617t8JqOXtuO-wQ5xg5T3Sw_DUHB1fpPD6g3SSNaQ@mail.gmail.com>
 <53DA7B28.701@redhat.com>
 <CAFEAcA8RjmjoaEpjoDE5YJdKagtZYZe9TpCdsRPf86W=WCxCsA@mail.gmail.com>
Message-ID: <20140731174359.GI26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 06:36:35PM +0100, Peter Maydell wrote:
> On 31 July 2014 18:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > What does ARM do if you have a WFI while interrupts are disabled?  On
> > x86 after "cli;hlt" only an NMI will wake you up.  With spurious
> > wakeups, it's pretty much guaranteed that you will break such "cli;hlt"
> > sequences.
> 
> The architecture mandates some things that *must* wake you from
> a WFI, but it also allows wakeups for other reasons not listed, or
> for no reason at all. It's perfectly valid to implement WFI as a NOP
> (though it would not be very good for power efficiency, obviously).
> Guests which don't surround WFI with a "check whether we should
> just go back to WFI" loop are buggy.

(and in case that wasn't clear, local_irq_disable() doesn't prevent an
interrupt from waking you up from wfi, otherwise our idle code would be
broken).

Will
