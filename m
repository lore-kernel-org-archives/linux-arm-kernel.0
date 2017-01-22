From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Jan 2017 15:05:45 +0000
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485093760.1494.2.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
 <1485075528.14345.1.camel@crowfest.net>
 <CAKv+Gu8LU3QjrUa6wMJF3WBNrhx34Pi_0ZUQVfrZy7w7y7237w@mail.gmail.com>
 <22169925.OhJ0QcnbHM@localhost> <1485087662.1518.1.camel@crowfest.net>
 <0D1F678D-6F94-4B68-955E-6454F8647FCA@linaro.org>
 <1485093760.1494.2.camel@crowfest.net>
Message-ID: <CAKv+Gu_yn6x5dUgUGve-UECafRj50bpT_Gu-d=_mkMePPe=QzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2017 at 14:02, Michael Zoran <mzoran@crowfest.net> wrote:
> On Sun, 2017-01-22 at 13:01 +0000, Ard Biesheuvel wrote:
>> > On 22 Jan 2017, at 12:21, Michael Zoran <mzoran@crowfest.net>
>> > wrote:
>>
>> > 2. Detect the binary type to detectermine if it should be silenced.
>>
>> The controls are system wide, not per process. And I think the
>> somewhat unconventional requirement to run a v6 compatible userland
>> justifies adding a line to the boot script that simply disarms all
>> the deprecation warnings.
>>
>
>     It depends on the point of view of the arm architecture.  One point
> of view if that if you have a new 64 bit application with access to
> more feature, it has to be compiled with new instructions so no reason
> to have the old around.  But if you have an old 32 bit application,
> then it keeps working.
>

Well, it is of course a tradeoff between the loss of functionality
versus the cost of keeping the feature supported. I am not a hardware
designer, but it is not difficult to imagine how the fact that the
endianness of a process may change at any point during its execution
can complicate a modern pipeline significantly, given that it may have
many instructions in flight in various stages of execution, including
memory accesses that need to be restarted if the endianness changes.

So that is why the setend instruction is deprecated, which in this
case also means support for it is no longer mandatory.

>> Any political differences in the rpi project regarding support of the
>> 64 bit kernel are not upstream's problem imo
>>
>
>     I am in no way associated with the rpi project or the organization.
>  I receive absolutely nothing from them and they are not supporting 64
> bit at all other then as a hobbiest/experimental project.
>
>     I'm just a very interested enthusiast with a bit of time on my hand
> now that finds 64 bit interesting. I found the idea of getting 32 bit
> Raspbian to work as interesting.
>

I agree. I am also an enthusiast (although a paid one). Recently, I
have been looking into improving the performance AES in the arm64
kernel, specifically because the Raspberry Pi 3 does not support the
new v8 AES instructions.

>> >
>>
>> I wonder why Mathematica cares about the personality. If it makes
>> inferences about the architecture level to decide which instructions
>> to use, it is clearly abusing the facility. Any clue?
>>
>
>    No idea really.  It may have something to do with licensing
> requirements since it's targeted for education. In the sake of not
> stepping on any toes I have no intention of submitting any patches or
> changes to the personality because of that.
>
>   The personality issue is more an arm architcture issue and I am
> quickly seeing is beyond the scope of what I'm trying to accomplish.
