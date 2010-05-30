From: bbb.lst@gmail.com (Bjoern Brandenburg)
Date: Sun, 30 May 2010 17:05:31 -0400
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
Message-ID: <AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 30, 2010 at 3:27 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> On Sun, May 30, 2010 at 3:36 AM, Daniel Mack <daniel@caiaq.de> wrote:
>> On Sat, May 29, 2010 at 06:02:28PM -0400, Bjoern Brandenburg wrote:
>>> We've tried three kernel versions:
>>> - 2.6.33-arm1 [1]
>>> ? - boot log: http://pastebin.com/UqhfJNgz
>>> - 2.6.34-vanilla
>>> ? - boot log with maxcpus=1: http://pastebin.com/NHHeYpbb
>>> ? - boot log with failure: http://pastebin.com/uy6y8msZ
>>> ? - config: http://pastebin.com/v9dttg0L
>>> - 2.6.34-arm ?[2]
>>> ? - boot log with maxcpus=1: http://pastebin.com/rCy2x9AP
>>> ? - boot log with failure: http://pastebin.com/spam.php?i=mpedVqp3
>>>
>>> Of these, only 2.6.33-arm1 boots with more than one CPU enabled. The 2.6.34
>>> versions only boot to login if we restrict the number of CPUs. The configuration
>>> used in all cases is based on the one provided by ARM [3]. For 2.6.34, we used
>>> 'make oldconfig' and accepted all defaults.
>>
>> This sounds like a perfect case for giving 'git bisect' a try. It will
>> point you to the commit between 2.6.33 and 2.6.34 which broke it for
>> you.
>>
>> See for example http://www.landley.net/writing/git-quick.html#bisect for
>> a detailed explanation of how to use it.
>
> Thanks. I gave it a shot. ?Unfortunately, 2.6.33 vanilla doesn't work
> either, and their is no common history between 2.6.33-arm1 and 2.6.34
> (either vanilla or -arm). Thus, I don't have a good commit to start
> from.
>
> Basically, as far as I can tell, no vanilla kernel has ever worked
> with SMP enabled on the ?PB11MPCore, but 2.6.28 and 2.6.33 worked with
> vendor patches applied. Some of these patches were picked up for
> 2.6.34, but even with those it still doesn't work. Worse, now even the
> vendor patches provided at http://linux-arm.org/git?p=linux-2.6.git
> don't work anymore, either. I realize that ARM's 2.6.34 repository is
> still in a state of flux, thus my question whether this is a known
> issue.
>
> I'll try to see if I can pinpoint what was dropped between 2.6.33-arm1
> and 2.6.34-arm.

Progress: I can get 2.6.34-arm to boot with all 4 CPUs after
cherry-picking the following commits (which seemed relevant but
absent):

60060ca ARM: Handle instruction cache maintenance fault  properly
3f64e83 ARM errata: Eviction Buffer not empty after Cache Sync on L220
3b009b5 ARM: change definition of cpu_relax() for ARM11MPCore

Let's see which is the critical one...

- Bj?rn
