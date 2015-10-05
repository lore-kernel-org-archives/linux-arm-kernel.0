From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 5 Oct 2015 04:03:58 +0200
Subject: [PATCH v4 17/26] ARM: pxa: magician: Fix wrongly enabled USB host
 ports
In-Reply-To: <1443876327.4186.32.camel@gmail.com>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B33B.6070301@tul.cz>
 <1443876327.4186.32.camel@gmail.com>
Message-ID: <5611DA8E.5040703@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 3.10.2015 v 14:45 Philipp Zabel napsal(a):
> Am Montag, den 28.09.2015, 23:38 +0200 schrieb Petr Cvek:
>> USB host ports on the HTC Magician are wrongly enabled. Port 1 is for
>> bluetooth and port 2 is for OTG (mux in the charger connector).
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>> ---
>>  arch/arm/mach-pxa/magician.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach
>> -pxa/magician.c
>> index 8e8b122..af8133a 100644
>> --- a/arch/arm/mach-pxa/magician.c
>> +++ b/arch/arm/mach-pxa/magician.c
>> @@ -780,8 +780,10 @@ static struct pxamci_platform_data
>> magician_mci_info = {
>>  
>>  static struct pxaohci_platform_data magician_ohci_info = {
>>  	.port_mode	= PMM_PERPORT_MODE,
>> -	.flags		= ENABLE_PORT1 | ENABLE_PORT3 |
>> POWER_CONTROL_LOW,
>> +	/* port1: CSR Bluetooth, port2: OTG with UDC */
>> +	.flags		= ENABLE_PORT1 | ENABLE_PORT2 |
>> POWER_CONTROL_LOW,
>>  	.power_budget	= 0,
>> +	.power_on_delay = 100,
>>  };
> 
> I have only ever tested the CSR bluetooth chip, so this could be
> correct, or again something that is different between the magician
> variants. I don't know.

If your magician has USB client directly from PXA SoC (not external PHY),
then only host port 2 can be muxed with client.

Intel? PXA27x Processor Family, Developer?s Manual

	"12.5 USB On-The-Go Operation"
	"Figure 12-15. USB OTG Configurations"

I think there was no implementation in the Windows Mobile, but I was able to
switch this mux and use a wifi usb dongle on the same connector as USB client.

> 
> regards
> Philipp
> 

Petr
