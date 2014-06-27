From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 27 Jun 2014 13:08:20 -0700
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
Message-ID: <CALCETrUxGbTet--zJiKX4BqbOaw2MDBPqT18HaQOdf7zwWWtEw@mail.gmail.com>
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

Yes, which is more or less the whole point of that patch series.  I
rewrote part of the TIF_SECCOMP-but-no-tracing case in assembly :)

I'm playing with rewriting it in C, but it's looking like it'll be a
bit more far-reaching than I was hoping.

--Andy
