From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2012 15:37:32 +0100
Subject: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <5017EBDC.6010005@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-10-git-send-email-lee.jones@linaro.org>
 <20120731135614.GR6802@n2100.arm.linux.org.uk> <5017EBDC.6010005@linaro.org>
Message-ID: <20120731143732.GS6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:29:48PM +0100, Lee Jones wrote:
> On 31/07/12 14:56, Russell King - ARM Linux wrote:
>> On Tue, Jul 31, 2012 at 02:31:30PM +0100, Lee Jones wrote:
>>> The current kernel commandline for ux500 based devices includes
>>> hard-coded allocations for things like mali and hwmem, which
>>> actually run over lowmem. Here we enable highmem in order to
>>> avoid memory corruption errors.
>>
>> Err what?  highmem should make no difference if things are being done
>> correctly.
>>
>> In other words, your patch description is too vague to understand what
>> the problem is and why you have to force highmem on - and nothing should
>> _require_ highmem.
>
> I think I must have misunderstood some advice which was recently given  
> to me. I'll drop the patch.
>
> Thanks for reviewing.

There are two reasons for not doing this:

1. it is wrong to force core optional features on by using 'select'
2. it is wrong to use 'select' on user visible symbols because it creates
   confusion, and prevents the user from disabling the option.

Note that highmem is just a hack to make larger memory systems work before
64-bit systems happen - it is _known_ to make systems unstable with large
amounts of highmem (even on x86) due to the requirement to have a certain
amount of metadata stored in lowmem.

Nothing should ever force anyone to have highmem enabled.

I still fail to see how not having highmem enabled would ever cause memory
corruption errors (unless something dealing with memory in a very very
wrong way - iow, not using one of the reservation or memory allocation
methods provided by the kernel.)
