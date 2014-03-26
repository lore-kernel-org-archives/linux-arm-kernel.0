From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 26 Mar 2014 11:04:29 +0100
Subject: [PATCH v7 2/3] ARM: sun7i/sun6i: dts: Add NMI irqchip support
In-Reply-To: <20140326093946.GE6120@lukather>
References: <1395256879-8475-1-git-send-email-carlo@caione.org>
 <1395256879-8475-3-git-send-email-carlo@caione.org>
 <53329243.8090604@redhat.com> <20140326093946.GE6120@lukather>
Message-ID: <5332A62D.90302@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/26/2014 10:39 AM, Maxime Ripard wrote:
> On Wed, Mar 26, 2014 at 09:39:31AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 03/19/2014 08:21 PM, Carlo Caione wrote:
>>> This patch adds DTS entries for NMI controller as child of GIC.
>>>
>>> Signed-off-by: Carlo Caione <carlo@caione.org>
>>
>> Note this breaks the kernel on sun6i / A31 since we don't have a
>> pmic driver there yet, and thus the nmi gets constantly fired without
>> anything clearing it.
>>
>> So the sun6i section needs a status = "disabled"; until we actually have pmic
>> support.
> 
> I guess it also applies to the A20, since the PMIC patches will
> probably get merged later on?

Could be I've never tried it on the A20 without also having the pmic driver
build into the kernel. Thinking more about this, I think this actually is
a bug in the nmi irqchip driver, it should not unmask the gic irq until
it gets an unmask for its child irq itself.

Otherwise we can still get the same problem if ie the pmic driver is
a module, etc.

Hmm, looking at the code I see that it already masks (sets enable to 0)
the irq in sunxi_sc_nmi_irq_init. Note that this really should be
done before the irq_set_chained_handler call though, as from then on
the gic irq is unmasked, so we may get spurious irqs until the
sunxi_sc_nmi_write calls are done.

I don't think this will solve the A31 problem though, I wonder if
the enable reg-offset we've for the A31 is correct, maybe it should
be 8 like with the A20 ?

I'll give this a try when I can find some time for this.

Regards,

Hans
