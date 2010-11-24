From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 24 Nov 2010 21:46:06 +0800
Subject: [question] NR_IRQS in genirq
In-Reply-To: <alpine.LFD.2.00.1011241416360.2900@localhost6.localdomain6>
References: <AANLkTimoBdFyQ6GfS2DKiF0wdRox0x7MfM0_keD9Z1D0@mail.gmail.com>
	<alpine.LFD.2.00.1011241416360.2900@localhost6.localdomain6>
Message-ID: <AANLkTik5N0d9wcaiS538UWQ83E_HhXoWC8nMxVY__1+k@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 9:18 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 24 Nov 2010, Haojian Zhuang wrote:
>
>> Hi all,
>>
>> I'm using the latest kernel 2.6.37-rc1. Now I met some issues on genirq.
>>
>> 1. While SPARSE IRQ is enabled, nr_irqs may be larger than NR_IRQS.
>> But the allocated_irqs bitmap (kernel/irq/irqdesc.c) is restricted in
>> NR_IRQS. Is it an issue?
>
> Why can nr_irqs become larger? Is that a theoretical problem or did
> you run into this ?
>
>

Hi Thomas,

My hardware environment is ARM. Each machine description can specify
nr_irqs. In my implementation of PXA, NR_IRQS is fixed for SoC
internal IRQs. And there's some additional board IRQs, we arrange them
between NR_IRQS and nr_irqs. So nr_irqs will be larger than NR_IRQS if
board IRQs exists.

We use dynamic board IRQs since each machine has different
requirement. And CONFIG_HARDIRQ_SW_RESEND is occasionally, I actually
met issue in resend_irqs because of accessing bitmap memory out of
bound.

Do you mean that we shouldn't use SPARSE IRQ by this way?

Best Regards
Haojian
