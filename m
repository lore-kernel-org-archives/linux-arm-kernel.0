From: frank.wang@rock-chips.com (Frank Wang)
Date: Fri, 24 Jun 2016 10:31:07 +0800
Subject: [RFC PATCH v2 0/9] scpi: Add SCPI registry to handle legacy
 protocol
In-Reply-To: <576BD9FD.2030608@baylibre.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <2a58b7d6-aadc-19fb-dd24-ea6bf51c1857@rock-chips.com>
 <576BD9FD.2030608@baylibre.com>
Message-ID: <908f0424-7af6-0ef8-c30a-7b22a4e8fdfb@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil & Caesar,

On 2016/6/23 20:45, Neil Armstrong wrote:
> On 06/22/2016 04:54 AM, Frank Wang wrote:
>> Hi Neil,
>>
>> On 2016/6/21 18:02, Neil Armstrong wrote:
>>> This patchset aims to support the legacy SCPI firmware implementation that was
>>> delivered as early technology preview for the JUNO platform.
>>>
>>> Finally a stable, maintained and public implementation for the SCPI protocol
>>> has been upstreamed part of the JUNO support and it is the recommended way
>>> of implementing SCP communication on ARMv8 platforms.
>>>
>>> The Amlogic GXBB platform is using this legacy protocol, as the RK3368 & RK3399
>>> platforms. Only the GXBB example is provided here, but it's unclear if other
>>> Amlogic ARMv8 based SoCs uses this legacy procotol.
>>>
>>> In order to support the legacy protocol :
>>>    - Move the scpi_get_ops to a thin registry layer
>>>    - Change the arm_scpi.c to use the registry layer
>>>    - Add a separate config option to build the registry layer
>>>    - Add the legacy SCPI driver based on the new implementation
>>>    - For example, add the Amlogic GXBB MHU and SCPI DT cpufreq & sensors nodes
>> Two comments may be not very associated with this series.
>>
>> First, do you have any plan to implement the APIs for extended set ID of SCPI? If these APIs do not care commands, just focus on a message transmission access, something like a library role, and extended command can define in consumers driver module, I think it can more help for other consumers like Rockchip to send/receive nonstandard command data conveniently. Can it be?
> Yes, Amlogic only have a single extended command, but supporting Rockchips extended API is necessary.
> I'll need to think about a convenient way to extend vendor API in a separate driver with a set or read/write functions, but
> keeping the compatibility with the official SCPI extension API.

Well, sounds great, how soon can you deliver it?

>> Second, As far as I know, some legacy mailbox hardware which like Altera, Rockchip...  need write command and data register sequentially, then it can create a interrupt, however, arm-scpi first use inner scpi_xfer structure to package the message, then data is passed to msg_submit (At mailbox.c), further into the bottom mailbox driver, but the data type is converted void*, so the mailbox driver could not extract the contents of message, if it do cast type, it may become non-general from driver view. Hence, is it possible to add a message header into scpi_xfer which for the bottom mailbox driver or dope out any other methods to solve it?
> Well, the message type should be considered "known" between the mailbox client and controller, but here Amlogic did copy ARM's MHU so we can simply cast the data into a uint32_t and push the
> word in the status register, but the interface was not designed to handle a "message", only a status.
> In your case, you seem to have used the message capability of the mailbox to transmit a proper message containing the command word and return length.

Yeah, you are right, Rockchip mailbox need command word and RX size to 
ensure data integrity in current, however RX size may be replaced from 
other item of xfer data. Plus, as last mail I mentioned that a interrupt 
can only be created via writing command register and data register 
(filled RX size at present) sequentially . So from controller view, 
knowing a proper value of data which it should know is required.

> Therefore, I must think about implementing a per-vendor transmit layer, because a generic way won't work among the different mailbox controllers.
>
> Would it be possible to actually test the next revision of the legacy SCPI implementation on your platform ? I'll try to implement it for rockchip with what I understood, but I'll need your help for the DT declaration side.

Of course, I will be glad to.

@Caesar, would you like to share any other good comments?


BR.
Frank

> Regards,
> Neil
>>> Initial RFC discution tread can be found at https://lkml.org/lkml/2016/5/26/111
>>>
>>> Neil Armstrong (9):
>>>     mailbox: Add Amlogic Meson Message-Handling-Unit
>>>     dt-bindings: mailbox: Add Amlogic Meson MHU Bindings
>>>     ARM64: dts: meson-gxbb: Add Meson MHU Node
>>>     firmware: Add a SCPI registry to handle multiple implementations
>>>     firmware: scpi: Switch arm_scpi to use new registry
>>>     firmware: Add legacy SCPI protocol driver
>>>     dt-bindings: arm: Update arm,scpi bindings with Meson GXBB SCPI
>>>     ARM64: dts: meson-gxbb: Add SRAM node
>>>     ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes
>>>
>>>    Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
>>>    .../devicetree/bindings/mailbox/meson-mhu.txt      |  33 ++
>>>    arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  53 ++
>>>    drivers/firmware/Kconfig                           |  24 +
>>>    drivers/firmware/Makefile                          |   2 +
>>>    drivers/firmware/arm_scpi.c                        |  14 +-
>>>    drivers/firmware/legacy_scpi.c                     | 644 +++++++++++++++++++++
>>>    drivers/firmware/scpi.c                            |  94 +++
>>>    drivers/mailbox/Makefile                           |   2 +
>>>    drivers/mailbox/meson_mhu.c                        | 199 +++++++
>>>    include/linux/scpi_protocol.h                      |  15 +-
>>>    11 files changed, 1075 insertions(+), 13 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
>>>    create mode 100644 drivers/firmware/legacy_scpi.c
>>>    create mode 100644 drivers/firmware/scpi.c
>>>    create mode 100644 drivers/mailbox/meson_mhu.c
>>>
>>
