From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 14 Jul 2016 17:30:56 +0800
Subject: [PATCH 1/2] Bluetooth: Add LED triggers for HCI frames tx and rx
In-Reply-To: <D2545F6D-7100-4B59-A19D-7CF878902BAA@holtmann.org>
References: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
 <D2545F6D-7100-4B59-A19D-7CF878902BAA@holtmann.org>
Message-ID: <CAFGCpxwuOH83hdPc-c0DV5A_cKMp-0rjxg+3tMwOPTukHGd6vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 July 2016 at 16:07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Guodong,
>
>> Two LED triggers are defined: tx_led and rx_led. Upon frames
>> available in HCI core layer, for tx or for rx, the combined LED
>> can blink.
>>
>> Verified on HiKey, 96boards. It uses hi6220 SoC and TI WL1835 combo
>> chip.
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> ---
>> include/net/bluetooth/hci_core.h |  1 +
>> net/bluetooth/hci_core.c         |  3 +++
>> net/bluetooth/leds.c             | 15 +++++++++++++++
>> net/bluetooth/leds.h             |  2 ++
>> 4 files changed, 21 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index dc71473..37b8dd9 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -398,6 +398,7 @@ struct hci_dev {
>>       bdaddr_t                rpa;
>>
>>       struct led_trigger      *power_led;
>> +     struct led_trigger      *tx_led, *rx_led;
>>
>>       int (*open)(struct hci_dev *hdev);
>>       int (*close)(struct hci_dev *hdev);
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 45a9fc6..c6e1210 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3248,6 +3248,7 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>>       skb_queue_tail(&hdev->rx_q, skb);
>>       queue_work(hdev->workqueue, &hdev->rx_work);
>>
>> +     hci_leds_blink_oneshot(hdev->rx_led);
>>       return 0;
>> }
>> EXPORT_SYMBOL(hci_recv_frame);
>> @@ -3325,6 +3326,8 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>>               BT_ERR("%s sending frame failed (%d)", hdev->name, err);
>>               kfree_skb(skb);
>>       }
>> +
>> +     hci_leds_blink_oneshot(hdev->tx_led);
>> }
>
> so I am not convinced that this is the right way of doing TX/RX activity leds. This would have them purely based on HCI traffic and this would include control frames.
>

Hi, Marcel

+       if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT ||
+           hci_skb_pkt_type(skb) == HCI_SCODATA_PKT)
+               hci_leds_blink_oneshot(hdev->rx_led);
+

By adding pkt_type checks, we can limit LED blinks only at ACL/SCO
DATA_PKT. Similar checks can be added for tx_led too.

Does this look good to you? If you agree, I can send v2 to include this change.

> I think that we want activity leds for actual radio activity. Meaning that when we have an active connection and ACL packets are exchanged or when we are scanning.
>

Radio is controlled in Bluetooth module side, not Host. So I'm afraid
actual radio activity cannot be captured in its exact form in Host
side. The purpose of this patch is not for radio, it is for
incoming/outgoing data. For example, it can give user a blinking
indicator on RX frames after a Bluetooth mouse is connected. Another
example, it can blink at bluetooth streamed audio (TX).

Would that make sense?

-Guodong

>
> Regards
>
> Marcel
>
