From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Jan 2017 11:25:52 +0000
Subject: [RFC] Kernel panic down to swiotlb when doing insmod a simple
 driver
In-Reply-To: <99472068-069a-7759-8d6e-019fd875264d@arm.com>
References: <d64931b6-8875-51ea-06a0-e0981e12f859@rock-chips.com>
 <99472068-069a-7759-8d6e-019fd875264d@arm.com>
Message-ID: <CAKv+Gu-aaGuHmshi=aiexUD=dxuia7tHKm3LQt3RG-7D_3v9Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2017 at 11:03, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/01/17 10:00, Shawn Lin wrote:
>> Hi,
>>
>> Sorry for sending this RFC for help as I couldn't find some useful hint
>> to slove my issue by git-log the swiotlb commit from kernel v4.4 to
>> v4.9 and I'm also not familar with these stuff. So could you kindly
>> point me to the right direction to debug it? Thanks. :)
>>
>> --------------------------------------
>> We just have a very simple wifi driver *built as ko module* which only
>> have a probe function to do the basic init work and call SDIO API to
>> transfer some bytes.
>>
>> Env: kernel 4.4 stable tree, ARM64(rk3399)
>>
>> Two cases are included:
>
> And they are both wrong :)
>
>> The crash case:
>>
>> u8 __aligned(32) buf[PAGE_SIZE]; //global here in ko driver file
>
> It is only valid to do DMA from linear map addresses - I'm not sure if
> the modules area was in the linear map before, but either way it
> probably isn't now (Ard, Mark?). Either way, I don't believe static data
> honours ARCH_DMA_MINALIGN in general, so it's still highly inadvisable.
>

The __aligned() modifier should work fine: the alignment is propagated
to the ELF section alignment, which in turn is honoured by the module
loader. The problem is that '32' is too low for non-coherent DMA to be
safe. In general, alignments up to 4 KB should work everywhere.

I am surprised though that this ever  worked as a module, given that
modules are (and have always been) loaded in the vmalloc area, which
means VA to PA translations performed in the DMA layer on the
addresses of statically allocated buffers are unlikely to return
correct values (as your panic log proves)

>> static int wifi_probe(struct sdio_func *func, const struct
>> sdio_device_id *id)
>> {
>>   // prepare some SDIO work before
>>   printk("wifi_probe: buf = 0x%x\n", buf);
>>   sdio_memcpy_toio(func, 0, buf, 200);
>> }
>>
>> The workable case:
>>
>> static int wifi_probe(struct sdio_func *func, const struct
>> sdio_device_id *id)
>> {
>>
>>    u8 __aligned(32) buf[PAGE_SIZE]; //move inside the probe function
>
> No. DMA from the stack is right out, both for the aforementioned
> alignment reasons, and the fact that we now have (or will have)
> virtually-mapped stacks. One of the benefits of the latter is that it
> catches bugs like this ;)
>

Actually, aligned stack variables also work fine. But DMA involving
the stack is not, so that is not really relevant.

> Get your buffer from kmalloc() or a page allocation, and everything
> should be correct.
>

Agreed.
