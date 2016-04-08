From: pinskia@gmail.com (Andrew Pinski)
Date: Thu, 7 Apr 2016 19:49:33 -0700
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160407121838.GA22098@angband.pl>
References: <20160407121838.GA22098@angband.pl>
Message-ID: <CA+=Sn1kx1UumTYHa8AE-XAUNiSXTd5zoDxae1LL5YczC_VXe_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 7, 2016 at 5:18 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> On Wed, 6 Apr 2016, Geert Uytterhoeven wrote:
>> On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>>  v6:
>>>  - time_t, __kenel_off_t and other types turned to be 32-bit
>>>    for compatibility reasons (after v5 discussion);
>
> Introducing a new arch today with y2038 problems is not a good idea.
> Linus said so with appropriately pointy words in 2011.

This is the third time we had this discussion on time_t for ILP32.  I
had originally it as 32bit, then Catalin suggested I change it to
64bit and then Arnd (with his work for 2038 issue on 32bit arch) said
ILP32 should match all other 32bit targets and the other 64bit time_t
be fixed by the current work he was working on.  Now you are
suggesting we change it again.
Arnd can you please comment more on why we want 32bit time_t instead
of the 64bit one?  I Know there was some POSIX (or was it C90)
violation but I suspect there is an easy way to workaround this inside
the kernel but the discussion to move over to 32bit time_t was already
made by the time I started to look into that.

>
>> What makes you think these "applications that can?t readily be migrated to LP64
>> because they were written assuming an ILP32 data model, and that will never
>> become suitable for a LP64 data model and will remain locked into ILP32
>> operating environments" are more likely to be fixed for y2038 later, than for
>> LP64 now?
>
> Such broken applications already have plenty of bogus architecture detection
> code so you need porting anyway...

I don't disagree here; just see below ...

>
>> We're already closer to the (future) y2038 than to the (past) introduction of
>> LP64...
>>
>> These unfixable legacy applications have been spreading through x32 to
>> the shiny new arm64 server architecture (does ppc64el also have an ILP32 mode,
>> or is it planned)? Lots of resources are spent on maintaining the status quo,
>> instead of on fixing the real problems.
>
> As an x32 (userland) porter, I can tell you that time_t!=long _did_ cause
> non-trivial amounts of work.  But that work is already done (at least in
> Debian), so you might as well benefit from it.

There is actually private code out there which uses timespec and
timeval to pass time over the wire; yes I know bad coding style and
all but they did it that way.  This is code which was working for x86
and we are porting it to ARM64; a data center code by the way; not
some networking code even.  This means they have not ported the code
to fully 64bit yet and they might never.

Thanks,
Andrew

>
>
> --
> A tit a day keeps the vet away.
