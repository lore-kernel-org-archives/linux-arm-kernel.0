From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 28 Jan 2013 16:46:38 +0100
Subject: [PATCH v2 1/3] pwm: Add pwm_cansleep() as exported API to users
In-Reply-To: <20130128150113.GL23505@n2100.arm.linux.org.uk>
References: <1359121471-21457-1-git-send-email-florian.vaussard@epfl.ch>
 <1359121471-21457-2-git-send-email-florian.vaussard@epfl.ch>
 <20130126054024.GB29243@avionic-0098.adnet.avionic-design.de>
 <51063AB5.2060108@ti.com> <51064687.5090605@epfl.ch>
 <20130128150113.GL23505@n2100.arm.linux.org.uk>
Message-ID: <51069D5E.7030108@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 28/01/2013 16:01, Russell King - ARM Linux a ?crit :
> On Mon, Jan 28, 2013 at 10:36:07AM +0100, Florian Vaussard wrote:
>> Hello,
>>
>> Le 28/01/2013 09:45, Peter Ujfalusi a ?crit :
>>> hi Thierry,
>>>
>>> On 01/26/2013 06:40 AM, Thierry Reding wrote:
>>>>> +{
>>>>> +	return pwm->chip->can_sleep;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(pwm_cansleep);
>>>>
>>>> Would it make sense to check for NULL pointers here? I guess that
>>>> passing NULL into the function could be considered a programming error
>>>> and an oops would be okay, but in that case there's no point in making
>>>> the function return an int. Also see my next comment.
>>>
>>> While it is unlikely to happen it is better to be safe, something like this
>>> will do:
>>>
>>> return pwm ? pwm->chip->can_sleep : 0;
>>>
>>
>> Ok. And what about:
>>
>> BUG_ON(pwm == NULL);
>> return pwm->chip->can_sleep;
>
> Let's get something straight.
>
> 1. Don't use BUG_ON() as some kind of willy nilly assert() replacement.
>     Linus refused to have assert() in the kernel because assert() gets not
>     only over-used, but also gets inappropriately used too.
>
>     _Only_ _ever_ use BUG_ON() if continuing is going to cause user
>     noticable data loss which is not reportable to userspace.  In other
>     words, block device queue corruption or the like - where bringing the
>     system down is going to _save_ the system from itself.
>
>     Otherwise, return an error and/or use WARN_ON().
>
> 2. If you want a slow kernel, then by all means check your arguments to
>     your functions.  While you're at it, why not check that strings which
>     are passed contain only the characters you expect them to?  And, if
>     you're bothering to check against a NULL pointer, what about NULL+1
>     pointers which are also invalid?  Why not invent some function to
>     ensure that the pointer is a valid kernel pointer.  Maybe you'll have
>     to interate the vmalloc lists too - yay, more code to be executed!
>     That must be good!
>
> In your example, if you're going to check that pwm is non-NULL, what
> if pwm->chip is non-NULL?  How far do you take this?
>
> Or... just like most of the core kernel does, it does _not_ verify on
> function entry that the pointer is "correct" unless it is explicitly
> defined that the function may take a NULL pointer (like kfree()).
> Everything else just goes right on and does the dereference - and if
> the pointer was wrong, we hope that the MMU faults and we get a kernel
> oops.
>
> Have a read through the code in fs/ or kernel/ and see how many functions
> you can spot in there which validate their pointers which aren't dealing
> with data from userland.
>
> You'll find almost no function checking that an inode pointer is not NULL.
> Or a struct file pointer.  Or a struct path pointer... etc.
>
> Yet, you come to ARM code, and it seems "popular" that pointer arguments
> need to be verified on every single function call.  Why is this?
>
> I don't know if Andrew would like to inject something here (I've added
> him) on this subject...
>

The v3 does not contain the check.

Thank you,

Florian
