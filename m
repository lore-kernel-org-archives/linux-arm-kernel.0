From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 5 Apr 2017 16:57:35 -0700
Subject: [RFC v2][PATCH 04/11] x86: Implement
 __arch_rare_write_begin/unmap()
In-Reply-To: <CAGXu5jKif5UUMBbQBpB7Ha7w0L+su8dSXDU3nbccO3EBnv7bTw@mail.gmail.com>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
 <1490811363-93944-5-git-send-email-keescook@chromium.org>
 <CALCETrWkrpuJkcgiwMdc61Vv5U2u39FiWgzWfA_85nziK0pZsg@mail.gmail.com>
 <CAGXu5jKif5UUMBbQBpB7Ha7w0L+su8dSXDU3nbccO3EBnv7bTw@mail.gmail.com>
Message-ID: <CALCETrW7nN8Ja=r9k4ANpekKovC_wsYrGrge1WNoGsAjZZvqHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 6:41 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Mar 29, 2017 at 3:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Wed, Mar 29, 2017 at 11:15 AM, Kees Cook <keescook@chromium.org> wrote:
>>> Based on PaX's x86 pax_{open,close}_kernel() implementation, this
>>> allows HAVE_ARCH_RARE_WRITE to work on x86.
>>>
>>
>>> +
>>> +static __always_inline unsigned long __arch_rare_write_begin(void)
>>> +{
>>> +       unsigned long cr0;
>>> +
>>> +       preempt_disable();
>>
>> This looks wrong.  DEBUG_LOCKS_WARN_ON(!irqs_disabled()) would work,
>> as would local_irq_disable().  There's no way that just disabling
>> preemption is enough.
>>
>> (Also, how does this interact with perf nmis?)
>
> Do you mean preempt_disable() isn't strong enough here? I'm open to
> suggestions. The goal would be to make sure nothing between _begin and
> _end would get executed without interruption...
>

Sorry for the very slow response.

preempt_disable() isn't strong enough to prevent interrupts, and an
interrupt here would run with WP off, causing unknown havoc.  I tend
to think that the caller should be responsible for turning off
interrupts.

--Andy
