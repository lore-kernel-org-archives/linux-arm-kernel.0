From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 20 Sep 2016 16:02:03 +0200 (CEST)
Subject: [PATCH v5 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <c2c8ad5f-e679-8522-808f-e940b8c6954d@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609131713490.6233@nanos>
 <6941f61d-0b33-4108-0135-b11887cd0488@st.com>
 <alpine.DEB.2.20.1609141103420.6233@nanos>
 <facd1c7c-d696-eae1-02e4-5a0c9285add0@st.com>
 <alpine.DEB.2.20.1609141532510.6233@nanos>
 <f64e4f9d-d811-2c6e-7c5a-d4ab06716e2c@st.com>
 <39c4ceee-7e05-ebfd-2ea0-3c4e1c4ea619@st.com>
 <alpine.DEB.2.20.1609201150160.6905@nanos>
 <053a37f4-aa10-46ea-f477-8ae55bb5773f@st.com>
 <alpine.DEB.2.20.1609201439440.6905@nanos>
 <c2c8ad5f-e679-8522-808f-e940b8c6954d@st.com>
Message-ID: <alpine.DEB.2.20.1609201600490.6905@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Sep 2016, Alexandre Torgue wrote:
> On 09/20/2016 02:44 PM, Thomas Gleixner wrote:
> > Free will be called when a interrupt in the child domain is torn down,
> > i.e. when irq_domain_free_irqs() is called. And it will be called for both
> > domains like the alloc callback is invoked on both domains via
> > irq_domain_alloc_irqs().
> 
> Thanks Thomas for this clarification (I'm sure now that we need .free
> callbacks).
> irq_domain_free_irqs() is called in 2 scenario:
> 1- when issue occurs in irq_create_fwspec_mapping()
> 2- when irq_dispose_mapping() is called
> 
> Case 2 is the one I tested some times ago. In this case, I need to mask
> interrupts in .free callback of EXTI (parent) domain to avoid spurious
> interrupts.

And why would irq_dispose_mapping() be called on an unmasked, i.e. active,
interrupt? The masking is just papering over that.

Thanks,

	tglx
