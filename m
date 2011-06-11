From: davem@davemloft.net (David Miller)
Date: Sat, 11 Jun 2011 16:26:00 -0700 (PDT)
Subject: [PATCH v3 5/5] net: ep93xx_eth: fix DMA API violations
In-Reply-To: <d1ab2a21856804a430be57469595d5c1f7cb936c.1307816881.git.mika.westerberg@iki.fi>
References: <a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
	<a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
	<d1ab2a21856804a430be57469595d5c1f7cb936c.1307816881.git.mika.westerberg@iki.fi>
Message-ID: <20110611.162600.1058381951078443013.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <mika.westerberg@iki.fi>
Date: Sat, 11 Jun 2011 21:39:58 +0300

> Russell King said:
>>
>> So, to summarize what its doing:
>>
>> 1. It allocates buffers for rx and tx.
>> 2. It maps them with dma_map_single().
>>       This transfers ownership of the buffer to the DMA device.
>> 3. In ep93xx_xmit,
>> 3a. It copies the data into the buffer with skb_copy_and_csum_dev()
>>       This violates the DMA buffer ownership rules - the CPU should
>>       not be writing to this buffer while it is (in principle) owned
>>       by the DMA device.
>> 3b. It then calls dma_sync_single_for_cpu() for the buffer.
>>       This transfers ownership of the buffer to the CPU, which surely
>>       is the wrong direction.
>> 4. In ep93xx_rx,
>> 4a. It calls dma_sync_single_for_cpu() for the buffer.
>>       This at least transfers the DMA buffer ownership to the CPU
>>       before the CPU reads the buffer
>> 4b. It then uses skb_copy_to_linear_data() to copy the data out.
>>       At no point does it transfer ownership back to the DMA device.
>> 5. When the driver is removed, it dma_unmap_single()'s the buffer.
>>       This transfers ownership of the buffer to the CPU.
>> 6. It frees the buffer.
>>
>> While it may work on ep93xx, it's not respecting the DMA API rules,
>> and with DMA debugging enabled it will probably encounter quite a few
>> warnings.
> 
> This patch fixes these violations.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Tested-by: Petr Stetiar <ynezz@true.cz>

Applied.
