From: dwoods@mellanox.com (David Woods)
Date: Thu, 10 Mar 2016 17:23:18 -0500
Subject: BUG in HugeTLBFS with Contiguous hint
In-Reply-To: <CAPvkgC1Oe=AiDDwSO_38bz_7FPwg3XoHK_Tts_UPorexkgFnhA@mail.gmail.com>
References: <20160309021252.GA4573@linaro.org>
 <20160309153131.GF28496@arm.com> <56E048E6.9030508@mellanox.com>
 <CAPvkgC1Oe=AiDDwSO_38bz_7FPwg3XoHK_Tts_UPorexkgFnhA@mail.gmail.com>
Message-ID: <56E1F3D6.9020906@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2016 02:57 AM, Steve Capper wrote:
> Hi,
> Replying to both inline below:
>
> On 9 March 2016 at 23:01, David Woods <dwoods@mellanox.com> wrote:
>> On 03/09/2016 10:31 AM, Will Deacon wrote:
>>> On Wed, Mar 09, 2016 at 02:12:56AM +0000, Steve Capper wrote:
>>>> Hi,
>>> Hi Steve,
>>>
>>>> I am very sorry for the very late bug report. I have just come across
>>>> this error.
>>>>
>>>> Whilst testing something else, I found that 2MB HugeTLB pages formed
>>>> from contiguous pte's cause BUGs to appear when running through the
>>>> libhugetlbfs test suite.
>>> Ouch. Any idea why this wasn't spotted earlier? Did something else
>>> change?
> Sorry, no. A lot of stuff has changed (and I need to double check my
> .config too). I will be able to dig into this in more detail when I
> get back in the office next week (I have a painfully slow internet
> connection to my devboard at the moment).

I was able to verify that this is a regression.  I did a git bisect to 
track it down and it looks like the commit which caused this failure was 
61f5d698 mm: re-enable THP.  The BUG does go away if 
TRANSPARENT_HUGEPAGE is disabled.  I believe that means the problem came 
with any one of the 25 commits between 61f5d698 and 56a17b88 mm: 
temporarily mark THP broken.  I'll continue to try to debug it.

-Dave
