From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 13 Jul 2016 09:07:58 +0100
Subject: [PATCH 1/2] Bluetooth: Add LED triggers for HCI frames tx and rx
In-Reply-To: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
References: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <D2545F6D-7100-4B59-A19D-7CF878902BAA@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

> Two LED triggers are defined: tx_led and rx_led. Upon frames
> available in HCI core layer, for tx or for rx, the combined LED
> can blink.
> 
> Verified on HiKey, 96boards. It uses hi6220 SoC and TI WL1835 combo
> chip.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         |  3 +++
> net/bluetooth/leds.c             | 15 +++++++++++++++
> net/bluetooth/leds.h             |  2 ++
> 4 files changed, 21 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index dc71473..37b8dd9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -398,6 +398,7 @@ struct hci_dev {
> 	bdaddr_t		rpa;
> 
> 	struct led_trigger	*power_led;
> +	struct led_trigger	*tx_led, *rx_led;
> 
> 	int (*open)(struct hci_dev *hdev);
> 	int (*close)(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 45a9fc6..c6e1210 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3248,6 +3248,7 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	skb_queue_tail(&hdev->rx_q, skb);
> 	queue_work(hdev->workqueue, &hdev->rx_work);
> 
> +	hci_leds_blink_oneshot(hdev->rx_led);
> 	return 0;
> }
> EXPORT_SYMBOL(hci_recv_frame);
> @@ -3325,6 +3326,8 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 		BT_ERR("%s sending frame failed (%d)", hdev->name, err);
> 		kfree_skb(skb);
> 	}
> +
> +	hci_leds_blink_oneshot(hdev->tx_led);
> }

so I am not convinced that this is the right way of doing TX/RX activity leds. This would have them purely based on HCI traffic and this would include control frames. I think that we want activity leds for actual radio activity. Meaning that when we have an active connection and ACL packets are exchanged or when we are scanning.

Regards

Marcel
