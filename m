From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 17 Jun 2016 12:43:39 -0500
Subject: [PATCHv3 6/7] EDAC, altera: Add Arria10 Ethernet EDAC support
In-Reply-To: <20160617172928.GK3912@pd.tnic>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-7-git-send-email-tthayer@opensource.altera.com>
 <20160617172928.GK3912@pd.tnic>
Message-ID: <576436CB.6070002@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/17/2016 12:29 PM, Borislav Petkov wrote:
> On Mon, Jun 13, 2016 at 04:19:11PM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add Altera Arria10 Ethernet FIFO memory EDAC support. Update
>> to support a common compatibility string for all ethernet
>> FIFOs in the DT.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2  Remove (void *) cast from altr_edac_device_of_match[]
>>      Addition of panic flag to ethernet private data.
>> v3  Use common compatiblity string.
>>      Simplify socfpga_init_ethernet_ecc().
>> ---
>>   drivers/edac/Kconfig       |    7 +++++++
>>   drivers/edac/altera_edac.c |   38 ++++++++++++++++++++++++++++++++++++--
>>   drivers/edac/altera_edac.h |    3 +++
>>   3 files changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 6ca7474..d0c1dab 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -391,6 +391,13 @@ config EDAC_ALTERA_OCRAM
>>   	  Support for error detection and correction on the
>>   	  Altera On-Chip RAM Memory for Altera SoCs.
>>
>> +config EDAC_ALTERA_ETHERNET
>> +	bool "Altera Ethernet FIFO ECC"
>> +	depends on EDAC_ALTERA=y
>> +	help
>> +	  Support for error detection and correction on the
>> +	  Altera Ethernet FIFO Memory for Altera SoCs.
>> +
>>   config EDAC_SYNOPSYS
>>   	tristate "Synopsys DDR Memory Controller"
>>   	depends on EDAC_MM_EDAC && ARCH_ZYNQ
>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>> index f27bb29..14f99ae 100644
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
>> @@ -1260,6 +1260,34 @@ const struct edac_device_prv_data a10_l2ecc_data = {
>>
>>   #endif	/* CONFIG_EDAC_ALTERA_L2C */
>>
>> +/********************* Ethernet Device Functions ********************/
>> +
>> +#ifdef CONFIG_EDAC_ALTERA_ETHERNET
>> +
>> +const struct edac_device_prv_data a10_enet0rxecc_data = {
>
> This needs to be "static const" and then you don't need to init panic to
> false.
>
> Your other edac_device_prv_data things are not static too, please
> convert them in a separate patch too.
>
OK, I'll make the change. Thanks!
