From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 27 Aug 2014 11:13:47 -0700
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <53FE1A7A.4010906@wwwdotorg.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-3-git-send-email-abrestic@chromium.org>
 <53FB8820.4010202@wwwdotorg.org>
 <CAL1qeaERHeKKNpqh9qHOppgT7ymvntisdjVvZheP78U6NaPz-A@mail.gmail.com>
 <53FE1A7A.4010906@wwwdotorg.org>
Message-ID: <CAL1qeaGPr=BeYL1-=ddRL7rSuvYdQcd6vCEEHDrNA-KYst6bnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 10:50 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/27/2014 11:38 AM, Andrew Bresticker wrote:
>>
>> On Mon, Aug 25, 2014 at 12:01 PM, Stephen Warren <swarren@wwwdotorg.org>
>> wrote:
>>>
>>> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>>>>
>>>> +static int tegra_xusb_mbox_probe(struct platform_device *pdev)
>>>
>>>
>>>
>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>
>>>> +       if (!res)
>>>> +               return -ENODEV;
>>>
>>>
>>>
>>> Should devm_request_mem_region() be called here to claim the region?
>>
>>
>> No, the xHCI host driver also needs to map these registers, so they
>> cannot be mapped exclusively here.
>
>
> That's unfortunate. Having multiple drivers with overlapping register
> regions is not a good idea. Can we instead have a top-level driver map all
> the IO regions, then instantiate the various different sub-components
> internally, and divide up the address space. Probably via MFD or similar.
> That would prevent multiple drivers from touching the same register region.

Perhaps I'm misunderstanding, but I don't see how MFD would prevent us
from having to map this register space in two different locations -
the XUSB FPCI address space cannot be divided cleanly between host and
mailbox registers.  Or are you saying that there should be a separate
device driver that exposes an API for accessing this register space,
like the Tegra fuse or PMC drivers?
