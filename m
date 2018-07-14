From: marcel@holtmann.org (Marcel Holtmann)
Date: Sat, 14 Jul 2018 18:34:29 +0200
Subject: [PATCH v5 4/7] Bluetooth: Add new quirk for non-persistent setup
 settings
In-Reply-To: <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
Message-ID: <2825B722-E75C-4A3C-8110-879205E46C0E@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

> Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> runs setup() after every open() and not just after the first open().
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> net/bluetooth/hci_core.c    | 3 ++-
> 2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 73e48be..d3ec5b2a8 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -183,6 +183,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_NON_PERSISTENT_DIAG,
> +
> +	/* When this quirk is set, setup() would be run after every
> +	 * open() and not just after the first open().
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 *
> +	 */
> +	HCI_QUIRK_NON_PERSISTENT_SETUP,
> };
> 
> /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f5c21004..0111280 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1396,7 +1396,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> 	atomic_set(&hdev->cmd_cnt, 1);
> 	set_bit(HCI_INIT, &hdev->flags);
> 
> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);

can you include the extract of btmon on how the HCI_DEV_SETUP event shows up in the traces? I remember that I asked about something like that.

Regards

Marcel
