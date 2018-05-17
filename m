From: Matt.Sealey@arm.com (Matt Sealey)
Date: Thu, 17 May 2018 15:07:04 +0000
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <20180516192528.5519d2faf59766e0544bb2ee@arm.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
 <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
 <1525882003.4199.55.camel@arm.com>
 <20180509184154.9994df2874e7a08025b56dea@arm.com>
 <cee9c043-3d64-56b9-4f23-e8c8370387dd@gmail.com>
 <20180516192528.5519d2faf59766e0544bb2ee@arm.com>
Message-ID: <HE1PR0802MB241294860D79A65132C69382EE910@HE1PR0802MB2412.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

> > I don't have any dog in this, but maybe if providing information to the
> > users is so essential to having a pleasant user experience, then
> > rethinking the whole way these messages are funneled is necessary
> > because the kernel log + dmesg is by no means appropriate. Take a look
> > at what the networking maintainers recently did with netlink extended
> > ack. You used to just get an "unsupported" error, and now you know
> > exactly what is wrong when extack is available. It seems to me like
> > something like this is what you might want here since you want to have
> > perf be as user friendly as possible.
>
> Thanks, Florian.

Florian, I'd love to know if you mean "implement netlink extended ack in
perf" or "do something idiomatic for perf"?

Let us assume we are semantically challenged over here. I'm going to
proceed from the latter.

> Acme & other perf people, do you foresee a problem adding netlink
> extended ack support to the perf subsystem for extended error message
> communication?
>
> If not, is struct perf_event_attr amenable to having error reporting
> bit(s) added?

I did have a think about this when Kim mentioned it in passing, and my
reasoning was that a serialized error record similar to ACPI APEI BERT/ERST
tables (without the NVRAM abstraction) would fit the need.

As soon as I wrote down my thoughts I realized it scratch more itches than
just something useful for perf.

It would conceptually be a buffer passed from userspace with the syscall,
which would be populated in the kernel with an identifying header, each
record denoting its own length. The syscall fills the buffer with records
of particular format for the syscall, and the errno returned to the
application is then the state of the error recording buffer - for instance,
if the kernel ran out of space in the buffer before reporting all the errors
it could (-ENOBUFS or -EAGAIN), if it stopped recording errors on something
that requires being contained and returned at that point (-EFAULT), and so
on (anyone who's got RAS on the brain will see where I'm coming from).

I have a distinct dislike of filling the kernel with const strings, so the
records would be strictly machine-readable and contain information about
the error for the record and the source. If userspace needs to print a
string then it can look up unique identifiers (UUIDv1, give or take, to
remove the need for any authority on numbering) in a database - be that
plaintext, gettext.po, bdb, sqlite, xml, json, C structure embedded in the
tool - one for each error source. That keeps strings, translations, string
formatting entirely outside the kernel, and keeps records from being freeform
typo-laden strings.

That'd give some generic Producer code in the kernel, and imply a companion
Consumer library in userspace (with said database backend), which could also
be responsible for logging the binary records somewhere for future reference
(perhaps bounded by capabilities or container privileges).

Pretty much every syscall that has problems returning 'just an errno'
could benefit from such a system, the only impediment I can see to it is
that it's adding a new subsystem to the kernel to produce these records,
and any syscall that needs it would have to gain either an extra parameter,
or attribute setting addition (like setsockopts) or to shoehorn the buffer
pointer into an existing parameter structure like perf_event_attr. That
would have to be locked down to a consistent method that would be
recommended (like adding a new syscall interface, not everyone has an
attribute interface or parameter structure) although there's no stopping
kernel devs adding in a way for legacy applications to easily receive
the same information through existing ABI.

In the case of perf_event_attr there is space enough to mark a bit to say
that errors could be reported in a buffer, but not enough in the reserved
space that exists to store a pointer for 64-bit systems (or 128-bit ones..)
without increasing its size. But, besides that, it would have the benefit
of simply being serialized with the syscall, and not a supplemental,
potentially non-thread-safe errno/strerror-like kernel-side implementation,
nor extra syscalls to retrieve information or arbitrary formatted or
unformatted strings.

Netlink extended ack could benefit from it simply by having been passed
an nlattr pointing to the buffer and recording extended error information
in it - the extended ack structure can report the status of the buffer
and use the cookie field to reproduce some information if necessary (which
extends the RAS error record concept further when needed).

Thoughts? Does anyone have any objections to a RAS-like error reporting
system for system calls, or any ideas on things that would benefit from
it above and beyond perf? We could always audit all the system calls and
their behaviors so we could do some worked examples but anyone who's got
a good candidate outside perf is welcome to suggest it.

Ta,
Matt




IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
