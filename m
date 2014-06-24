From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 24 Jun 2014 12:34:36 -0700
Subject: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
In-Reply-To: <20140624193055.GA4482@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-5-git-send-email-keescook@chromium.org>
 <20140624191815.GA3623@redhat.com>
 <CALCETrVgpP=zOtiQafVgcic2T95TdEM5DTvHYXWTbcZ14xBqHQ@mail.gmail.com>
 <20140624193055.GA4482@redhat.com>
Message-ID: <CALCETrU9x05ADgz9JToiw_BuCPz1h0xmOh=1R3eojL9far1aEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 12:30 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Andy Lutomirski wrote:
>>
>> On Tue, Jun 24, 2014 at 12:18 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >>
>> >> -struct seccomp { };
>> >> +struct seccomp {
>> >> +     unsigned long flags;
>> >> +};
>> >
>> > A bit messy ;)
>> >
>> > I am wondering if we can simply do
>> >
>> >         static inline bool current_no_new_privs(void)
>> >         {
>> >                 if (current->no_new_privs)
>> >                         return true;
>> >
>> >         #ifdef CONFIG_SECCOMP
>> >                 if (test_thread_flag(TIF_SECCOMP))
>> >                         return true;
>> >         #endif
>>
>> Nope -- privileged users can enable seccomp w/o nnp.
>
> Indeed, I am stupid.
>
> Still it would be nice to cleanup this somehow. The new member is only
> used as a previous ->no_new_privs, just it is long to allow the concurent
> set/get. Logically it doesn't even belong to seccomp{}.

We could add an unsigned long atomic flags field to task_struct.

Grr.  Why isn't there an unsigned *int* atomic bitmask type?  Even u64
would be better.  unsigned long is useless.

>
> Oleg.
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
