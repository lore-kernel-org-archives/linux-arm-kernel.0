From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 13 Dec 2016 09:12:40 +0530
Subject: [PATCH v2 2/2] dt-bindings: Add DT bindings info for FlexRM ring
 manager
In-Reply-To: <20161209180132.lnpvwybnij5uykuq@rob-hp-laptop>
References: <1480653536-5551-1-git-send-email-anup.patel@broadcom.com>
 <1480653536-5551-3-git-send-email-anup.patel@broadcom.com>
 <20161209180132.lnpvwybnij5uykuq@rob-hp-laptop>
Message-ID: <CAALAos-B0a3VhiuNWyWVeuitmUZh=2Y=ubFNe+_5eo29sBw6Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2016 at 11:31 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 02, 2016 at 10:08:56AM +0530, Anup Patel wrote:
>> This patch adds device tree bindings document for the FlexRM
>> ring manager found on Broadcom iProc SoCs.
>>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> ---
>>  .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    | 60 ++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
>> new file mode 100644
>> index 0000000..e81f116
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
>> @@ -0,0 +1,60 @@
>
> [...]
>
>> +Example:
>> +--------
>> +crypto_mbox: mbox at 67000000 {
>> +     compatible = "brcm,flexrm-mbox";
>> +     reg = <0x67000000 0x200000>;
>> +     msi-parent = <&gic_its 0x7f00>;
>> +     #mbox-cells = <3>;
>> +};
>> +
>> +crypto_client {
>> +     ...
>> +     mboxes = <&crypto_mbox 0 0x1 0xffff>,
>> +              <&crypto_mbox 1 0x1 0xffff>,
>> +              <&crypto_mbox 16 0x1 0xffff>,
>> +              <&crypto_mbox 17 0x1 0xffff>,
>> +              <&crypto_mbox 30 0x1 0xffff>,
>> +              <&crypto_mbox 31 0x1 0xffff>;
>
> The FlexRM part looks fine. I still don't understand what this node is.
> Is this a h/w block or just a list of mailboxes? What determines the
> mailbox channel numbers here? I need to see what the complete node looks
> like.

The crypto_client is an example mailbox client for FlexRM mailbox.

The example shows that we have FlexRM ring manager providing
ring based programming interface to Crypto offload engine. The
Crypto offload engine driver is a mailbox client driver.

FlexRM mailbox requires 3 cells to specify each mailbox channel in
"mboxes" attribute of mailbox client DT node. The 1st cell is
mailbox channel number (or FlexRM ring number). Rest of the
cells are explained in bindings document.

Complete node would look something like below:

crypto_client {
     compatible = "brcm,iproc-spu2";
     mboxes = <&crypto_mbox 0 0x1 0xffff>,
                     <&crypto_mbox 1 0x1 0xffff>,
                     <&crypto_mbox 16 0x1 0xffff>,
                     <&crypto_mbox 17 0x1 0xffff>,
                     <&crypto_mbox 30 0x1 0xffff>,
                     <&crypto_mbox 31 0x1 0xffff>;
};

The Crypto driver was recently submitted by Rob Rice.
Refer https://www.spinics.net/lists/kernel/msg2395306.html

Similar to Crypto offload engine, we also have RAID offload
engine. The RAID offload engine driver is also implemented
as mailbox client driver.

Regards,
Anup
