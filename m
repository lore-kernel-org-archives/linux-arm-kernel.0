From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 07 May 2013 20:26:07 -0600
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com>
Message-ID: <5189B7BF.8070607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 07:13 PM, Peter Chen wrote:
> On Wed, May 8, 2013 at 6:53 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Many USB host drivers contain code such as:
>>
>> if (!pdev->dev.dma_mask)
>>         pdev->dev.dma_mask = &tegra_ehci_dma_mask;
>>
>> ... where tegra_ehci_dma_mask is a global. I suspect this code originated
>> in commit 4a53f4e "USB: ehci-tegra: add probing through device tree" and
>> was simply copied everywhere else.
> 
> One question: why device tree can't do this when create device?

This probably could be initialized from some DT property. However,
there's no such property defined right now, and considering that DT is
supposed to be an ABI, we'd always need the code in this patch as a
fallback for DTs that were created before any such property was defined.

Equally, since the data is SoC-specific rather than board-specific, and
is even fairly unlikely to vary between SoC versions since these values
are all 0xffffffff anyway, I don't really see much point in putting it
into DT, rather than just putting the static data into the driver.
