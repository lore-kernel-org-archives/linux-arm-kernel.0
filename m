From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 29 Nov 2018 10:50:50 +0900
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <CAKv+Gu8nVmzT-XWr-EASOdrmqN3VmacapqLqPhK0q-cNAKkhZA@mail.gmail.com>
References: <20181128150225.8D30.4A936039@socionext.com>
 <CAKv+Gu8nVmzT-XWr-EASOdrmqN3VmacapqLqPhK0q-cNAKkhZA@mail.gmail.com>
Message-ID: <20181129105050.F7FD.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, 28 Nov 2018 12:58:54 +0100 <ard.biesheuvel@linaro.org> wrote:

> Hello Kunihiko,
> 
> On Wed, 28 Nov 2018 at 07:02, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> >
> > Hi Ard,
> >
> > I found that arm64 board that had AVE controller couldn't receive
> > any packets after this change.
> >
> > AVE controller (hardware) forces to ignore lower 2bits of buffer start address,
> > that is, the address is always aligned with 4bytes.
> > And more, the controller puts received datas with "2byte headroom" [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/socionext/sni_ave.c#n591
> >
> > In case that NET_IP_ALIGN is 2, the driver proceeds skb->data by 2byte
> > with calling netdev_alloc_skb_ip_align(), and then, skb->data is equivalent
> > to start address of data reception.
> >
> >     +0x00 00  buffer start address
> >     +0x01 00
> >     +0x02 XX  skb->data == start address of data reception
> >     +0x03 XX
> >     ...
> >
> > However, in case that NET_IP_ALIGN is zero, skb->data is the same address
> > as buffer start address, so skb->data differs from start address of data
> > reception. Finally the driver can't receive any packets collectly.
> >
> >     +0x00 00  skb->data == buffer start address
> >     +0x01 00
> >     +0x02 XX  start address of data reception
> >     +0x03 XX
> >     ...
> >
> > Although I might be able to replace NET_IP_ALIGN with an own macro
> > without calling netdev_alloc_skb_ip_align(), it seems clumsy.
> > Is that any ideas?
> >
> 
> If your hardware assumes NET_IP_ALIGN == 2, then yes, I suggest you
> introduce your own macros here instead.

Okay, I understand that NET_IP_ALIGN isn't a hardware specific value.
I'll try to introduce my own macro as a hardware specific value.

Thank you,

---
Best Regards,
Kunihiko Hayashi
