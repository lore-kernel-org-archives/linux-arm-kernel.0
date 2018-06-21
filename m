From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Jun 2018 10:37:25 +0100
Subject: [PATCH 3/6] coresight: Introduce support for Coresight Address
 Translation Unit
In-Reply-To: <20180620214157.GA20697@xps15>
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
 <1529319379-17895-4-git-send-email-suzuki.poulose@arm.com>
 <20180620214157.GA20697@xps15>
Message-ID: <76e0bc22-468c-6215-de54-3e4ead42e17c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On 20/06/1822:41, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Mon, Jun 18, 2018 at 11:56:16AM +0100, Suzuki K Poulose wrote:
>> Add the initial support for Coresight Address Translation Unit, which
>> augments the TMC in Coresight SoC-600 by providing an improved Scatter
>> Gather mechanism. CATU is always connected to a single TMC-ETR and
>> converts the AXI address with a translated address (from a given SG
>> table with specific format). The CATU should be programmed in pass
>> through mode and enabled if the ETR doesn't translation by CATU.
> 
> To me this sentence look broken.
> 

Yes, it is broken. It should have been :

"The CATU should be programmed in pass through mode and enabled
even if the ETR doesn't use the translation by CATU."


>> +static int catu_disable_hw(struct catu_drvdata *drvdata)
>> +{
>> +	int rc = 0;
>> +
>> +	if (catu_wait_for_ready(drvdata)) {
>> +		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
>> +		rc = -EAGAIN;
>> +	}
>> +
>> +	catu_write_control(drvdata, 0);
> 
> Is waiting for the ready bit before switching the component off comes from
> experimentation with the HW (i.e FPGA)?  From what the reference manual
> indicate, CONTROL.ENABLE should be set to 0 first, and then wait for
> STATUS.READY.

You're right. It should be in the reverse order. I will fix it in the next version.

Thanks
Suzuki
