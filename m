From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 10 Mar 2016 14:57:02 +0700
Subject: BUG in HugeTLBFS with Contiguous hint
In-Reply-To: <56E048E6.9030508@mellanox.com>
References: <20160309021252.GA4573@linaro.org> <20160309153131.GF28496@arm.com>
 <56E048E6.9030508@mellanox.com>
Message-ID: <CAPvkgC1Oe=AiDDwSO_38bz_7FPwg3XoHK_Tts_UPorexkgFnhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Replying to both inline below:

On 9 March 2016 at 23:01, David Woods <dwoods@mellanox.com> wrote:
> On 03/09/2016 10:31 AM, Will Deacon wrote:
>>
>> On Wed, Mar 09, 2016 at 02:12:56AM +0000, Steve Capper wrote:
>>>
>>> Hi,
>>
>> Hi Steve,
>>
>>> I am very sorry for the very late bug report. I have just come across
>>> this error.
>>>
>>> Whilst testing something else, I found that 2MB HugeTLB pages formed
>>> from contiguous pte's cause BUGs to appear when running through the
>>> libhugetlbfs test suite.
>>
>> Ouch. Any idea why this wasn't spotted earlier? Did something else
>> change?

Sorry, no. A lot of stuff has changed (and I need to double check my
.config too). I will be able to dig into this in more detail when I
get back in the office next week (I have a painfully slow internet
connection to my devboard at the moment).

>
>
> I'm reasonably sure that I ran that same test before pushing this patch.
> That was with the arm64-next tree which was at 4.4-rc3 at the time.  It's
> possible there's been some regression since then.  I can check on that.
>>>
>>> I have been digging into this and I think the problem is due to the
>>> huge pages not being unmapped properly (the nature of the bugs is that
>>> compound pages have a non-negative compound mapped count, thus appear
>>> as mapped in the hugetlbfs inode destruction logic); but I have not
>>> yet been able to convincingly isolate the problem.
>>>
>>> I ran with 64KB PAGE_SIZE and CONFIG_DEBUG_VM. Failure mode at the
>>> bottom of this email for a 4.5-rc7 kernel.
>
>
> I did run into this same BUG during my testing.  The cause that time was a
> bug in huge_ptep_get_and_clear().  It was clearing PTEs beyond the ncontig
> that it was supposed to.  The logic in remove_inode_hugepages got confused
> when it found those victim PTEs already zeroed out.  That bug was fixed of
> course, but maybe something similar is happening now.
>
>> A revert is certainly the easiest option, but it also seems unfortunate.
>>
>> Maybe something like the patch below instead? It can be reverted as soon
>> as this is worked out. Can you confirm that this avoids the BUG?
>
>
> I haven't tested it, but your patch looks reasonable to me.

The fix looks reasonable to me too. I've given it a test on both 64KB
granule (only 512MB huge pages appeared as expected) and 4KB granule
(libhugetlbfs passed all tests for 2MB huge pages which were the only
ones to appear - as expected).

Cheers,
--
Steve
