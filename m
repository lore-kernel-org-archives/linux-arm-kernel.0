From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 10 Feb 2016 10:08:17 -0800
Subject: [PATCH] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <20160210092822.GA1052@arm.com>
References: <1455046156-10582-1-git-send-email-ddaney.cavm@gmail.com>
 <20160210092822.GA1052@arm.com>
Message-ID: <56BB7C91.5010205@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2016 01:28 AM, Will Deacon wrote:
> On Tue, Feb 09, 2016 at 11:29:16AM -0800, David Daney wrote:
>> From: Andrew Pinski <apinski@cavium.com>
>>
>> On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
>> instructions may cause the icache to become invalid if it contains
>> data for a non-current ASID.
>>
>> This patch implements the workaround (which flushes the local icache
>> when switching the mm) by using code patching.
>
> So, to be clear, is this "just" a performance problem as opposed to a
> correctness issue?

No.  It is a correctness issue.  Without this workaround in place, 
userspace programs end up executing the wrong instructions, which leads 
to unpredictable behavior and program crashes.


> If so, do you have any numbers with and without this
> change?

We tried to measure it, but the impact is not measurable in the tests we 
have done.  Switching the mm is not often done so the extra ICache 
invalidation is rare.

Also note that for the non-workaround case, the code path is unchanged. 
  Since the following function (__cpu_setup()) is not on the hot path of 
anything, any extra ICache pressure from the three NOPs is unlikely to 
matter.

>
> Will
>
