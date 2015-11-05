From: vigneshr@ti.com (Vignesh R)
Date: Thu, 5 Nov 2015 11:46:09 +0530
Subject: [PATCH v2 2/5] spi: spi-ti-qspi: add mmap mode read support
In-Reply-To: <20151104144112.GJ1717@sirena.org.uk>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-3-git-send-email-vigneshr@ti.com>
 <20151104144112.GJ1717@sirena.org.uk>
Message-ID: <563AF429.1000406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/04/2015 08:11 PM, Mark Brown wrote:
> On Tue, Nov 03, 2015 at 03:36:11PM +0530, Vignesh R wrote:
> 
>> +	ti_qspi_enable_memory_map(spi);
>> +	ti_qspi_setup_mmap_read(spi, read_opcode, addr_width,
>> +				dummy_bytes);
>> +	memcpy_fromio(buf, qspi->mmap_base + from, len);
>> +	*retlen = len;
>> +	ti_qspi_disable_memory_map(spi);
> 
> We'll be constantly enabling and disabling memory mapping with this.
> I'm not sure that's a meaningful cost given that it doesn't actually
> remap anything but rather just switches hardware modes, we can always
> optimise it later if it is.
> 

Hmm, I will move the ti_qspi_disable_memory_map() call to
ti_qspi_start_transfer_one(), so that mmap mode is disabled only when
normal SPI bus transfer is requested. Further, "mmap_enabled" status
flag can be used to determine whether mode switch is required or not.
This should help to overcome enabling and disabling memory mapping
between successive mmap read requests.

-- 
Regards
Vignesh
