From: labbott@redhat.com (Laura Abbott)
Date: Wed, 1 Mar 2017 07:18:33 -0800
Subject: [PATCH] arm64: dump: hide kernel pointers
In-Reply-To: <20170301035214.GA12637@arm.com>
References: <1488265536-20441-1-git-send-email-miles.chen@mediatek.com>
 <CAKv+Gu_AG0n5jPDCuUD6tvr2sAz9a4sycDy9CtL4iT+OHiN_iQ@mail.gmail.com>
 <20170228100420.GA3691@leverpostej>
 <ae6f608f-6c84-b999-d238-a74f6f42d2e5@redhat.com>
 <20170301035214.GA12637@arm.com>
Message-ID: <f27a46b7-e26f-5b22-be24-9e275ca19036@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 07:52 PM, Will Deacon wrote:
> On Tue, Feb 28, 2017 at 02:55:51PM -0800, Laura Abbott wrote:
>> On 02/28/2017 02:04 AM, Mark Rutland wrote:
>>> On Tue, Feb 28, 2017 at 08:42:51AM +0000, Ard Biesheuvel wrote:
>>>> On 28 February 2017 at 07:05, Miles Chen <miles.chen@mediatek.com> wrote:
>>>>> Mask kernel pointers of /sys/kernel/debug/kernel_page_tables entry like
>>>>> /proc/vmallocinfo does.
>>>>>
>>>>> With sysctl kernel.kptr_restrict=0 or 1:
>>>>> cat /sys/kernel/debug/kernel_page_tables
>>>>
>>>> I wonder if this file should be accessible at all if kptr_restrict > 0
>>>
>>> I don't have strong feelings either way.
>>>
>>> This isn't typically enabled, and it's under debugfs, so this shouldn't
>>> be accessible by a typical user anyhow.
>>>
>>> That said, there are very few of us who need to take a look at this
>>> file. I'm happy to deal with attacking kptr_restrict when required.
>>>
>>
>> In the interest of security it's probably for the best to switch to the
>> restricted pointer. Who knows what might get enabled or forgotten about.
>> I don't like the idea of tying enablement of the file to kptr_restrict
>> though.
> 
> ... but it's also pretty weird to show the sizes, mapping type and
> permissions yet hide the virtual addresses. If you want to keep the file
> in spite of kptr_restrict, which bits are actually useful once the
> addresses are nobbled?
> 
> Will
> 

I'm not saying the file is really useful, I just don't think kptr_restrict
is the right mechanism for this. The current documented purpose is for printk
formatting only and trying to double use that seems likely to confuse 
people if others start following the pattern elsewhere in the kernel.
A separate knob might be cleaner.

Thanks,
Laura
