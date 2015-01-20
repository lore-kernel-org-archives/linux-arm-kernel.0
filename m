From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 20 Jan 2015 22:49:22 +0100
Subject: [PATCH] bluetooth: Add hci_h4p driver
In-Reply-To: <20150120082850.GA27162@t440s.lan>
References: <20141223130219.GA5731@amd>
 <20150120082850.GA27162@t440s.lan>
Message-ID: <20150120214922.GA21262@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-01-20 10:28:50, Johan Hedberg wrote:
> Hi Pavel,
> 
> On Tue, Dec 23, 2014, Pavel Machek wrote:
> > +	while (1) {
> > +		int cmd, len;
> > +
> > +		fw_pos += cmd_len;
> > +
> > +		if (fw_pos >= fw_entry->size)
> > +			break;
> > +
> > +		if (fw_pos + 2 > fw_entry->size) {
> > +			dev_err(info->dev, "Corrupted firmware image\n");
> > +			err = -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		cmd_len = fw_entry->data[fw_pos++];
> > +		cmd_len += fw_entry->data[fw_pos++] << 8;
> > +		if (cmd_len == 0)
> > +			break;
> > +
> > +		if (fw_pos + cmd_len > fw_entry->size) {
> > +			dev_err(info->dev, "Corrupted firmware image\n");
> > +			err = -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		/* Skip first two packets */
> > +		if (++num <= 2)
> > +			continue;
> > +
> > +		/* Note that this is timing-critical. If sending packets takes too
> > +		 * long, initialization will fail.
> > +		 */
> > +		cmd = fw_entry->data[fw_pos+1];
> > +		cmd += fw_entry->data[fw_pos+2] << 8;
> > +		len = fw_entry->data[fw_pos+3];
> > +
> > +		skb = __hci_cmd_sync(info->hdev, cmd, len, fw_entry->data+fw_pos+4, 500);
> > +		if (IS_ERR(skb)) {
> > +			dev_err(info->dev, "...sending cmd %x len %d failed %ld\n",
> > +				cmd, len, PTR_ERR(skb));
> > +			err = -EIO;
> > +			break;
> > +		}
> > +	}
> 
> Looks like the code is leaking skb when __hci_cmd_sync() succeeds.

Fixed, thanks!
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
