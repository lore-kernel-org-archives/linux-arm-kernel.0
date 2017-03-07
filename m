From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 7 Mar 2017 08:22:57 -0600
Subject: [PATCH] irqchip/gicv3-its: Add workaround for QDF2400 ITS erratum
 0065
In-Reply-To: <878toh1pk7.fsf@on-the-bus.cambridge.arm.com>
References: <1488727436-25085-1-git-send-email-shankerd@codeaurora.org>
 <878toh1pk7.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <bd313d48-d608-2204-e621-5d74ff1a9d00@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 03/07/2017 02:03 AM, Marc Zyngier wrote:
> On Sun, Mar 05 2017 at  3:23:56 pm GMT, Shanker Donthineni <shankerd@codeaurora.org> wrote:
>> On Qualcomm Datacenter Technologies QDF2400 SoCs, the ITS hardware
>> implementation uses 16Bytes for Interrupt Translation Entry (ITTE),
> nit: Interrupt Translation Entry is abbreviated as ITE. I know the vITS
> has the ITTE thing all over the place, which I plan to address. No need
> to respin for that.
>
Yeah, I saw your your patch in GICv4 branch which has change, I posted 
v2 with your suggestion.

>> but reports an incorrect value of 8Bytes in GITS_TYPER.ITTE_size.
>>
>> It might cause kernel memory corruption depending on the number
>> of MSI(x) that are configured and the amount of memory that has
>> been allocated for ITTEs in its_create_device().
>>
>> This patch fixes the potential memory corruption by setting the
>> correct ITTE size to 16Bytes.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>>   Documentation/arm64/silicon-errata.txt |  1 +
>>   arch/arm64/Kconfig                     | 10 ++++++++++
>>   drivers/irqchip/irq-gic-v3-its.c       | 16 ++++++++++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>> index a71b809..2f66683 100644
>> --- a/Documentation/arm64/silicon-errata.txt
>> +++ b/Documentation/arm64/silicon-errata.txt
>> @@ -68,3 +68,4 @@ stable kernels.
>>   |                |                 |                 |                             |
>>   | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
>>   | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
>> +| Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 896eba6..6bd51fb 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -509,6 +509,16 @@ config QCOM_FALKOR_ERRATUM_1009
>>   
>>   	  If unsure, say Y.
>>   
>> +config QCOM_QDF2400_ERRATUM_0065
>> +	bool "QDF2400 E0065: Incorrect GITS_TYPER.ITT_Entry_size"
>> +	default y
>> +	help
>> +	  On Qualcomm Datacenter Technologies QDF2400 SoC, ITS hardware reports
>> +	  ITTE size incorrectly. The GITS_TYPER.ITT_Entry_size field should have
>> +	  been indicated as 16Bytes (0xf), not 8Bytes (0x7).
>> +
>> +	  If unsure, say Y.
>> +
>>   endmenu
>>   
>>   
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 2320100..86bd428 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1601,6 +1601,14 @@ static void __maybe_unused its_enable_quirk_cavium_23144(void *data)
>>   	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_23144;
>>   }
>>   
>> +static void __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
>> +{
>> +	struct its_node *its = data;
>> +
>> +	/* On QDF2400, the size of the ITTE is 16Bytes */
>> +	its->ite_size = 16;
>> +}
>> +
>>   static const struct gic_quirk its_quirks[] = {
>>   #ifdef CONFIG_CAVIUM_ERRATUM_22375
>>   	{
>> @@ -1618,6 +1626,14 @@ static void __maybe_unused its_enable_quirk_cavium_23144(void *data)
>>   		.init	= its_enable_quirk_cavium_23144,
>>   	},
>>   #endif
>> +#ifdef CONFIG_QCOM_QDF2400_ERRATUM_0065
>> +	{
>> +		.desc	= "ITS: QDF2400 erratum 0065",
>> +		.iidr	= 0x00001070, /* QDF2400 ITS rev 1.x */
>> +		.mask	= 0xffffffff,
>> +		.init	= its_enable_quirk_qdf2400_e0065,
>> +	},
>> +#endif
>>   	{
>>   	}
>>   };
> OK, that's pretty bad. Should this be CC stable?

Yes, please do CC stable if there is no merge conflicts.

> Thanks,
>
> 	M.

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
