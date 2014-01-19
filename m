From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 19:48:29 +0100
Subject: [RFC v3 01/13] libahci: Allow drivers to override start_engine
In-Reply-To: <20140119044643.GH3640@htj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-2-git-send-email-hdegoede@redhat.com>
 <20140119044643.GH3640@htj.dyndns.org>
Message-ID: <52DC1DFD.4060508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 05:46 AM, Tejun Heo wrote:
> Hello, Hans.
>
> On Sun, Jan 19, 2014 at 12:48:43AM +0100, Hans de Goede wrote:
>>   void ahci_start_engine(struct ata_port *ap)
>>   {
>>   	void __iomem *port_mmio = ahci_port_base(ap);
>> +	struct ahci_host_priv *hpriv = ap->host->private_data;
>>   	u32 tmp;
>>
>> +	if (hpriv->start_engine) {
>> +		hpriv->start_engine(ap);
>> +		return;
>> +	}
>> +
>
> I'd much prefer if the driver always calls hpriv->start_engine() which
> is initialized to the default callback during common init and then
> overridden if necessary.

This is a bit trouble some because ahci_start_engine is also exported,
so the patch would also need to fix all callers (and probably un-export
it). I can do this in the next revision in the patch-set if you want me
to, just explaining why I choose to do this the way I did.

Regards,

Hans
