From: tobiasrauter@gmail.com (Tobias Rauter)
Date: Fri, 27 Sep 2013 18:03:39 +0200
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <201309261407.33923.marex@denx.de>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-2-git-send-email-marex@denx.de>
 <CAOMZO5AU_R5aeHKbkGRGuyXsVOVdUwdF5oZXdEZZYs442nFnEA@mail.gmail.com>
 <201309261407.33923.marex@denx.de>
Message-ID: <5245AC5B.80800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some thoughts of the design decisions I made when I wrote
the dcp.c driver. Maybe it helps.

On 2013-09-26 14:07, Marek Vasut wrote:
> Dear Fabio Estevam,
>
>> Hi Marek,
>>
>> Why do we need to have two drivers for the same IP block? It looks
>> confusing to have both.
>
> Sure, I agree. I reviewed the one in mainline just now and I see some
> deficiencies of the dcp.c driver:
>
> 1) It only supports AES_CBC (mine does support AES_ECB, AES_CBC, SHA1 and SH256)

Right, but for ECP only the interface is missing (and it is no real
mode of operation) and hashes should be generally faster in SW.

> 2) The driver was apparently never ran behind anyone working with MXS.


That is probably right.


> 3) What are those ugly new IOCTLs in the dcp.c driver?

When I firstly posted the driver in the mailinglist, there where one
person who actually used this interface (it was introduced in
Freescale's SDK) to use the OTP keys for crypto. As far as I have
seen, the crypto API does not support such keys (i.e. there seems to
be no way to tell a driver to use some kind of special keys - which
are not delivered by the user - via the API).
Therefore I added this miscdevice and adopted Freescale's interface.

> 4) The VMI IRQ is never used, yet it even calls the IRQ handler, this is bogus

That's absolutely right.

>     -> The DCP always triggers the dcp_irq upon DMA completion

The IRQ is triggered after every packet, to enable simultaneous work
for CPU/DCP: While the DCP is computing, the CPU is able to fill more
packets. I don't know how far this is useful, because the 20 Packets
which are enabled by default can address up to 80kB of
plain-/ciphertext. However, I think it is better to do the work 
simultaneously to safe time (actual real world time, not CPU time).

> 5) The IRQ handler can't use usual completion() in the driver because that'd
> trigger "scheduling while atomic" oops, yes?

I decided to use the tasklets because of performance reasons. I don't
remember numbers but a workqueue was significantly slower.  The
use of a kernel thread may reduce the overhead compared to the wq. I
was not sure if it is appropriate to create an extra thread for a
crypto-driver, without real reason (IMHO).

> Finally, because the dcp.c driver only supports AES128 CBC, it depends on kernel
> _always_ passing the DCP scatterlist such that each of it's elements is 16-bytes
> long. [...]
> So, in the AES128 case, if the hardware is passed two (4 bytes + 12 bytes for
> example) DMA descriptors instead of single 16 bytes descriptor, the DCP will
> simply stall or produce incorrect result. This can happen if the user of the
> async crypto API passes such a scatterlist.

The scatterlist alignment and bounce-buffering to get full 16 Byte
blocks is done by the ablkcipher_walk API (with the error
parameter) when needed. As far as I see, you are copying the whole 
buffer to your coherent block and back. Wouldn't it be better to do that 
just for unaligned blocks?


kind regards,
tr
