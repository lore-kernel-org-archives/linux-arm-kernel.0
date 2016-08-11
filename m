From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 11 Aug 2016 10:35:53 +0200
Subject: [RFC PATCH v3 0/8] scpi: Add SCPI registry to handle legacy
 protocol
In-Reply-To: <d7f260f8-5e1a-a16a-fed9-2f6d8aa8f28f@rock-chips.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
 <d7f260f8-5e1a-a16a-fed9-2f6d8aa8f28f@rock-chips.com>
Message-ID: <c5b3fcb1-368c-5be6-fe71-1f2d444b83e0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On 08/10/2016 12:19 PM, Frank Wang wrote:
> Hi Neil,
> 
> On 2016/8/9 18:29, Neil Armstrong wrote:

[...]

>>
>> Changes since RFC v2 at https://lkml.org/lkml/2016/6/21/324 :
>>   - Moved MHU to a separate patchset posted at
>> http://lkml.kernel.org/r/1470732737-18391-1-git-send-email-narmstrong at baylib
>> re.com
>>   - Added a vendor send_message callback into scpi_ops to implement vendor
>> commands
>>   - Implement EXT commands on arm scpi as vendor send_command
>>   - Added Rockchip variant mailbox handling
> 
> Two questions,
> 
> 1. For legacy_scpi, I saw you have implemented .vendor_send_message api, however, it seems that does not distinguish standard and extended command, so it may be misleading if the vendor send out a non-standard command from their own driver module.

Actually, the vendor_send_message is for non-standard command, and since it's vendor code is should be specific to the platform and won't have any effect on other platforms.
DDR and other rockchip specific command shoudl go through this API.
The legacy_scpi code does not distinguish standard and extended command since nothing was made into the protocol for this.

> 
> 2. For arm_scpi, it have already distinguished standard and extended command, but unfortunately, there was no rockchip_scpi_xfer structure something like in legacy_scpi driver, so if some vendor (just like Rockchip :-)) wanna switch the driver from legacy_scpi to arm_scpi, maybe this is a bit problem, how do you think?

Yes, it could be added the same way it was added to legacy_scpi, Sudeep made the assumption it would work with any mailbox controller, but since the mailbox framework does not make any assumption about the data type between the controller and the client, such adaptation is necessary.

Neil
> 
> BR.
> Frank
> 
>> Initial RFC discution tread can be found at
>> https://lkml.org/lkml/2016/5/26/111
>>
>> @Sudeep: I know you wished I merged the legacy into the arm_scpi, but can
>> you take a look at the vendor extension and how I implemented the rockchip
>> mailbox handling ?
>>
>> Neil Armstrong (8):
>>    firmware: Add a SCPI registry to handle multiple implementations
>>    firmware: scpi: Switch arm_scpi to use new registry
>>    scpi: Add vendor_send_message to enable access to vendor commands
>>    firmware: arm_scpi: Enable vendor_send_message as ext commands
>>    firmware: Add legacy SCPI protocol driver
>>    dt-bindings: arm: Update arm,scpi bindings with Meson GXBB SCPI
>>    ARM64: dts: meson-gxbb: Add SRAM node
>>    ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes
>>
>>   Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
>>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  45 ++
>>   drivers/firmware/Kconfig                           |  24 +
>>   drivers/firmware/Makefile                          |   2 +
>>   drivers/firmware/arm_scpi.c                        |  40 +-
>>   drivers/firmware/legacy_scpi.c                     | 710
>> +++++++++++++++++++++
>>   drivers/firmware/scpi.c                            |  94 +++
>>   include/linux/scpi_protocol.h                      |  20 +-
>>   8 files changed, 928 insertions(+), 15 deletions(-)
>>   create mode 100644 drivers/firmware/legacy_scpi.c
>>   create mode 100644 drivers/firmware/scpi.c
>>
> 
> 
