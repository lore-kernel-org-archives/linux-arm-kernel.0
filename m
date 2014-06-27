From: keescook@chromium.org (Kees Cook)
Date: Fri, 27 Jun 2014 13:56:46 -0700
Subject: [PATCH v8 5/9] seccomp: split mode set routines
In-Reply-To: <20140627195559.GA31661@redhat.com>
References: <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com>
 <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com>
 <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
 <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
 <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
 <20140627192753.GA30752@redhat.com>
 <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
 <20140627195559.GA31661@redhat.com>
Message-ID: <CAGXu5j+M+MHkxNMSaQ+RqYrty=1Fgur6_duSnL8DAZ_SazeJ7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 12:55 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/27, Andy Lutomirski wrote:
>>
>> On Fri, Jun 27, 2014 at 12:27 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > On 06/27, Kees Cook wrote:
>> >>
>> >> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.htm
>> >>
>> >> ...
>> >>
>> >> I really want to avoid adding anything to the secure_computing()
>> >> execution path. :(
>> >
>> > I must have missed something but I do not understand your concerns.
>> >
>> > __secure_computing() is not trivial, and we are going to execute the
>> > filters. Do you really think rmb() can add the noticeable difference?
>> >
>> > Not to mention that we can only get here if we take the slow syscall
>> > enter path due to TIF_SECCOMP...
>> >
>>
>> On my box, with my fancy multi-phase seccomp patches, the total
>> seccomp overhead for a very short filter is about 13ns.  Adding a full
>> barrier would add several ns, I think.
>
> I am just curious, does this 13ns overhead include the penalty from the
> slow syscall enter path triggered by TIF_SECCOMP ?
>
>> Admittedly, this is x86, not ARM, so comparisons here are completely
>> bogus.  And that read memory barrier doesn't even need an instruction
>> on x86.  But still, let's try to keep this fast.
>
> Well, I am not going to insist...
>
> But imo it would be better to make it correct in a most simple way, then
> we can optimize this code and see if there is a noticeable difference.
>
> Not only we can change the ordering, we can remove the BUG_ON's and just
> accept the fact the __secure_computing() can race with sys_seccomp() from
> another thread.
>
> If nothing else, it would be much simpler to discuss this patch if it comes
> as a separate change.

Yeah, the way I want to go is to add the rmb() for now (it gets us
"correctness"), and then later deal with any potential performance
problems on ARM at a later time. (At present, I'm unable to perform
any timings on ARM -- maybe next week.)

I will send the v9 series in a moment here...

-Kees

-- 
Kees Cook
Chrome OS Security
