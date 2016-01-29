From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 29 Jan 2016 21:03:40 +0300
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <m3a8nogy0u.fsf@t19.piap.pl>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-3-git-send-email-arnd@arndb.de>
 <m3a8nogy0u.fsf@t19.piap.pl>
Message-ID: <56ABA97C.1000501@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/29/2016 07:18 PM, Krzysztof Ha?asa wrote:

>> The unclear part here is for IXP4xx, which supports both big-endian
>> and little-endian configurations. So far, the driver has done
>> no byteswap in either case. I suspect that is wrong and it would
>> actually need to swap in one or the other case, but I don't know
>> which.
>
> If at all, I guess it should swap in LE mode. But it's far from certain.
>
>> It's also possible that there is some magic setting in
>> the chip that makes the endianess of the MMIO register match the
>> CPU, and in that case, the code actually does the right thing
>> for all configurations, both before and after this patch.
>
> This is IMHO most probable.
>
> Actually, the IXP4xx is "natural" in BE mode (except for PCI) and
> normally in LE mode it's order-coherent, meaning 32-bit "integer"
> accesses need no swapping, but 8-bit and (mostly unused) 16-bit
> transfers need swapping.
>
> Anyway, I think readl()/writel() do the right thing: in BE mode they
> swap PCI accesses and don't swap normal registers,

    Alas, readl()/writel() don't know what registers you are calling them for, 
they were designed for PCI which is little-endian, so they will swap in BE mode.

MBR, Sergei
