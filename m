From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Fri, 1 Jul 2016 10:17:37 +0200
Subject: [PATCH 1/4] brcmfmac: Add brcm,nvram_file_name dt property
In-Reply-To: <20160701020836.GA1722@rob-hp-laptop>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <20160701020836.GA1722@rob-hp-laptop>
Message-ID: <b18cd232-711a-b617-2f09-09c4bdf2c3c4@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1-7-2016 4:08, Rob Herring wrote:
> On Wed, Jun 29, 2016 at 04:04:31PM +0200, Hans de Goede wrote:
>> Add a brcm,nvram_file_name dt property to allow overruling the default
>> nvram filename for sdio devices. The idea is that we can specify a
>> board specific nvram file, e.g. brcmfmac43362-ap6210.txt for boards
>> with an ap6210 wifi sdio module and ship this in linux-firmware, so
>> that wifi will work out of the box, without requiring users to find
>> and then manually install the right nvram file for their board.
> 
> What about putting its contents directly into DT? It's just text 
> key/value pairs so it would match up well.

It would be an option, but I have no clue how to dig up documentation of
these key,value pairs. The file is typically obtained from a wifi module
vendor which would need to be converted to DT format, ie. prefix with
"brcm," etc. From driver perspective this would mean it need to know
keys. Currently, it just takes the file contents and sends it to the device.

> Also, I have to wonder how all the non-SDIO based cards don't need this 
> file.

PCIe devices have more on-board storage. Also on some router platforms
it gets nvram data from flash memory.

>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  .../devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt          | 2 ++
>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c               | 2 ++
>>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c             | 6 ++++++
>>  include/linux/platform_data/brcmfmac.h                              | 2 ++
>>  4 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>> index 5dbf169..2ba13a6 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>> @@ -11,6 +11,7 @@ Required properties:
>>  Optional properties:
>>   - brcm,drive-strength : drive strength used for SDIO pins on device in mA
>>  	(default = 6).
>> + - brcm,nvram_file_name : name of the nvram file to load
> 
> The need for firmware file names has come up several times though 
> nothing merged to yet. There has been at least some level of agreement 
> to use "firmware-name" here. 

Do you mean with or without vendor prefix? Actually the device needs two
files to initialize. The firmware that is needed to have anything
running on the device and the nvram data that characterizes the device
for that firmware.

Regards,
Arend

>>   - interrupt-parent : the phandle for the interrupt controller to which the
>>  	device interrupts are connected.
>>   - interrupts : specifies attributes for the out-of-band interrupt (host-wake).
>> @@ -34,6 +35,7 @@ mmc3: mmc at 01c12000 {
>>  	brcmf: bcrmf at 1 {
>>  		reg = <1>;
>>  		compatible = "brcm,bcm4329-fmac";
>> +		brcm,nvram_file_name = "brcm/brcmfmac43362-ap6210.txt";
>>  		interrupt-parent = <&pio>;
>>  		interrupts = <10 8>; /* PH10 / EINT10 */
>>  		interrupt-names = "host-wake";
