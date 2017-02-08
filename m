From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 8 Feb 2017 09:31:00 -0600
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <20170208144328.GS5020@rric.localdomain>
References: <20170201173833.12630-1-rrichter@cavium.com>
 <20170201173833.12630-2-rrichter@cavium.com>
 <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
 <20170208144328.GS5020@rric.localdomain>
Message-ID: <278df776-4d6d-3b89-7a94-effaafcebeb0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

In teardown path, code is still calling 'kfree(its->cmd_base)' to free 
memory, this should be changed to 'free_pages(get_order(ITS_CMD_QUEUE_SZ).


On 02/08/2017 08:43 AM, Robert Richter wrote:
> On 08.02.17 14:41:18, Marc Zyngier wrote:
>> On Wed, Feb 01 2017 at  5:38:25 pm GMT, Robert Richter
> <rrichter@cavium.com> wrote:
>>> The its command buffer must be page aligned, but kzalloc() is not
>>> guaranteed to be (though it is mostly when allocating 64k). Use
>>> __get_free_pages() as this is used for other buffers as well.
>>>
>>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>> I'm still going through this series, but as this is an obvious fix, I've
>> cherry-picked it for 4.11.
> That was actually my intention, thus I placed it first.
>
> -Robert
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
