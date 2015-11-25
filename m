From: dcashman@android.com (Daniel Cashman)
Date: Wed, 25 Nov 2015 11:16:46 -0800
Subject: [PATCH v3 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <CAGXu5jKaW=H1WWuW_M4LpfcGGUWE3yvsiMnzMiAbeta__YpSJg@mail.gmail.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
 <20151124164001.71844bcfb4d7a500cd25d9c6@linux-foundation.org>
 <CAGXu5jKaW=H1WWuW_M4LpfcGGUWE3yvsiMnzMiAbeta__YpSJg@mail.gmail.com>
Message-ID: <5656091E.6080803@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 04:47 PM, Kees Cook wrote:
> On Tue, Nov 24, 2015 at 4:40 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Wed, 18 Nov 2015 15:20:05 -0800 Daniel Cashman <dcashman@android.com> wrote:
>>
>>> --- a/kernel/sysctl.c
>>> +++ b/kernel/sysctl.c
>>> @@ -1568,6 +1568,28 @@ static struct ctl_table vm_table[] = {
>>>               .mode           = 0644,
>>>               .proc_handler   = proc_doulongvec_minmax,
>>>       },
>>> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
>>> +     {
>>> +             .procname       = "mmap_rnd_bits",
>>> +             .data           = &mmap_rnd_bits,
>>> +             .maxlen         = sizeof(mmap_rnd_bits),
>>> +             .mode           = 0644,
>>
>> Is there any harm in permitting the attacker to read these values?
>>
>> And is there any benefit in permitting non-attackers to read them?
> 
> I'm on the fence. Things like kernel/randomize_va_space is 644. But
> since I don't see a benefit in exposing them, let's make them all 600
> instead -- it's a new interface, better to keep it narrower now.

Is there any harm in allowing the attacker to read these values? Nothing
immediately comes to mind.  It is a form of information leakage, and I
guess a local attacker could use this information to calibrate an attack
or decide whether or not brute-forcing is a worthy approach, but this
easily could be leaked in other ways as well.

Is there a benefit to allowing non-attackers to read them?  Possibly
could be used in tests seeking to verify the system environment, but
again, this could be discovered in other ways.

I like Kees' suggestion of starting narrow and granting if need arises.

>>>
>>> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
>>> +int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
>>> +int mmap_rnd_bits_max = CONFIG_ARCH_MMAP_RND_BITS_MAX;
>>> +int mmap_rnd_bits = CONFIG_ARCH_MMAP_RND_BITS;
>>> +#endif
>>> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
>>> +int mmap_rnd_compat_bits_min = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN;
>>> +int mmap_rnd_compat_bits_max = CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX;
>>> +int mmap_rnd_compat_bits = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
>>
>> These could be __read_mostly.
>>
>> If one believes in such things.  One effect of __read_mostly is to
>> clump the write-often stuff into the same cachelines and I've never
>> been convinced that one outweighs the other...
> 
> The _min and _max values should be const, actually, since they're
> build-time selected. The _bits could easily be __read_mostly, yeah.

Yes, one would generally expect these to never be touched, and even if
they were, the threshold of __read_mostly would certainly be crossed.

-Dan
