From: dcashman@android.com (Daniel Cashman)
Date: Tue, 3 Nov 2015 10:21:35 -0800
Subject: [PATCH 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <87k2q1tmna.fsf@x220.int.ebiederm.org>
References: <1446067520-31806-1-git-send-email-dcashman@android.com>
 <871tcewoso.fsf@x220.int.ebiederm.org>
 <CABXk95DOSKv70p+=DQvHck5LCvRDc0WDORpoobSStWhrcrCiyg@mail.gmail.com>
 <CAEP4de2GsEwn0eeO126GEtFb-FSJoU3fgOWTAr1yPFAmyXTi0Q@mail.gmail.com>
 <87oafiuys0.fsf@x220.int.ebiederm.org> <56329880.4080103@android.com>
 <87k2q1tmna.fsf@x220.int.ebiederm.org>
Message-ID: <5638FB2F.8040107@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2015 01:50 PM, Eric W. Biederman wrote:
> Daniel Cashman <dcashman@android.com> writes:
> 
>> On 10/28/2015 08:41 PM, Eric W. Biederman wrote:
>>> Dan Cashman <dcashman@android.com> writes:
>>>
>>>>>> This all would be much cleaner if the arm architecture code were just to
>>>>>> register the sysctl itself.
>>>>>>
>>>>>> As it sits this looks like a patchset that does not meaninfully bisect,
>>>>>> and would result in code that is hard to trace and understand.
>>>>>
>>>>> I believe the intent is to follow up with more architecture specific
>>>>> patches to allow each architecture to define the number of bits to use
>>>>
>>>> Yes.  I included these patches together because they provide mutual
>>>> context, but each has a different outcome and they could be taken
>>>> separately.
>>>
>>> They can not.  The first patch is incomplete by itself.
>>
>> Could you be more specific in what makes the first patch incomplete?  Is
>> it because it is essentially a no-op without additional architecture
>> changes (e.g. the second patch) or is it specifically because it
>> introduces and uses the three "mmap_rnd_bits*" variables without
>> defining them?  If the former, I'd like to avoid combining the general
>> procfs change with any architecture-specific one(s).  If the latter, I
>> hope the proposal below addresses that.
> 
> A bit of both.  The fact that the code can not compile in the first
> patch because of missing variables is distressing.  Having the arch
> specific code as a separate patch is fine, but they need to remain in
> the same patchset.
> 

The first patch would compile as long as CONFIG_ARCH_MMAP_RND_BITS were
not defined without also defining the missing variables. I actually
viewed this as a safeguard against attempting to use those variables
without architecture support, but am ok with changing it.

I've gone ahead and submitted [PATCH v2] which aims to reduce
duplication in the arch-specific config files and concerning those
variables.  The only caveat is that now the second patch depends on the
first, whereas before it did not.

Thank You,
Dan
