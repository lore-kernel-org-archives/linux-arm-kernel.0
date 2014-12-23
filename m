From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 23 Dec 2014 13:00:48 +0100
Subject: [PATCH]  bluetooth: Add hci_h4p driver
In-Reply-To: <D5E3AD8F-9122-49FE-B932-F9DDBB89840F@holtmann.org>
References: <20141213223727.GA13894@amd> <20141220202314.GA8484@amd>
 <D5E3AD8F-9122-49FE-B932-F9DDBB89840F@holtmann.org>
Message-ID: <20141223120048.GA848@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +	/* We should always send word aligned data to h4+ devices */
> > +	if (skb->len % 2) {
> > +		err = skb_pad(skb, 1);
> > +		if (!err)
> > +			*skb_put(skb, 1) = 0x00;
> > +	}
> > +	if (err)
> > +		return err;
> 
> This is crazy code.
> 
> 	if (skb->len % 2) {
> 		if (!skb_pad(skb, 1)
> 			return -ENOMEM;
> 		*skb_put(skb, 1) = 0x00;
> 	}

This does not work, it needs to be if (skb_pad())... and it does not
propagate error value. Took me few boots to debug, as I still can't
scroll back after kernel crash...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
