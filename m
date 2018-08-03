From: pinskia@gmail.com (Andrew Pinski)
Date: Fri, 3 Aug 2018 00:11:16 -0700
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2018 at 12:31 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Hi
>
> I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
> strange problem.
>
> When I use the links browser in graphics mode on the framebuffer, I get
> occasional pixel corruption. Links does memcpy, memset and 4-byte writes
> on the framebuffer - nothing else.
>
> I found out that the pixel corruption is caused by overlapping unaligned
> stp instructions inside memcpy. In order to avoid branching, the arm64
> memcpy implementation may write the same destination twice with different
> alignment. If I put "dmb sy" between the overlapping stp instructions, the
> pixel corruption goes away.
>
> This seems like a hardware bug. Is it a known errata? Do you have any
> workarounds for it?

Yes fix Links not to use memcpy on the framebuffer.
It is undefined behavior to use device memory with memcpy.

Thanks,
Andrew Pinski

>
> I tried AMD card (HD 6350) and NVidia (NVS 285) and both exhibit the same
> corruption. OpenGL doesn't work (it results in artifacts on the AMD card
> and lock-up on the NVidia card), but it's quite expected if even simple
> writing to the framebuffer doesn't work.
>
> Mikulas
