From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 6 Aug 2014 15:05:31 -0400
Subject: [PATCH] PCI: keystone: add a pci quirk to limit mrrs
In-Reply-To: <20140806173014.GD19914@obsidianresearch.com>
References: <1407338300-9146-1-git-send-email-m-karicheri2@ti.com>
 <20140806163021.GB19914@obsidianresearch.com> <53E25E24.8070506@ti.com>
 <20140806165837.GC19914@obsidianresearch.com> <53E26155.1020107@ti.com>
 <20140806173014.GD19914@obsidianresearch.com>
Message-ID: <53E27C7B.80200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2014 01:30 PM, Jason Gunthorpe wrote:
> On Wed, Aug 06, 2014 at 01:09:41PM -0400, Murali Karicheri wrote:
>
>>>> Yes it works with tuning enabled. Tuning happens afterwards. The
>>>> 'limiting mrrs to 256' below is from my patch.
>>>
>>> That seems backwards to me...
>> Rational? The tuning is reading mrrs and set mps to less than or
>> equal to mrss. So adding this before make sure mrrs used is below
>> keystones's limit.
>
> The tuning process adjusts the parameters however it sees fit, todays
> algorithm might not increase a BIOS set MRRS, but tomorrow's could.
>
> The quirk should be after the tuning to ensure the MRRS is limited..
>
> Jason
Ok. I see it.

The latest possible quirk application point seems to be before enabling
the ep device. A change in macro as below will achieve this and it works.

-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);

If this looks reasonable, I will repost my patch with this change.

regards,

Murali
