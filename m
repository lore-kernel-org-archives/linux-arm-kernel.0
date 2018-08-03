From: sean.wang@mediatek.com (Sean Wang)
Date: Sat, 4 Aug 2018 02:00:14 +0800
Subject: [PATCH v7 2/3] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
In-Reply-To: <D2336CD2-B69B-4B5B-8125-F0CAD29E3243@holtmann.org>
References: <cover.1533056925.git.sean.wang@mediatek.com>
 <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
 <1707FFA1-A294-4A95-A3BF-0910CE455232@holtmann.org>
 <1533192799.3472.122.camel@mtkswgap22>
 <FF45A90A-F9F1-47CB-AB1F-1E92BF587FBE@holtmann.org>
 <1533199720.3472.136.camel@mtkswgap22>
 <9526E5D9-50BA-4D57-80F5-083DB7D28AFE@holtmann.org>
 <1533205495.3472.144.camel@mtkswgap22>
 <A6D48D49-52CE-405D-8C5D-C4D54CE67221@holtmann.org>
 <1533303749.3472.160.camel@mtkswgap22>
 <D2336CD2-B69B-4B5B-8125-F0CAD29E3243@holtmann.org>
Message-ID: <1533319214.3472.187.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-08-03 at 19:19 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>>>>>>> +
> >>>>>>>>> +static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
> >>>>>>>>> +			    const void *param)
> >>>>>>>>> +{
> >>>>>>>>> +	struct mtk_hci_wmt_cmd wc;
> >>>>>>>>> +	struct mtk_wmt_hdr *hdr;
> >>>>>>>>> +	struct sk_buff *skb;
> >>>>>>>>> +	u32 hlen;
> >>>>>>>>> +
> >>>>>>>>> +	hlen = sizeof(*hdr) + plen;
> >>>>>>>>> +	if (hlen > 255)
> >>>>>>>>> +		return -EINVAL;
> >>>>>>>>> +
> >>>>>>>>> +	hdr = (struct mtk_wmt_hdr *)&wc;
> >>>>>>>>> +	hdr->dir = 1;
> >>>>>>>>> +	hdr->op = op;
> >>>>>>>>> +	hdr->dlen = cpu_to_le16(plen + 1);
> >>>>>>>>> +	hdr->flag = flag;
> >>>>>>>>> +	memcpy(wc.data, param, plen);
> >>>>>>>>> +
> >>>>>>>>> +	atomic_inc(&hdev->cmd_cnt);
> >>>>>>>> 
> >>>>>>>> Why are you doing this one. It will need a comment here if really needed. However I doubt that this is needed. You are only using it from hdev->setup and hdev->shutdown callbacks.
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> An increment on cmd_cnt is really needed because hci_cmd_work would check whether cmd_cnt is positive and then has a decrement on cmd_cnt before a packet is being sent out.
> >>>>>>> 
> >>>>>>> okay will add a comment.
> >>>>>> 
> >>>>>> but you are in ->setup callback this time. So if you need this, then all the other ->setup routines would actually fail as well. Either this is leftover from when you did things in ->probe or ->open or this is some thing we might better fix properly in the core instead of papering over it. Can you recheck if this is really needed.
> >>>>>> 
> >>>>> 
> >>>>> I added a counter print and the counter increments as below
> >>>>> 
> >>>>> 	/* atomic_inc(&hdev->cmd_cnt); */
> >>>>>      pr_info("cmd_cnt = %d\n" , atomic_read(&hdev->cmd_cnt));
> >>>>> 
> >>>>>      skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> >>>>>                              HCI_INIT_TIMEOUT);
> >>>>> 
> >>>>> and the log show up that 
> >>>>> 
> >>>>> 
> >>>>> [  334.049156] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  334.054840] cmd_cnt = 0
> >>>>> [  336.065076] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  336.070795] cmd_cnt = 0
> >>>>> [  338.080997] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  338.086683] cmd_cnt = 0
> >>>>> [  340.096907] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  340.102609] cmd_cnt = 0
> >>>>> [  342.112824] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  342.118520] cmd_cnt = 0
> >>>>> [  344.128747] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  344.134454] cmd_cnt = 0
> >>>>> [  346.144667] Bluetooth: hci0: command 0xfc6f tx timeout
> >>>>> [  346.150372] cmd_cnt = 0
> >>>>> 
> >>>>> 
> >>>>> The packet is dropped by hci_cmd_work at [1], so I also wondered why the
> >>>>> other vendor driver works, it seems the counter needs to be incremented
> >>>>> before every skb is being queued to cmd_q.
> >>>>> 
> >>>>> 4257 static void hci_cmd_work(struct work_struct *work)
> >>>>> 4258 {
> >>>>> 4259         struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
> >>>>> 4260         struct sk_buff *skb;
> >>>>> 4261
> >>>>> 4262         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> >>>>> 4263                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
> >>>>> 4264
> >>>>> 4265         /* Send queued commands */
> >>>>> 
> >>>>> [1]
> >>>>> 4266         if (atomic_read(&hdev->cmd_cnt)) { /* dropped when cmd_cnt is zero */
> >>>>> 4267                 skb = skb_dequeue(&hdev->cmd_q);
> >>>>> 4268                 if (!skb)
> >>>>> 4269                         return;
> >>>>> 4270
> >>>>> 4271                 kfree_skb(hdev->sent_cmd);
> >>>>> 4272
> >>>>> 4273                 hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
> >>>>> 4274                 if (hdev->sent_cmd) {
> >>>>> 4275                         atomic_dec(&hdev->cmd_cnt);  /* cmd_cnt-- */
> >>>>> 4276                         hci_send_frame(hdev, skb);
> >>>> 
> >>>> actually the command also needs to better go via the raw_q anyway since it doesn?t come back with the cmd status or cmd complete. You have it waiting for a vendor event. Maybe with is something we need to consider with __hci_cmd_sync_ev anyway.
> >>>> 
> >>>> Johan would know best since he wrote that code. Anyway, we should fix that in the core and not have you hack around it.
> >>>> 
> >>> 
> >>> yes, my case is that received event is neither cmd status nor cmd complete. It is completely a vendor event.
> >>> 
> >>> if it wants to be solved by the core layer, do you permit that I remove the hack and then send it in the next version?
> >> 
> >> we need to have a __hci_raw_sync_ev that uses the hdev->raw_q and waits for the specified event to come back. I never realized that you are missing the cmd status or cmd complete. So this is similar to the original CSR vendor commands which had the same behavior.
> >> 
> >> I have the feeling that you hdev->cmd_cnt increment is just hiding the problem here. If you really think that it is not chains any side effects we can merge the driver with a big warning and fix this up. However the clean way would be for you to create a patch that introduces __hci_raw_sync_ev as describe above.
> > 
> > What do you think of this? If I add extra atomic_set 1 on cmd_cnt after driver really got a vendor event back instead of blinding to increment for every packet sent.
> > 
> > the behavior is the same to receive a cmd status or complete. it should not have side effects.
> > 
> > 96         skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> > 97                                 HCI_INIT_TIMEOUT);
> > 98
> > 99         if (IS_ERR(skb)) {
> > 100                 int err = PTR_ERR(skb);
> > 101
> > 102                 bt_dev_err(hdev, "Failed to send wmt cmd (%d)", err);
> > 103                 return err;
> > 104         }
> > 105
> > 106         if (!test_bit(HCI_RESET, &hdev->flags)) <<<<<<
> > 107                 atomic_set(&hdev->cmd_cnt, 1);  <<<<<<
> > 108
> > 109         kfree_skb(skb);
> 
> this is even more hackish since the __hci_cmd_sync_ev command is really meant to get a cmd status first before waiting for that event.
> 

Understood.

I've stopped the hack in v8. could we merge v8 first ? and then I will a fix up with __hci_raw_sync_ev that uses the hdev->raw_q instead of __hci_cmd_sync_ev in TODO.

> Are all Mediatek vendor commands this way? Or just the ones for loading the firmware? So only the WMT ones?
> 

Only the WMT ones, WMT commands/events are usually used in system controlling, for example, global function on/off, firmware download, reset and so on. most only appear on device initialization

> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
