From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 25 Oct 2016 10:55:45 -0700
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <CA+55aFwFQSass91gdGsjo4BkkAYmoFSn-Cpm6yF+SygF_tRp1g@mail.gmail.com>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej> <1477326477.1984.2.camel@perches.com>
 <20161024164255.GN15620@leverpostej>
 <CA+55aFwFQSass91gdGsjo4BkkAYmoFSn-Cpm6yF+SygF_tRp1g@mail.gmail.com>
Message-ID: <CA+55aFw4EP_qxZ8tcRUV=PcLx_XbwXXOU_yp3cJHVjazof_0MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 10:38 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Oct 24, 2016 at 9:42 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> That does not appear to be the case; as fr as I can tell the core prints a
>> timestamp per line as required. If I run:
>>
>>         printk("TEST\nLINE1\nLINE2\nLINE3\nLINE4\n");
>
> Please don't do this.

Side note: even with my patch, the above kind of stuff hits other special cases.

In particular, the "extended header" that is printed to special
consoles (really just the network console) will only print one header
for each record. So you'll end up with the "normal" logs having time
appended to each line, but the extended logs that use
"msg_print_ext_body()" will have just a header for each record, and
then within the record the newlines will be escaped as "\0a", I think.

We could fix that too, but basically newlines in the middle of a
string has never really worked reliably. I think historically (long
long ago) they were just printed as-is, and did not have the loglevel
or the timestamp, for example. Now those should work for normal
logging, but there clearly are still cases where it breaks down.

Of course, you probably could argue that nobody cares too deeply about
the exact format of the extended logging, and you'd probably be right.
But still..

And yes, what we probably *should* do is to do the newline breaking
when adding things to the log, rather than doing it in the
"msg_print_text()" phase.

There's a reason why I actually would have liked to entirely rewrite
the whole printk mess. But there's also a reason I didn't - I'm not
quite _that_ much of a glutton for punishment.

             Linus
