From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Wed, 13 Feb 2013 15:26:54 +0100
Subject: [PATCH 1/3] i2c: mxs: support non-dma mapable buffers
In-Reply-To: <20130213142124.GB17833@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 13 Feb 2013 14:21:24 +0000")
References: <1360763336-1931-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20130213142124.GB17833@n2100.arm.linux.org.uk>
Message-ID: <lyzjz8guhd.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> +++ b/drivers/i2c/busses/i2c-mxs.c
>> ...
>> +
>> +	/*
>> +	 * internal buffer for handling non-dma mapable buffers; when message
>> +	 * exceeds the (arbitrary) size of '8', a buffer will be kmalloc()'ed
>> +	 * instead of using this attribute
>> +	 */
>> +	unsigned char			xfer_buf[8];
>
> Beware.  Remember that DMA cache maintanence operates on a granularity of
> a cache line, and make sure that you're not going to be upset should the
> cache line be read by accessing the other members of this struct.  It's
> probably altogether safer if you kmalloc this buffer separately at driver
> init time, and make it an "unsigned char *xfer_buf".

Yes; this is generally true.  But the i2c-mxs.c driver is for the mxs
where the i2c dma channel supports also only byte aligned addresses.

Shall I mention this in the comment?


Btw, there is only one patch; the '1/3' in the subject was created by
mistake.


Enrico
