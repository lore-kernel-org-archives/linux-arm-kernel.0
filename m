From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 17 Jul 2018 00:15:38 +0800
Subject: [SPAM]Re: [PATCH v5 4/7] Bluetooth: Add new quirk for
 non-persistent setup settings
In-Reply-To: <1531757114.8953.12.camel@mtkswgap22>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
 <2825B722-E75C-4A3C-8110-879205E46C0E@holtmann.org>
 <1531638169.3955.5.camel@mtkswgap22>
 <6571C864-B2EC-4806-BC5D-F531792737F6@holtmann.org>
 <1531757114.8953.12.camel@mtkswgap22>
Message-ID: <1531757738.8953.17.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-17 at 00:05 +0800, Sean Wang wrote:
> On Mon, 2018-07-16 at 14:56 +0200, Marcel Holtmann wrote:
> > Hi Sean,
> > 
> > >>> Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> > >>> runs setup() after every open() and not just after the first open().
> > >>> 
> > >>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > >>> ---
> > >>> include/net/bluetooth/hci.h | 9 +++++++++
> > >>> net/bluetooth/hci_core.c    | 3 ++-
> > >>> 2 files changed, 11 insertions(+), 1 deletion(-)
> > >>> 
> > >>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > >>> index 73e48be..d3ec5b2a8 100644
> > >>> --- a/include/net/bluetooth/hci.h
> > >>> +++ b/include/net/bluetooth/hci.h
> > >>> @@ -183,6 +183,15 @@ enum {
> > >>> 	 * during the hdev->setup vendor callback.
> > >>> 	 */
> > >>> 	HCI_QUIRK_NON_PERSISTENT_DIAG,
> > >>> +
> > >>> +	/* When this quirk is set, setup() would be run after every
> > >>> +	 * open() and not just after the first open().
> > >>> +	 *
> > >>> +	 * This quirk can be set before hci_register_dev is called or
> > >>> +	 * during the hdev->setup vendor callback.
> > >>> +	 *
> > >>> +	 */
> > >>> +	HCI_QUIRK_NON_PERSISTENT_SETUP,
> > >>> };
> > >>> 
> > >>> /* HCI device flags */
> > >>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > >>> index f5c21004..0111280 100644
> > >>> --- a/net/bluetooth/hci_core.c
> > >>> +++ b/net/bluetooth/hci_core.c
> > >>> @@ -1396,7 +1396,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> > >>> 	atomic_set(&hdev->cmd_cnt, 1);
> > >>> 	set_bit(HCI_INIT, &hdev->flags);
> > >>> 
> > >>> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> > >>> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> > >>> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> > >>> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> > >> 
> > >> can you include the extract of btmon on how the HCI_DEV_SETUP event shows up in the traces? I remember that I asked about something like that.
> > >> 
> > >> Regards
> > >> 
> > >> Marcel
> > >> 
> > > 
> > > No, I cannot see any event about HCI_DEV_SETUP in btmon trace, the trace I posted as below is doing some rounds of power off and then on
> > 
> > it will result in this:
> > 
> >         case HCI_DEV_SETUP:
> >                 if (hdev->manufacturer == 0xffff)
> >                         return NULL;
> >                                                                                  
> >         case HCI_DEV_UP:
> >                 skb = bt_skb_alloc(HCI_MON_INDEX_INFO_SIZE, GFP_ATOMIC);
> > 
> > So we will see extra index info events, but I assume that is just fine this we also see them on DEV_UP. They also do not hurt as long as not magically the manufacturer information changes.
> > 
> > I do wonder though if this quirk is set, then hdev->manufacturer needs to be reset and allow hdev->setup() to reset it. This goes with a log of other information as well. Maybe just a look if there are no races here.
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> I didn't set a value to hdev->manufacture.
> 
> Should I set it in hdev->setup() ? MediaTek is 0x46 according to [1].

sorry, something needs be corrected.

what I means is that should I set hdev->manufacture as 0x46 at probe ? 

> [1]
> https://www.bluetooth.com/specifications/assigned-numbers/company-identifiers
> 
> 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
