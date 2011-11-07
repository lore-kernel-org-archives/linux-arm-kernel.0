From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 7 Nov 2011 12:21:41 -0600
Subject: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <87obwr1n9i.fsf@ti.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
 <1320185752-568-5-git-send-email-omar.ramirez@ti.com>
 <87obwr1n9i.fsf@ti.com>
Message-ID: <CAB-zwWhkdv430aD8Osgi7Kyi6ScvhkwZ7BSW1cs3Nyzxc10VYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 4, 2011 at 6:27 PM, Kevin Hilman <khilman@ti.com> wrote:
>> @@ -821,9 +820,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>> ? ? ? if (!obj->refcount)
>> ? ? ? ? ? ? ? return IRQ_NONE;
>>
>> - ? ? clk_enable(obj->clk);
>> ? ? ? errs = iommu_report_fault(obj, &da);
>> - ? ? clk_disable(obj->clk);
>> ? ? ? if (errs == 0)
>> ? ? ? ? ? ? ? return IRQ_HANDLED;
>
> I'm not terribly familiar with this IOMMU code, but this one looks
> suspiciou because you're removing the clock calls but not replacing them
> with runtime PM get/put calls.
>
> I just want to make sure that's intentional. ?If so, you might want to
> add a comment about that to the changelog.

Yes it is intentional, reason is that in order to get an interrupt,
the device should be powered on in advance, right now it is working
because the modules share a common clock so the users of the
omap-iommu indirectly give power to it. However I made another change
to do pm_runtime_get/put on attach/detach so it doesn't rely on others
to keep the clocks on.

I'll add the comment.

Thanks,

Omar
