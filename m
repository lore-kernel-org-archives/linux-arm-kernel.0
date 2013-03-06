From: dirk.behme@gmail.com (Dirk Behme)
Date: Wed, 06 Mar 2013 18:38:06 +0100
Subject: [PATCH] [RFC] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <20130306171110.GQ17833@n2100.arm.linux.org.uk>
References: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
 <20130211184114.GP9801@mudshark.cambridge.arm.com>
 <20130211194225.GK29329@parrot.com>
 <20130212140008.GB4123@mudshark.cambridge.arm.com>
 <20130212155801.GQ17833@n2100.arm.linux.org.uk>
 <20130212163645.GI4123@mudshark.cambridge.arm.com>
 <5135F80E.3070307@gmail.com> <20130306171110.GQ17833@n2100.arm.linux.org.uk>
Message-ID: <51377EFE.3070801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.03.2013 18:11, schrieb Russell King - ARM Linux:
> On Tue, Mar 05, 2013 at 02:50:06PM +0100, Dirk Behme wrote:
>> On 12.02.2013 17:36, Will Deacon wrote:
>>> On Tue, Feb 12, 2013 at 03:58:01PM +0000, Russell King - ARM Linux wrote:
>>>> On Tue, Feb 12, 2013 at 02:00:08PM +0000, Will Deacon wrote:
>>>>> Interesting... the GCC documentation also states that ffreestanding implies
>>>>> fno-builtin, so memset and co shouldn't be targetted for this sort of
>>>>> optimisation by GCC. Have you observed this problem even when passing this
>>>>> option?
>>>>
>>>> Rather than wondering whether we should be using -ffreestanding or not
>>>> (which, x86 people have strongly resisted) I suggest that we just fix
>>>> our memset() implementation to be compliant.
>>>>
>>>> The reason it's not compliant is that I saw no reason for it to be
>>>> compliant back in the gcc 2.7.x days, and it's persisted like that for
>>>> the last 19-ish years.  If GCC is now making use of the return value,
>>>> then we need to fix that and undo the "optimization" in our string.h.
>>>>
>>>> So let's just bite the bullet, make the asm memset() compliant, and
>>>> clean up string.h.
>>>
>>> That would be the ideal thing to do, because it allows the compiler to
>>> optimise around these functions, however it does mean we need to check/fix
>>> *all* of the string functions at least (if we don't pass -fno-builtin then
>>> any builtin function is up for optimisation, including strcpy etc).
>>
>> Do we already have an agreed solution for this issue anywhere, now?
>
> No idea.  I've stated above what I think should happen.  Where's the
> disagreement?

I'm not sure if there even is a disagreement ;)

I've asked because it seems that Ivan's v2 patch [1] isn't applied 
anywhere, yet. This let me to the impression that this might not be 
the final ('agreed') fix and that something still has to be done.

Will's answer to my question [2] sounds like Ivan's v2 patch [1] is 
the final solution, though. If this is correct, what stops us from 
applying [1]?

Sorry if I misunderstood anything.

Thanks

Dirk

[1] http://www.spinics.net/lists/arm-kernel/msg224019.html

[2] http://www.spinics.net/lists/arm-kernel/msg228036.html
