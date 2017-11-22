From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Nov 2017 23:19:09 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in userspace
 (KAISER)
In-Reply-To: <20171122223355.GA5877@amd>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <20171122161913.GB12684@amd>
 <CAKv+Gu9xw92F_K5XhDwpuSWCSbVJOMGSszuGBkyrhqboLhA-Mw@mail.gmail.com>
 <20171122223355.GA5877@amd>
Message-ID: <C271F3D3-A849-43F5-AE0A-6997890A3857@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 22 Nov 2017, at 22:33, Pavel Machek <pavel@ucw.cz> wrote:
> 
>> On Wed 2017-11-22 21:19:28, Ard Biesheuvel wrote:
>>> On 22 November 2017 at 16:19, Pavel Machek <pavel@ucw.cz> wrote:
>>> Hi!
>>> 
>>>> This patch series implements something along the lines of KAISER for arm64:
>>>> 
>>>>  https://gruss.cc/files/kaiser.pdf
>>>> 
>>>> although I wrote this from scratch because the paper has some funny
>>>> assumptions about how the architecture works. There is a patch series
>>>> in review for x86, which follows a similar approach:
>>>> 
>>>>  http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>
>>>> 
>>>> and the topic was recently covered by LWN (currently subscriber-only):
>>>> 
>>>>  https://lwn.net/Articles/738975/
>>>> 
>>>> The basic idea is that transitions to and from userspace are proxied
>>>> through a trampoline page which is mapped into a separate page table and
>>>> can switch the full kernel mapping in and out on exception entry and
>>>> exit respectively. This is a valuable defence against various KASLR and
>>>> timing attacks, particularly as the trampoline page is at a fixed virtual
>>>> address and therefore the kernel text can be randomized
>>>> independently.
>>> 
>>> If I'm willing to do timing attacks to defeat KASLR... what prevents
>>> me from using CPU caches to do that?
>>> 
>> 
>> Because it is impossible to get a cache hit on an access to an
>> unmapped address?
> 
> Um, no, I don't need to be able to directly access kernel addresses. I
> just put some data in _same place in cache where kernel data would
> go_, then do syscall and look if my data are still cached. Caches
> don't have infinite associativity.
> 

Ah ok. Interesting.

But how does that leak address bits that are covered by the tag?
