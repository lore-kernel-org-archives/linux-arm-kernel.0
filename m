From: james.morse@arm.com (James Morse)
Date: Mon, 22 Jan 2018 19:32:12 +0000
Subject: [PATCH v8 7/7] arm64: kvm: handle SError Interrupt by
 categorization
In-Reply-To: <CAMj-D2C5Bz3r-w9v3QasZKK-W2JBY7Mx9W=yCDBnPYyk99gGzA@mail.gmail.com>
References: <1510343650-23659-1-git-send-email-gengdongjiu@huawei.com>
 <1510343650-23659-8-git-send-email-gengdongjiu@huawei.com>
 <5A0B1334.7060500@arm.com> <4af78739-99da-4056-4db1-f80bfe11081a@huawei.com>
 <5A283F26.3020507@arm.com> <4b37e86d-eee3-c51e-eceb-5d0c7ad12886@huawei.com>
 <506cd212-3d16-ba2a-518f-34982bc162fc@huawei.com> <5A58F8E3.5060002@arm.com>
 <CAMj-D2C5Bz3r-w9v3QasZKK-W2JBY7Mx9W=yCDBnPYyk99gGzA@mail.gmail.com>
Message-ID: <5A663C3C.7040904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 21/01/18 02:45, gengdongjiu wrote:
> For the ESR_ELx_AET_UER, this exception is precise, closing the VM may
> be better[1].
> But if you think panic is better until we support kernel-first, it is
> also OK to me.

I'm not convinced SError while a guest was running means only guest memory could
be affected. Mechanisms like KSM means the error could affect multiple guests.

Both firmware-fist and kernel-first will give us the address, with which we can
know which processes are affected, isolated the memory and signal affected
processes.

Until we have one of these panic() is the only way we have to contain an error,
but its an interim fix.
Not panic()ing the host for an error that should be contained to the guest is a
fudge, we don't actually know its safe (KSM, page-table etc). I want to improve
on this with {firmware, kernel}-first support (or both!), I don't want to expose
that this is happening to user-space, as once we have one of {firmware,
kernel}-first, it shouldn't happen.


>> This is inventing something new for RAS errors not claimed by firmware-first.
>> If we have kernel-first too, this will never happen. (unless your system is
>> losing the error description).

> In fact, if we have kernel-first, I think we still need to judge the
> error type by ESR, right?

The kernel-first mechanism should consider the ESR/FAR, yes, but once the error
has been claimed and handled, KVM shouldn't care about any of these values.
(maybe we'll sanity check for uncontained errors, just in case the error escaped
to the RAS code...)

My point here was exposing 'unhandled' (ignored) RAS errors to user-space
creates an ABI: someone will complain once we start handling the error, and they
no longer get a notification via this 'unhandled' interface. Code written to use
this interface becomes useless/untested.


> If the handle_guest_sei() , may be the system does not support firmware-first,
> so we judge the ESR value,

...and panic()/ignore as appropriate.

I agree not all systems will support firmware-first, (big-endian is the obvious
example), but if we get kernel-first support this ESR guessing can disappear,
I'm against exposing it to user-space in the meantime.


Thanks,

James
