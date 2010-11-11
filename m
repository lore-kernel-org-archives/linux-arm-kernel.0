From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Thu, 11 Nov 2010 09:17:18 +0200
Subject: [PATCH v5 2/3] OMAP3: DMA: Errata i541: sDMA FIFO draining does
	not finish
In-Reply-To: <alpine.DEB.2.00.1011101628410.28301@utopia.booyaka.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
	<1286261141-1039-3-git-send-email-peter.ujfalusi@nokia.com>
	<4CDAA3AA.7070003@nokia.com>
	<alpine.DEB.2.00.1011101628410.28301@utopia.booyaka.com>
Message-ID: <4CDB987E.2020806@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/10 01:30, ext Paul Walmsley wrote:
> Hello Adrian,
>
> On Wed, 10 Nov 2010, Adrian Hunter wrote:
>
>> On 05/10/10 09:45, Peter Ujfalusi wrote:
>>
>>> +	if (cpu_is_omap34xx()&&   (l&   OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
>>> +		int i = 0;
>>> +		u32 sys_cf;
>>> +
>>> +		/* Configure No-Standby */
>>> +		l = dma_read(OCP_SYSCONFIG);
>>> +		sys_cf = l;
>>> +		l&= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
>>> +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
>>> +		dma_write(l , OCP_SYSCONFIG);
>>
>> Are accesses of OCP_SYSCONFIG synchronised?
>
> Do you mean, with respect to later reads and writes from the SDMA device?
> If so, then yes, later reads and writes to the SDMA are guaranteed to
> complete in order.  But perhaps I am misunderstanding what you mean?

I just meant it looks racy e.g.  two threads call omap_dma_stop() (or
another function that changes OCP_SYSCONFIG) at the same time
