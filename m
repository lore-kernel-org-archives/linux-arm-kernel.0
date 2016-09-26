From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 26 Sep 2016 08:50:48 +0200
Subject: [PATCH v3 1/3] ipmi: add an Aspeed BT IPMI BMC driver
In-Reply-To: <20160923183421.GA14864@rob-hp-laptop>
References: <1474354900-5618-1-git-send-email-clg@kaod.org>
 <1474354900-5618-2-git-send-email-clg@kaod.org>
 <20160923183421.GA14864@rob-hp-laptop>
Message-ID: <c3f084ab-9f77-86ab-7875-cbfe654ea18e@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 09/23/2016 08:34 PM, Rob Herring wrote:
> On Tue, Sep 20, 2016 at 09:01:38AM +0200, C?dric Le Goater wrote:
>> From: Alistair Popple <alistair@popple.id.au>
>>
>> This patch adds a simple device driver to expose the iBT interface on
>> Aspeed SOCs (AST2400 and AST2500) as a character device. Such SOCs are
>> commonly used as BMCs (BaseBoard Management Controllers) and this
>> driver implements the BMC side of the BT interface.
>>
>> The BT (Block Transfer) interface is used to perform in-band IPMI
>> communication between a host and its BMC. Entire messages are buffered
>> before sending a notification to the other end, host or BMC, that
>> there is data to be read. Usually, the host emits requests and the BMC
>> responses but the specification provides a mean for the BMC to send
>> SMS Attention (BMC-to-Host attention or System Management Software
>> attention) messages.
>>
>> For this purpose, the driver introduces a specific ioctl on the
>> device: 'BT_BMC_IOCTL_SMS_ATN' that can be used by the system running
>> on the BMC to signal the host of such an event.
>>
>> The device name defaults to '/dev/ipmi-bt-host'
>>
>> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> [clg: - checkpatch fixes
>>       - added a devicetree binding documentation
>>       - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>         the BMC side of the IPMI BT interface
>>       - renamed the device to 'ipmi-bt-host'
>>       - introduced a temporary buffer to copy_{to,from}_user
>>       - used platform_get_irq()
>>       - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>         device
>>       - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>> ]
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> [clg: - checkpatch --strict fixes
>>       - removed the use of devm_iounmap, devm_kfree in cleanup paths
>>       - introduced an atomic-t to limit opens to 1
>>       - introduced a mutex to protect write/read operations]
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>>
>> ---
>>
>>  Changes since v2:
>>
>>  - fixed checkpatch --strict issues
>>  - cleanup'ed includes
>>  - limit to one opener
>>  - protect write/read operations with a mutex.
>>  - removed the use of devm_iounmap, devm_kfree in cleanup paths
>>
>>  Changes since v1:
>>
>>  - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>    the BMC side of the IPMI BT interface
>>  - renamed the device to 'ipmi-bt-host'
>>  - introduced a temporary buffer to copy_{to,from}_user
>>  - used platform_get_irq()
>>  - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>    device
>>  - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>>
>>  .../bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt   |  23 +
> 
> While similar, this is not the kernel directory structure. Just make 
> this bindings/ipmi/
> 
> With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>

OK. So I suppose we should be moving all IPMI documentation under
the same directory.


Corey,

If the move is okay for you, I can send the patch below.

Thanks,

C.


>From ca25f89b25209c260480cda5e5532d6bbe83ed43 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 26 Sep 2016 08:45:15 +0200
Subject: [PATCH] dt-bindings: ipmi: move all documentation under
 bindings/ipmi/
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 .../devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt         | 0
 Documentation/devicetree/bindings/{ipmi.txt => ipmi/ipmi-smic.txt}        | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{char => }/ipmi/aspeed,ast2400-bt-bmc.txt (100%)
 rename Documentation/devicetree/bindings/{ipmi.txt => ipmi/ipmi-smic.txt} (100%)

diff --git a/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
rename to Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
diff --git a/Documentation/devicetree/bindings/ipmi.txt b/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
similarity index 100%
rename from Documentation/devicetree/bindings/ipmi.txt
rename to Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
-- 
2.7.4
