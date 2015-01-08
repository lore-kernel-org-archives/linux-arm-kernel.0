From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 08 Jan 2015 08:28:46 -0800
Subject: [RESEND PATCH v15 07/11] KVM: arm: page logging 2nd stage fault
 handling
In-Reply-To: <20150108104510.GI21092@cbox>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418868449-23397-1-git-send-email-m.smarduch@samsung.com>
 <20150107123844.GA21092@cbox> <54ADE0B6.1060703@samsung.com>
 <20150108104510.GI21092@cbox>
Message-ID: <54AEB03E.8080305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 02:45 AM, Christoffer Dall wrote:
> On Wed, Jan 07, 2015 at 05:43:18PM -0800, Mario Smarduch wrote:
>> Hi Christoffer,
>>   before going through your comments, I discovered that
>> in 3.18.0-rc2 - a generic __get_user_pages_fast()
>> was implemented, now ARM picks this up. This causes
>> gfn_to_pfn_prot() to return meaningful 'writable'
>> value for a read fault, provided the region is writable.
>>
>> Prior to that the weak version returned 0 and 'writable'
>> had no optimization effect to set pte/pmd - RW on
>> a read fault.
>>
>> As a consequence dirty logging broke in 3.18, I was seeing
Correction on this, proper __get_user_pages_fast()
behavior exposed a bug in page logging code.

>> weird but very intermittent issues. I just put in the
>> additional few lines to fix it, prevent pte RW (only R) on
>> read faults  while  logging writable region.
>>
>> On 01/07/2015 04:38 AM, Christoffer Dall wrote:
>>> On Wed, Dec 17, 2014 at 06:07:29PM -0800, Mario Smarduch wrote:
>>>> This patch is a followup to v15 patch series, with following changes:
>>>> - When clearing/dissolving a huge, PMD mark huge page range dirty, since
>>>>   the state of whole range is unknown. After the huge page is dissolved 
>>>>   dirty page logging is at page granularity.
>>>
>>> What is the sequence of events where you could have dirtied another page
>>> within the PMD range after the user initially requested dirty page
>>> logging?
>>
>> No there is none. My issue was the start point for tracking dirty pages
>> and that would be second call to dirty log read. Not first
>> call after initial write protect where any page in range can
>> be assumed dirty. I'll remove this, not sure if there would be any
>> use case to call dirty log only once.
>>
> 
> Calling dirty log once can not give you anything meaningful, right?  You
> must assume all memory is 'dirty' at this point, no?

There is the interval between KVM_MEM_LOG_DIRTY_PAGES and first
call to KVM_GET_DIRTY_LOG. Not sure of any use case, maybe enable
logging, wait a while do a dirty log read, disable logging.
Get an accumulated snapshot of dirty page activity.

- Mario

> 
> -Christoffer
> 
