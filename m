From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 4 Jul 2018 14:08:17 +0100
Subject: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
 <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
Message-ID: <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/07/18 11:00, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Marc Zyngier wrote:
>> On 04/07/18 09:23, Daniel Lezcano wrote:
>>>
>>> If the patches fix a bug which already exist, it makes sense to
>>> propagated the fix back to the stable versions.
>>
>> That's your call, but I'm not supportive of that decision, specially as
>> we have information from the person developing the workaround that this
>> doesn't fully address the issue.
> 
> The patches should not be applied at all. Simply because they don't fix the
> issue completely.
> 
> From a quick glance at various links and information about this, this very
> much smells like the FSL_ERRATUM_A008585.
> Has that been tried? It looks way more robust than the magic 11 bit
> crystal ball logic.

The Freescale erratum is similar, but not identical [1].
It seems like the A64 is less variable, so we can use a cheaper
workaround, which gets away with normally just one sysreg read. But then
again the newer error reports may actually suggest otherwise ...

And as it currently stands, the Freescale erratum has the drawback of
relying on the CPU running much faster than the timer. The A64 can run
at 24 MHz (for power savings, or possibly during DVFS transitions),
which is the timer frequency. So subsequent counter reads will never
return the same value and the workaround times out.

Cheers,
Andre.

[1] https://lists.denx.de/pipermail/u-boot/2016-November/271836.html
