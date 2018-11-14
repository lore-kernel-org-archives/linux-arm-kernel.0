From: keescook@chromium.org (Kees Cook)
Date: Wed, 14 Nov 2018 16:48:11 -0600
Subject: [PATCH 00/17] ARMv8.3 pointer authentication support
In-Reply-To: <20181114214701.gdnrznakwtm76jlt@blommer>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
 <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
 <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
 <20181114214701.gdnrznakwtm76jlt@blommer>
Message-ID: <CAGXu5jJun3CuUa12aQpy+m7Op-g9XwPv3CygwqYX2dy0A4qt5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 3:47 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 13, 2018 at 05:09:00PM -0600, Kees Cook wrote:
>> On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
>> <kristina.martsenko@arm.com> wrote:
>> > When the PAC authentication fails, it doesn't actually generate an
>> > exception, it just flips a bit in the high-order bits of the pointer,
>> > making the pointer invalid. Then when the pointer is dereferenced (e.g.
>> > as a function return address), it generates the usual type of exception
>> > for an invalid address.
>>
>> Ah! Okay, thanks. I missed that detail. :)
>>
>> What area of memory ends up being addressable with such bit flips?
>> (i.e. is the kernel making sure nothing executable ends up there?)
>>
>> > So when a function return fails in user mode, the exception is handled
>> > in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
>> > function return fails in kernel mode, the exception is handled in
>> > __do_kernel_fault and the task is killed.
>> >
>> > This is different from stack protector as we don't panic the kernel, we
>> > just kill the task. It would be difficult to panic as we don't have a
>> > reliable way of knowing that the exception was caused by a PAC
>> > authentication failure (we just have an invalid pointer with a specific
>> > bit flipped). We also don't print out any PAC-related warning.
>>
>> There are other "guesses" in __do_kernel_fault(), I think? Could a
>> "PAC mismatch?" warning be included in the Oops if execution fails in
>> the address range that PAC failures would resolve into?
>
> I'd personally prefer that we didn't try to guess if a fault is due to a failed
> AUT*, even for logging.
>
> Presently, it's not possible to distinguish between a fault resulting from a
> failed AUT* and a fault which happens to have hte same bits/clear, so there are
> false positives. The architecture may also change the precise details of the
> faulting address, and we'd have false negatives in that case.
>
> Given that, I think suggesting that a fault is due to a failed AUT* is liable
> to make things more confusing.

Okay, no worries. It should be pretty clear from the back trace anyway. :)

As long as there isn't any way for the pointer bit flips to result in
an addressable range, I'm happy. :)

-Kees

-- 
Kees Cook
