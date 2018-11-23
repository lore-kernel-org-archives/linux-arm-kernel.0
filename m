From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Nov 2018 12:56:17 +0100
Subject: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
In-Reply-To: <20181123111700.GA31881@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo> <20181121142740.GA29704@ulmo>
 <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
 <20181122084712.GA5741@ulmo> <20181123111700.GA31881@ulmo>
Message-ID: <20181123115617.GB31881@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 12:17:00PM +0100, Thierry Reding wrote:
> On Thu, Nov 22, 2018 at 09:47:12AM +0100, Thierry Reding wrote:
> [...]
> > Perhaps you'd be less concerned about such a change if it was perhaps
> > more explicit? Just throwing ideas around, I think something that could
> > also work is if we explicitly add a mbox_flush() function that would
> > basically be calling ->flush(). That way users of the mailbox can make
> > their requirement very explicit. I haven't actually tested that, but I
> > think it would work. Does that sound more acceptable to you?
> 
> I tried implementing the explicit flushing on top of this series and it
> would look roughly like the below. What do you think?
> 
> Thierry
> 
> --->8---
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
[...]
> @@ -184,9 +185,6 @@ static int tegra_tcu_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	tcu->tx_client.dev = &pdev->dev;
> -	tcu->tx_client.tx_block = true;
> -	tcu->tx_client.tx_tout = 10000;
> -	tcu->rx_client.dev = &pdev->dev;

Somehow this line ended up being removed in the diff, but it's actually
required. Only tx_block and tx_tout should be removed in this hunk.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/26eb64d0/attachment.sig>
