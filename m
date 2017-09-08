From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 8 Sep 2017 17:36:04 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY2IDQvN10gYXJtNjQ6IGt2bTogc3VwcG9ydCB1c2Vy?=
 =?gb2312?Q?_space_to_query_RAS_extension_feature?=
In-Reply-To: <59B1747A.5030909@arm.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-5-git-send-email-gengdongjiu@huawei.com>
 <59A84F9D.8030309@arm.com> <29951852-8d91-7c33-c68b-ad8b4bbdea54@huawei.com>
 <59B1747A.5030909@arm.com>
Message-ID: <0184EA26B2509940AA629AE1405DD7F2015F61EA@DGGEMA503-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI James,

[...]
> 
> The code to signal memory-failure to user-space doesn't depend on the CPU's RAS-extensions.
I roughly check your answer and agree with your general idea.
late I will check it in detail.

I have a question, do you sure that if CPU does not support RAS-extensions kernel can still call memory-failure() to send signal to qemu?

After my checking the code, the general flow is RAS module detects the error or CPU consumes the hardware poison data, happen exception, then EL3 firmware records the address to APEI table and send
notification to kernel. Kernel parses the APEI table to get address and call memory_failure() to identify the page to poison. That is to say, usually, after RAS detect the error, it call memory_failure(),
otherwise, it does not know whether this address is poison.
I am worried about one thing, if hardware does not has RAS, OS cannot know which address is poison, so it cannot identify the address , then the address that is delivered to Qemu(user space) may not right.

As you said, kernel can also call memory_failure() even without RAS support. in this without RAS case, how it consider the address is poison and needs to send SIGBUS to QEMU?

> 
> If Qemu supports notifying the guest about RAS errors using CPER records, it should generate a HEST describing firmware first. It can then
> choose the notification methods, some of which may require optional KVM APIs to support.
> 
> Seattle has a HEST, it doesn't support the CPU RAS-extensions. The kernel can notify user-space about memory_failure() on this machine. I
> would expect Qemu to be able to receive signals and describe memory errors to a guest (1).

Usually we consider the address got from APEI table is poison. If so, I want to know, without RAS and APEI table, how it identify the address to hwpoison?
