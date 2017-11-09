From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Thu, 9 Nov 2017 10:43:31 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <7cdfa633-d9c6-881a-ae5f-f94f7e6413ee@nvidia.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
 <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
 <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
 <a384e96c-27c7-782b-75b9-7525714f5831@collabora.com>
 <613bcd63-a215-acbe-9150-c1495f7604f6@collabora.com>
 <5740b853-4898-2ebc-f67d-0808d1b44c36@nvidia.com>
 <ab2ee0a8-6584-7436-ca1b-4f1b521279b0@collabora.com>
 <7cdfa633-d9c6-881a-ae5f-f94f7e6413ee@nvidia.com>
Message-ID: <5f064e65-ee29-179b-8102-984d12d24d9d@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/17 09:55, Jon Hunter wrote:
>
> On 08/11/17 16:42, Guillaume Tucker wrote:
>> On 08/11/17 15:57, Jon Hunter wrote:
>>>
>>> On 08/11/17 15:19, Guillaume Tucker wrote:
>>>
>>> ...
>>>
>>>> After a few more automated bisection attempts and a bug fix in
>>>> LAVA, I've now found at least one potentially breaking commit:
>>>>
>>>>   commit d89e2378a97fafdc74cbf997e7c88af75b81610a
>>>>   Author: Robin Murphy <robin.murphy@arm.com>
>>>>   Date:   Thu Oct 12 16:56:14 2017 +0100
>>>>
>>>>       drivers: flag buses which demand DMA configuration
>>>>
>>>>
>>>> I've run some boot tests manually with this revision and then
>>>> also after reverting it in-place, these respectively failed and
>>>> passed:
>>>>
>>>>   * d89e2378, failed:
>>>>     https://lava.collabora.co.uk/scheduler/job/978968
>>>>
>>>>   * d89e2378 reverted, passed:
>>>>     https://lava.collabora.co.uk/scheduler/job/978969
>>>>
>>>>
>>>> I then went on and tried the same but on top of next-20171108 and
>>>> found that they both failed
>>>>
>>>>   * next-20171108, failed:
>>>>     https://lava.collabora.co.uk/scheduler/job/979063
>>>>
>>>>   * next-20171108 with d89e2378 reverted, failed as well:
>>>>     https://lava.collabora.co.uk/scheduler/job/979167
>>>>
>>>>
>>>> So this shows there is almost certainly another offending commit
>>>> in -next.  The errors in both cases are not quite the same, the
>>>> last one is triggered by a BUG whereas the first one is a NULL
>>>> pointer (I haven't looked any further).  Also I don't think
>>>> there's any fix for d89e2378a97fafdc74cbf997e7c88af75b81610a
>>>> which is currently still in next.
>>>
>>> This crash is a known issue [0] and we have been discussing this. Can
>>> you try applying [1]?
>>
>> So with next-20171108 + d89e2378a9 reverted + [1] applied:
>>
>>   https://lava.collabora.co.uk/scheduler/job/979173
>>
>> No visible kernel crash in the log but it hangs.
>>
>>
>> I also tried next-20171108 + [1] applied only:
>>
>>   https://lava.collabora.co.uk/scheduler/job/979179
>>
>> which also appears to hang.
>
> Thanks for the update. I am wondering if it is one of the kernel modules
> that is getting loaded because booting multi_v7_defconfig and loading no
> modules does not hang for me. I will take a look but I might not get to
> it until next week.

I actually built these kernel revisions with module support
disabled to speed up the builds, and no modules are being
downloaded in the LAVA job.

If you have a public URL with your known working kernel zImage
and dtb, let me know so I could re-run the same test LAVA boot
test to see if I get the same results as you (i.e. no hang).

Guillaume
