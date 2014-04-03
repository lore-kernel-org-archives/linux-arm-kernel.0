From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Thu, 3 Apr 2014 09:55:06 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140403085636.GL7528@n2100.arm.linux.org.uk>
References: <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <b974be3a995f41029b54cfcc10c732ef@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402085914.GG7528@n2100.arm.linux.org.uk>
 <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402104644.GI7528@n2100.arm.linux.org.uk>
 <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402165113.GJ7528@n2100.arm.linux.org.uk>
 <a52a4e6119c143799220667a25781844@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140403085636.GL7528@n2100.arm.linux.org.uk>
Message-ID: <f5dfa7eca60346e884768bf821594d06@BY2PR03MB377.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Data: Thursday, April 03, 2014 4:57 PM

>To: Duan Fugang-B38611
>Cc: robert.daniels at vantagecontrols.com; Marek Vasut; Detlev Zundel; Troy Kisky;
>Grant Likely; Bernd Faust; Fabio Estevam; linux-arm-kernel at lists.infradead.org
>Subject: Re: FEC ethernet issues [Was: PL310 errata workarounds]
>
>On Thu, Apr 03, 2014 at 02:41:46AM +0000, fugang.duan at freescale.com wrote:
>> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Data: Thursday, April 03, 2014 12:51 AM
>>
>> >To: Duan Fugang-B38611
>> >Cc: robert.daniels at vantagecontrols.com; Marek Vasut; Detlev Zundel;
>> >Troy Kisky; Grant Likely; Bernd Faust; Fabio Estevam;
>> >linux-arm-kernel at lists.infradead.org
>> >Subject: Re: FEC ethernet issues [Was: PL310 errata workarounds]
>> >
>> >On Wed, Apr 02, 2014 at 11:33:22AM +0000, fugang.duan at freescale.com wrote:
>> >> In kernel 3.0.35, there have no CMA memory allocate mechanism.
>> >> Below Kernel configs are enabled:
>> >> CONFIG_ARM_DMA_MEM_BUFFERABLE
>> >> CONFIG_SMP
>> >>
>> >> If use dma_alloc_coherent() allocate memory, it must be
>> >> non-cacheable, but bufferable.  The new invented api
>"dma_alloc_noncacheable()"
>> >> allocate memory is non-cacheable, non-bufferable, the memory type
>> >> is Strongly ordered.
>> >
>> >Right, so what you've just said is that it's fine to violate the
>> >requirements of the architecture L1 memory model by setting up a
>> >strongly ordered memory mapping for the same physical addresses as an
>> >existing mapping which is mapped as normal memory.
>> >
>> >Sorry, I'm not going to listen to you anymore, you just lost any kind
>> >of authority on this matter.
>> >
>> >> >> So wmb() is not necessary.
>> >> >
>> >> >Even on non-cacheable normal memory, the wmb() is required.
>> >> >Please read up in the ARM architecture reference manual about
>> >> >memory types and their various attributes, followed by the memory
>ordering chapters.
>> >> >
>> >> >> Yes, it don't impact imx6q since cpu loading is not bottleneck
>> >> >> due rx/tx bandwidth is slow and multi-cores.  But for imx6sx,
>> >> >> enet rx can reach at 940Mbps, tx can reach at 900Mbps, imx6sx is sigle
>core.
>> >> >
>> >> >What netdev features do you support to achieve that?
>> >> >
>> >> Imx6sx enet accleration feature support crc checksum, interrupt coalescing.
>> >> So we enable the two features.
>> >
>> >Checksum and... presumably you're referring to NAPI don't get you to
>> >that kind of speed.  Even on x86, you can't get close to wire speed
>> >without GSO, which you need scatter-gather for, and you don't support
>> >that.  So I don't believe your 900Mbps figure.
>> >
>> >Plus, as you're memcpy'ing every packet received, I don't believe you
>> >can reach 940Mbps receive either.
>> >
>> Since Imx6sx enet still don't support TSO and Jumbo packet,
>> scatter-gather cannot improve ethernet performance in Most cases
>> special for iperf test.
>
>Again, you are losing credibility every time you deny stuff like this.
>I'm now at the point of just not listening to you anymore because you're
>contradicting what I know to be solid fact through my own measurements.
>
>This seems to be Freescale's overall attitude - as I've read on Freescale's
>forums.  Your customers/users are always wrong, you're always right.  Eg, any
>performance issues are not the fault of Freescale stuff, it's tarnished
>connectors or similar.
>
Hi, Russell,

I don't contradict your thinking/solution and measurements.  You are expert on arm/modules, we keep study attitude to dicuss with you.
For imx6sx, we indeed get the result. For imx6q/dl linux upstream, you did great job on performance tuning, and the test result is similar
To our internal test result. Your suggestion for the optimiztion is meaningful. Pls understand my thinking.  

Thanks,
Andy
