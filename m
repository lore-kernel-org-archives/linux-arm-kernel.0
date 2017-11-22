From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Nov 2017 21:19:28 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in userspace
 (KAISER)
In-Reply-To: <20171122161913.GB12684@amd>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <20171122161913.GB12684@amd>
Message-ID: <CAKv+Gu9xw92F_K5XhDwpuSWCSbVJOMGSszuGBkyrhqboLhA-Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2017 at 16:19, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> This patch series implements something along the lines of KAISER for arm64:
>>
>>   https://gruss.cc/files/kaiser.pdf
>>
>> although I wrote this from scratch because the paper has some funny
>> assumptions about how the architecture works. There is a patch series
>> in review for x86, which follows a similar approach:
>>
>>   http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>
>>
>> and the topic was recently covered by LWN (currently subscriber-only):
>>
>>   https://lwn.net/Articles/738975/
>>
>> The basic idea is that transitions to and from userspace are proxied
>> through a trampoline page which is mapped into a separate page table and
>> can switch the full kernel mapping in and out on exception entry and
>> exit respectively. This is a valuable defence against various KASLR and
>> timing attacks, particularly as the trampoline page is at a fixed virtual
>> address and therefore the kernel text can be randomized
>> independently.
>
> If I'm willing to do timing attacks to defeat KASLR... what prevents
> me from using CPU caches to do that?
>

Because it is impossible to get a cache hit on an access to an unmapped address?

> There was blackhat talk about exactly that IIRC...
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
