From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 18 Jun 2015 15:10:43 -0500
Subject: [PATCH 10/15] PCI: kill off set_irq_flags usage
In-Reply-To: <CAL_Jsq+5820W8N1Pbmv8JXzz7mH_H89HhtjXK_FAYbWAwBd8Ng@mail.gmail.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-11-git-send-email-robh@kernel.org>
 <20150618165954.GE7710@google.com>
 <CAL_Jsq+5820W8N1Pbmv8JXzz7mH_H89HhtjXK_FAYbWAwBd8Ng@mail.gmail.com>
Message-ID: <CAErSpo6VWA-kxESd4VVrf9zLoy19JcFWKFCvnzCCNPe64bzkXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 3:08 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Jun 18, 2015 at 11:59 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Jun 09, 2015 at 01:26:36PM -0500, Rob Herring wrote:
>>> set_irq_flags is ARM specific with custom flags which have genirq
>>> equivalents. Convert drivers to use the genirq interfaces directly, so we
>>> can kill off set_irq_flags. The translation of flags is as follows:
>>>
>>> IRQF_VALID -> !IRQ_NOREQUEST
>>> IRQF_PROBE -> !IRQ_NOPROBE
>>> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>>>
>>> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
>>> and setting IRQ_NOREQUEST already, so there is no need to do this in
>>> .map() functions and we can simply remove the set_irq_flags calls. Some
>>> users also set IRQ_NOPROBE and this has been maintained although it is not
>>> clear that is really needed. There appears to be a great deal of blind
>>> copy and paste of this code.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Murali Karicheri <m-karicheri2@ti.com>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>>> Cc: Alexandre Courbot <gnurou@gmail.com>
>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>> Cc: Pratyush Anand <pratyush.anand@gmail.com>
>>> Cc: Simon Horman <horms@verge.net.au>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
>>> Cc: linux-omap at vger.kernel.org
>>> Cc: linux-pci at vger.kernel.org
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-tegra at vger.kernel.org
>>> Cc: linux-sh at vger.kernel.org
>>
>> This is the only part of the series on linux-pci, so I assume this will be
>> merged by somebody else along with the rest.
>
> I copied you on the intro, but all the lists and all the maintainers
> was too long to cc. Being late in the cycle I didn't really intend for
> this to be for 4.2, but you can pick up this patch if you want to as
> it doesn't have any dependencies. If you don't, then I will submit the
> whole series for 4.3.

OK, why don't you just include this with the rest of the series, since
I assume the whole series is related even if there's no actual
dependency.

Bjorn
