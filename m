From: dcashman@android.com (Daniel Cashman)
Date: Mon, 9 Nov 2015 10:56:24 -0800
Subject: [PATCH v2 2/2] arm: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1447040874.5195.2.camel@ellerman.id.au>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <1446574204-15567-2-git-send-email-dcashman@android.com>
 <CAGXu5jKGzDD9WVQnMTT2EfupZtjpdcASUpx-3npLAB-FctLodA@mail.gmail.com>
 <56393FD0.6080001@android.com>
 <CAGXu5jLe=OgZ2DG_MRXA8x6BwpEd77fNZBj3wjbDiSdiBurz7w@mail.gmail.com>
 <563A4EDC.6090403@android.com> <563BA393.9020504@android.com>
 <CAGXu5j+2xiRwt6mKrjzuf9O745GWOcjXzutONp6rz_Kj+3PfVQ@mail.gmail.com>
 <1447040874.5195.2.camel@ellerman.id.au>
Message-ID: <5640EC58.7050006@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2015 07:47 PM, Michael Ellerman wrote:
> On Fri, 2015-11-06 at 12:52 -0800, Kees Cook wrote:
>> On Thu, Nov 5, 2015 at 10:44 AM, Daniel Cashman <dcashman@android.com> wrote:
>>> On 11/04/2015 10:30 AM, Daniel Cashman wrote:
>>>> On 11/3/15 3:21 PM, Kees Cook wrote:
>>>>> On Tue, Nov 3, 2015 at 3:14 PM, Daniel Cashman <dcashman@android.com> wrote:
>>>>>> On 11/03/2015 11:19 AM, Kees Cook wrote:
>>>>>>> Do you have patches for x86 and arm64?
>>>>>>
>>>>>> I was holding off on those until I could gauge upstream reception.  If
>>>>>> desired, I could put those together and add them as [PATCH 3/4] and
>>>>>> [PATCH 4/4].
>>>>>
>>>>> If they're as trivial as I'm hoping, yeah, let's toss them in now. If
>>>>> not, skip 'em. PowerPC, MIPS, and s390 should be relatively simple
>>>>> too, but one or two of those have somewhat stranger calculations when
>>>>> I looked, so their Kconfigs may not be as clean.
>>>>
>>>> Creating the patches should be simple, it's the choice of minimum and
>>>> maximum values for each architecture that I'd be most concerned about.
>>>> I'll put them together, though, and the ranges can be changed following
>>>> discussion with those more knowledgeable, if needed.  I also don't have
>>>> devices on which to test the PowerPC, MIPS and s390 changes, so I'll
>>>> need someone's help for that.
>>>
>>> Actually, in preparing the x86 and arm64 patches, it became apparent
>>> that the current patch-set does not address 32-bit executables running
>>> on 64-bit systems (compatibility mode), since only one procfs
>>> mmap_rnd_bits variable is created and exported. Some possible solutions:
>>
>> How about a single new CONFIG+sysctl that is the compat delta. For
>> example, on x86, it's 20 bits. Then we don't get splashed with a whole
>> new set of min/maxes, but we can reasonably control compat?
> 
> Do you mean in addition to mmap_rnd_bits?
> 
> So we'd end up with mmap_rnd_bits and also mmap_rnd_bits_compat_delta?
> (naming TBD)
> 
> If so yeah I think that would work.
> 
> It would have the nice property of allowing you to add some more randomness to
> all processes by bumping mmap_rnd_bits. But at the same time if you want to add
> a lot more randomness to 64-bit processes, but just a bit (or none) to 32-bit
> processes you can also do that.

I may be misunderstanding the suggestion, or perhaps simply too
conservative in my desire to prevent bad values, but I still think we
would have need for two min-max ranges.  If using a single
mmap_rnd_bits_compat value, there are two approaches: to either use
mmap_rnd_bits for 32-bit applications and then add the compat value for
64-bit or the opposite, to have mmap_rnd_bits be the default and
subtract the compat value for the 32-bit applications.  In either case,
the compat value would need to be sensibly bounded, and that bounding
depends on acceptable values for both 32 and 64 bit applications.
