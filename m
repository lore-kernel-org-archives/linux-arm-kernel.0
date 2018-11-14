From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Nov 2018 21:47:02 +0000
Subject: [PATCH 00/17] ARMv8.3 pointer authentication support
In-Reply-To: <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
 <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
 <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
Message-ID: <20181114214701.gdnrznakwtm76jlt@blommer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 05:09:00PM -0600, Kees Cook wrote:
> On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
> <kristina.martsenko@arm.com> wrote:
> > When the PAC authentication fails, it doesn't actually generate an
> > exception, it just flips a bit in the high-order bits of the pointer,
> > making the pointer invalid. Then when the pointer is dereferenced (e.g.
> > as a function return address), it generates the usual type of exception
> > for an invalid address.
> 
> Ah! Okay, thanks. I missed that detail. :)
> 
> What area of memory ends up being addressable with such bit flips?
> (i.e. is the kernel making sure nothing executable ends up there?)
> 
> > So when a function return fails in user mode, the exception is handled
> > in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
> > function return fails in kernel mode, the exception is handled in
> > __do_kernel_fault and the task is killed.
> >
> > This is different from stack protector as we don't panic the kernel, we
> > just kill the task. It would be difficult to panic as we don't have a
> > reliable way of knowing that the exception was caused by a PAC
> > authentication failure (we just have an invalid pointer with a specific
> > bit flipped). We also don't print out any PAC-related warning.
> 
> There are other "guesses" in __do_kernel_fault(), I think? Could a
> "PAC mismatch?" warning be included in the Oops if execution fails in
> the address range that PAC failures would resolve into?

I'd personally prefer that we didn't try to guess if a fault is due to a failed
AUT*, even for logging.

Presently, it's not possible to distinguish between a fault resulting from a
failed AUT* and a fault which happens to have hte same bits/clear, so there are
false positives. The architecture may also change the precise details of the
faulting address, and we'd have false negatives in that case.

Given that, I think suggesting that a fault is due to a failed AUT* is liable
to make things more confusing.

Thanks,
Mark.
