From: w@1wt.eu (Willy Tarreau)
Date: Mon, 1 Dec 2014 10:28:51 +0100
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <CAB8gEUsQ8nSNwB7vpZHBkELEBX2sN1QdWvujBGYQJY9dtCzgww@mail.gmail.com>
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
Message-ID: <20141201092851.GA22304@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 04:27:46PM +0800, Maggie Mae Roxas wrote:
> Hi Willy,
> Good day.
> 
> Thank you for the quick feedback.
> 
> > In the mean time you can apply the attached patch. I haven't submitted it yet only by lack of time :-(
> Should we apply this patch on:
> 1. 3.13.9? or
> 2. 3.13.9 with cd71e246c16b30e3f396a85943d5f596202737ba and reverted
> 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922?
> 
> This patch is expected resolve the low throughput and the kernel crash as well?
> # Not just the "No buffer space available" error?

Yes absolutely. The low throughput is caused by the use of a timer instead
of an interrupt to flush Tx descriptors. The "No buffer space available"
is caused by the Tx coalesce of 16 which only flushes the buffers after 16
packets have been emitted. When socket buffers are too small for 16 packets
(eg: ping) you get the error above. Thus setting Tx coalesce to 1 fixes it
for all situations. It's slightly less performant than coalesce 16 but you
can change it using ethtool if you want (4 still works with ping and shows
better performance).

Best regards,
Willy
