From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 24 Jun 2014 12:51:43 -0700
Subject: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
In-Reply-To: <CAGXu5jJjuNmf=FRzUPMChvL4D_xkg034pUbRAbaK38f37GYC0A@mail.gmail.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-5-git-send-email-keescook@chromium.org>
 <20140624191815.GA3623@redhat.com>
 <CALCETrVgpP=zOtiQafVgcic2T95TdEM5DTvHYXWTbcZ14xBqHQ@mail.gmail.com>
 <20140624193055.GA4482@redhat.com>
 <CALCETrU9x05ADgz9JToiw_BuCPz1h0xmOh=1R3eojL9far1aEA@mail.gmail.com>
 <CAGXu5jJjuNmf=FRzUPMChvL4D_xkg034pUbRAbaK38f37GYC0A@mail.gmail.com>
Message-ID: <CALCETrUCK0g3nTQP+Oh7-JXh-mODAC-Bemr1fCYMJyDvjFPcjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 12:50 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jun 24, 2014 at 12:34 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Tue, Jun 24, 2014 at 12:30 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 06/24, Andy Lutomirski wrote:
>>>>
>>>> On Tue, Jun 24, 2014 at 12:18 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>> >>
>>>> >> -struct seccomp { };
>>>> >> +struct seccomp {
>>>> >> +     unsigned long flags;
>>>> >> +};
>>>> >
>>>> > A bit messy ;)
>>>> >
>>>> > I am wondering if we can simply do
>>>> >
>>>> >         static inline bool current_no_new_privs(void)
>>>> >         {
>>>> >                 if (current->no_new_privs)
>>>> >                         return true;
>>>> >
>>>> >         #ifdef CONFIG_SECCOMP
>>>> >                 if (test_thread_flag(TIF_SECCOMP))
>>>> >                         return true;
>>>> >         #endif
>>>>
>>>> Nope -- privileged users can enable seccomp w/o nnp.
>>>
>>> Indeed, I am stupid.
>>>
>>> Still it would be nice to cleanup this somehow. The new member is only
>>> used as a previous ->no_new_privs, just it is long to allow the concurent
>>> set/get. Logically it doesn't even belong to seccomp{}.
>>
>> We could add an unsigned long atomic flags field to task_struct.
>
> I thought that had gotten shot down originally, but given the current
> state of the patch series, it would be effectively identical, since my
> earlier attempt at keeping sizes the same (with alternate accessors)
> was too messy. I will change this as well.
>
>> Grr.  Why isn't there an unsigned *int* atomic bitmask type?  Even u64
>> would be better.  unsigned long is useless.
>
> Useless beyond 32 bits. ;)

It basically guarantees 32 wasted bits on 64-bit systems.

I guess that unsigned long foo[64/BITS_PER_LONG] would work, bit that's hideous.

--Andy
