From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Apr 2016 10:36:35 +0100
Subject: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20160401084509.GA11108@linaro.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com> <56EFF738.1040308@arm.com>
 <20160331075659.GD2267@linaro.org> <56FCDBF0.2010505@arm.com>
 <20160331101038.GB26532@leverpostej>
 <20160401084509.GA11108@linaro.org>
Message-ID: <20160401093635.GA29876@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:45:09PM +0900, AKASHI Takahiro wrote:
> On Thu, Mar 31, 2016 at 11:10:38AM +0100, Mark Rutland wrote:
> > On Thu, Mar 31, 2016 at 09:12:32AM +0100, Marc Zyngier wrote:
> > > On 31/03/16 08:57, AKASHI Takahiro wrote:
> > > > On Mon, Mar 21, 2016 at 01:29:28PM +0000, James Morse wrote:
> > > >> On 18/03/16 18:08, James Morse wrote:
> > > >>> On 14/03/16 17:48, Geoff Levand wrote:
> > > >>>> +	/* just in case */
> > > >>>> +	while (1)
> > > >>>> +		wfi();
> > > >>
> > > >> Having thought about this some more: I don't think spinning like this is safe.
> > > >> We need to spin with the MMU turned off, otherwise this core will pollute the
> > > >> kdump kernel with TLB entries from the old page tables.
> > > > 
> > > > I think that wfi() will never wake up since local interrupts are disabled
> > > > here. So how can it pollute the kdump kernel?
> > > 
> > > Having interrupts disabled doesn't prevent an exit from WFI. Quite the
> > > opposite, actually. It is designed to wake-up the core when something
> > > happens on the external interface.
> > 
> > Further, WFI is a hint, and may simply act as a NOP. 
> 
> Ah, OK. But even so, none of interrupt handlers (nor other code) will
> be executed after cpu wakes up, and the memory won't be polluted.

The code comprising the while(1) loop will be executed, and TLB walks,
speculative fetches, etc may occur regardless.

We don't share TLB entries between cores (we don't have support for
ARMv8.2s CnP), and the kdump kernel should be running in a carveout from
main memory (which IIUC is not mapped by the original kernel). So
normally, this would not be a problem.

However, if there is a problem with the page tables (e.g. entries
erroneously point into a PA range the kdump kernel is using), then
unavoidable background memory traffic from the CPU may cause problems
for the kdump kernel.

Thanks,
Mark.
