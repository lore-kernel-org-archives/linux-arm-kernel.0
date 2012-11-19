From: Larry.Finger@lwfinger.net (Larry Finger)
Date: Sun, 18 Nov 2012 18:10:00 -0600
Subject: [Patch v1 1/1] RTL8712 alignment bug in 3.6.5 on ARM
In-Reply-To: <20121118205515.GK11717@lunn.ch>
References: <CAMW5UfYUi-Zz2r5K9GeVzShSub2rDJVuoWR56+89+ytaqo_uxQ@mail.gmail.com>
 <20121118181140.GC14643@lunn.ch> <50A9429D.1010908@lwfinger.net>
 <20121118205515.GK11717@lunn.ch>
Message-ID: <50A978D8.1060309@lwfinger.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2012 02:55 PM, Andrew Lunn wrote:

> This is not sufficient. In fact it makes no difference at all. The
> problem is not with the structure, but with the allocation of memory
> used to contain the structure.
>
>          pstapriv->pallocated_stainfo_buf = _malloc(sizeof(struct sta_info) *
>                                                     NUM_STA + 4);
>          if (pstapriv->pallocated_stainfo_buf == NULL)
>                  return _FAIL;
>          pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
>                  ((addr_t)(pstapriv->pallocated_stainfo_buf) & 3);
>
> kmalloc() guarantees that its alignment is correct for any type of
> structure. Thus all this code above is redundant in Linux, but maybe
> needed in some other OS. Worse still, this code actually breaks the
> alignment. kmalloc() gave out something which was 64 bit aligned. But
> by adding 4 and then masking off the lower 2 bits, it destroys the 64
> bit alignment and makes it only 32bit aligned.
>
> Removing the _malloc() wrapper, fixing the GFP_ATOMIC, and leaving the
> allocater to worry about alignment will be one of the steps to getting
> out of staging.

As you surmised, the original driver was meant for several Windows systems as 
well as Linux.

This driver will not make it out of staging until it supports the mac80211 
stack. Work to accomplish this has started by modifying the rtl8192se code to 
work with the USB interface. I will make certain that the alignment issues are 
fixed there.

Thanks for the lesson,

Larry
