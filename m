From: chuhu@redhat.com (Chunyu Hu)
Date: Fri, 10 Aug 2018 02:30:20 -0400 (EDT)
Subject: Bug report: Bad mode in FIQ handler detected on CPU0, code
 0x56000000
In-Reply-To: <20180809131622.GC29785@arm.com>
References: <1426298268.23978174.1533818483053.JavaMail.zimbra@redhat.com>
 <381494229.23979617.1533818858635.JavaMail.zimbra@redhat.com>
 <20180809131622.GC29785@arm.com>
Message-ID: <70910961.24172948.1533882620742.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- Original Message -----
> From: "Will Deacon" <will.deacon@arm.com>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Sent: Thursday, August 9, 2018 9:16:22 PM
> Subject: Re: Bug report: Bad mode in FIQ handler detected on CPU0, code 0x56000000
> 
> Hi Chunyu,
> 
> On Thu, Aug 09, 2018 at 08:47:38AM -0400, Chunyu Hu wrote:
> > I hit an 100% panic when I executed:
> > 
> > perf &
> > perf top
> > 
> > Logs are as below,
> > 
> > [  123.234492] Bad mode in FIQ handler detected on CPU0, code 0x56000000 --
> > SVC (AArch64)
> 
> Oh dear...
> 
> We don't support FIQ in Linux, since:
> 
> (a) It's seldom available on the non-secure side
> (b) It's not necessarily "fast", despite the name
> (c) We'd be opening up a can of worms if we allow FIQ to preempt IRQ. Better
>     off using SDEI or GIC priorities to implement NMIs.
> (d) I don't think FIQs can be described in ACPI or DT
> 
> In this case, it looks like the PMU interrupt has been configured as a FIQ.
> It should be possible to configure the GIC in firmware (not sure you have
> EL3, so maybe in the bootloader) to treat this interrupt as an IRQ instead,
> in which case perf top will work correctly as long as the ACPI tables / FDT
> accurately describe the interrupt.

Will,

Thank you so much for the explanation. 

> 
> Will
> 

-- 
Regards,
Chunyu Hu
