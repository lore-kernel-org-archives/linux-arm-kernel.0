From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 7 Nov 2014 10:26:15 -0200
Subject: [PATCHv4 1/1] net: fec: fix regression on i.MX28 introduced by
 rx_copybreak support
In-Reply-To: <1415350967-2238-2-git-send-email-LW@KARO-electronics.de>
References: <1415350967-2238-1-git-send-email-LW@KARO-electronics.de>
 <1415350967-2238-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <CAOMZO5Cb1=Nvzu8EHqmV+K+W+ZJxzL1=5MnK6hDSstwh9ruweA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 7, 2014 at 7:02 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> commit 1b7bde6d659d ("net: fec: implement rx_copybreak to improve rx performance")
> introduced a regression for i.MX28. The swap_buffer() function doing
> the endian conversion of the received data on i.MX28 may access memory
> beyond the actual packet size in the DMA buffer. fec_enet_copybreak()
> does not copy those bytes, so that the last bytes of a packet may be
> filled with invalid data after swapping.
> This will likely lead to checksum errors on received packets.
> E.g. when trying to mount an NFS rootfs:
> UDP: bad checksum. From 192.168.1.225:111 to 192.168.100.73:44662 ulen 36
>
> Do the byte swapping and copying to the new skb in one go if
> necessary.
>
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

With this patch I am able to NFS mount on mx28 again. Thanks, Lothar!

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
