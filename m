From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:59:55 +0000
Subject: [PATCH v10 18/18] OMAP2, 3: DSS2: Get DSS IRQ from platform device
In-Reply-To: <4D4169D1.20001@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	<1295850125-21405-19-git-send-email-sumit.semwal@ti.com>
	<4D4169D1.20001@ti.com>
Message-ID: <20110127125955.GC26418@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 06:19:21PM +0530, Raghuveer Murthy wrote:
>> +	r = request_irq(dss_irq,
>> +		cpu_is_omap24xx()
>> +		? dss_irq_handler_omap2
>> +		: dss_irq_handler_omap3,
>
> it should be
>
> 		cpu_is_omap24xx()
> 		? dss_irq_handler_omap3
> 		: dss_irq_handler_omap2,
>
> I am seeing a crash on Panda, which gets rectified with this
> change. The root cause is access to DSS_IRQSTATUS register in the
> dss_irq_handler_omap3 handler, which is not valid for OMAP4.

That really doesn't look right.  Let me translate the code you've just
written:

	if (cpu_is_omap24xx())
		handler = dss_irq_handler_omap3;
	else
		handler = dss_irq_handler_omap2;

Which means: if we have an OMAP24xx device, use the OMAP3 handler,
otherwise use the OMAP2 handler.  That's got to be wrong.
