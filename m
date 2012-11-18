From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 18 Nov 2012 21:55:15 +0100
Subject: [Patch v1 1/1] RTL8712 alignment bug in 3.6.5 on ARM
In-Reply-To: <50A9429D.1010908@lwfinger.net>
References: <CAMW5UfYUi-Zz2r5K9GeVzShSub2rDJVuoWR56+89+ytaqo_uxQ@mail.gmail.com>
 <20121118181140.GC14643@lunn.ch> <50A9429D.1010908@lwfinger.net>
Message-ID: <20121118205515.GK11717@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 02:18:37PM -0600, Larry Finger wrote:
> On 11/18/2012 12:11 PM, Andrew Lunn wrote:
> >
> >Just to clarify the issue here:
> >
> >union pn48 {
> >         u64 val;
> >#if defined(__BIG_ENDIAN)
> >         struct {
> >                 u8 TSC7;
> >                 u8 TSC6;
> >
> >Any instance of pn48 needs to be 64 bit aligned when the val member of
> >the union is used. The structure sta_info contains two such pn48s, so
> >the code allocating the pool of these needs to ensure it allocated
> >them 64 bit aligned, not 32bit aligned as it currently is.
> 
> Andrew,
> 
> For my education, would the following patch ensure 64-bit alignment
> for the pn48 instances, or is more needed?

This is not sufficient. In fact it makes no difference at all. The
problem is not with the structure, but with the allocation of memory
used to contain the structure.

        pstapriv->pallocated_stainfo_buf = _malloc(sizeof(struct sta_info) *
                                                   NUM_STA + 4);
        if (pstapriv->pallocated_stainfo_buf == NULL)
                return _FAIL;
        pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
                ((addr_t)(pstapriv->pallocated_stainfo_buf) & 3);

kmalloc() guarantees that its alignment is correct for any type of
structure. Thus all this code above is redundant in Linux, but maybe
needed in some other OS. Worse still, this code actually breaks the
alignment. kmalloc() gave out something which was 64 bit aligned. But
by adding 4 and then masking off the lower 2 bits, it destroys the 64
bit alignment and makes it only 32bit aligned.

Removing the _malloc() wrapper, fixing the GFP_ATOMIC, and leaving the
allocater to worry about alignment will be one of the steps to getting
out of staging.

    Andrew
