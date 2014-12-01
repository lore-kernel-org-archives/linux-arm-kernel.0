From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 1 Dec 2014 10:32:21 +0100
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20141201092851.GA22304@1wt.eu>
References: <CAB8gEUvwPJUhDN-=tugTyKe93SdNwqNaGtKMF1DRCb8ZNncmmg@mail.gmail.com>
 <20140721054405.GK21834@1wt.eu>
 <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
 <20140721070303.GM21834@1wt.eu>
 <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
 <20140723061659.GE30488@1wt.eu>
 <CAB8gEUtO=K-mjie6czsf-9ao1cxiMAV2ScbgUnf+XxqjEfOUvg@mail.gmail.com>
 <CAB8gEUtgo-8nets3tRtqiZ8qRx+SyCq2d8v05scavWNwE5TNXg@mail.gmail.com>
 <20141201072802.GB21731@1wt.eu>
 <CAB8gEUsQ8nSNwB7vpZHBkELEBX2sN1QdWvujBGYQJY9dtCzgww@mail.gmail.com>
 <20141201092851.GA22304@1wt.eu>
Message-ID: <20141201103221.6268b811@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Mon, 1 Dec 2014 10:28:51 +0100, Willy Tarreau wrote:

> > This patch is expected resolve the low throughput and the kernel crash as well?
> > # Not just the "No buffer space available" error?
> 
> Yes absolutely. The low throughput is caused by the use of a timer instead
> of an interrupt to flush Tx descriptors. The "No buffer space available"
> is caused by the Tx coalesce of 16 which only flushes the buffers after 16
> packets have been emitted. When socket buffers are too small for 16 packets
> (eg: ping) you get the error above. Thus setting Tx coalesce to 1 fixes it
> for all situations. It's slightly less performant than coalesce 16 but you
> can change it using ethtool if you want (4 still works with ping and shows
> better performance).

If I understood correctly, on RX the interrupt coalescing can be done
every X packets, or after N milliseconds. However, on TX, it's only
after Y packets, there is no way to configure a delay.

But in any case, with NAPI implemented in software, are these hardware
interrupt coalescing features very important? As soon as the number of
interrupts becomes high, the kernel will disable the interrupt and
switch to polling, no?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
