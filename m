From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 15 Apr 2017 21:48:54 +0200
Subject: [PATCH v3 3/4] bluetooth: hci_uart: add LL protocol serdev
 driver support
In-Reply-To: <20170413150353.7389-4-robh@kernel.org>
References: <20170413150353.7389-1-robh@kernel.org>
 <20170413150353.7389-4-robh@kernel.org>
Message-ID: <20170415194854.byado7bxupbdhivp@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 13, 2017 at 10:03:52AM -0500, Rob Herring wrote:
> +static int read_local_version(struct hci_dev *hdev)
> +{
> +	int err = 0;
> +	unsigned short version = 0;
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *ver;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading TI version information failed (%ld)",
> +			   PTR_ERR(skb));
> +		err = PTR_ERR(skb);
> +		goto out;

If __hci_cmd_sync() fails the code tries to kfree_skb() an error pointer
resulting in NULL pointer dereference warning + strack trace. This
can just return err instead.

> +	}
> +	if (skb->len != sizeof(*ver)) {
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	ver = (struct hci_rp_read_local_version *)skb->data;
> +	if (le16_to_cpu(ver->manufacturer) != 13) {
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	version = le16_to_cpu(ver->lmp_subver);
> +
> +out:
> +	if (err) bt_dev_err(hdev, "Failed to read TI version info: %d", err);
> +	kfree_skb(skb);
> +	return err ? err : version;
> +}

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170415/ab9753e4/attachment.sig>
