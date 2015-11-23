From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Mon, 23 Nov 2015 18:05:27 +0200
Subject: [PATCH v3 2/6] PCI: designware: add memory barrier after enabling
 region
In-Reply-To: <20151123112744.GL8644@n2100.arm.linux.org.uk>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <d38a9c1a87c4e40ad6d17fcbe0fd41b33d7d2912.1448270813.git.stanimir.varbanov@linaro.org>
 <20151123112744.GL8644@n2100.arm.linux.org.uk>
Message-ID: <56533947.4040206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 01:27 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2015 at 11:28:59AM +0200, Stanimir Varbanov wrote:
>> Add 'write memory' barrier after enable region in PCIE_ATU_CR2
>> register. The barrier is needed to ensure that the region enable
>> request has been reached it's destination at time when we
>> read/write to PCI configuration space.
>>
>> Without this barrier PCI device enumeration during kernel boot
>> is not reliable, and reading configuration space for particular
>> PCI device on the bus returns zero aka no device.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/pci/host/pcie-designware.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index 02a7452bdf23..e15a2ae1583f 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>>  	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
>>  	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
>>  	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>> +	/*
>> +	 * ensure that the ATU enable has been happaned before accessing
>> +	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
>> +	 */
>> +	smp_wmb();
> 
> So, why is this a SMP barrier?
> 

I wrongly assumed that smp_wmb will come down to wmb(), I have no excuse.

But despite my ignorant, as I noted in cover letter I want this patch to
be treated as an RFC (maybe I had to add it in the subject).

Do we really need a memory barrier after enabling ATU in PCI_ATU_CR2
register and before first access to pci configuration space using
read[lwb] (see dw_pcie_rd_other_conf)? Or I have made totally wrong
assumption.

-- 
regards,
Stan
