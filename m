From: tchalamarla@caviumnetworks.com (Tirumalesh Chalamarla)
Date: Thu, 25 Feb 2016 12:31:53 -0800
Subject: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <alpine.DEB.2.11.1602171710350.19512@nanos>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
 <alpine.DEB.2.11.1602171710350.19512@nanos>
Message-ID: <56CF64B9.4080605@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/17/2016 08:12 AM, Thomas Gleixner wrote:
> On Tue, 16 Feb 2016, tchalamarla at caviumnetworks.com wrote:
>> +#ifdef CONFIG_ARM64
>> +/* Due to ERRATA#22536, ThunderX need to handle
>> + * HOST_IRQ_STAT differently.
>> + * Work around is to make sure all pending IRQs
>> + * are served before leaving handler
>> + */
>> +static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
>> +{
>> +	struct ata_host *host = dev_instance;
>> +	struct ahci_host_priv *hpriv;
>> +	unsigned int rc = 0;
>> +	void __iomem *mmio;
>> +	u32 irq_stat, irq_masked;
>> +	unsigned int handled = 1;
>> +
>> +	VPRINTK("ENTER\n");
>
> Come on. This VPRINK stuff is really pointless. Enable irq tracepoints, they
> already track the enter/exit of interrupt handlers ....
>

sure. waiting for some more comments if any.
> Thanks,
>
> 	tglx
>
>
