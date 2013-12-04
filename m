From: pekon@ti.com (Gupta, Pekon)
Date: Wed, 4 Dec 2013 07:19:59 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <529ED29C.1030208@st.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
 <529E976E.4050104@freescale.com> <529ED29C.1030208@st.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Angus Clark [mailto:angus.clark at st.com]
>>On 12/04/2013 02:46 AM, Huang Shijie wrote:
>> ? 2013?11?29? 22:52, Angus Clark ??:
>>>     int (*write_reg)(struct spi_nor_info *info,
>>>              uint8_t cmd, uint8_t *reg, int len,
>>>              int wren, int wtr);
>> I guess you add the 'wren' for the issuing write-enable before issuing
>> the 'cmd'.
>>
>> but what's 'wtr' for? i do not know what's the meaning of the 'wtr'.
>>
>
>'wtr' is for "Wait 'til Ready".  Some register writes are instant, while others
>require polling of the "Write In Progress" bit.
>
Unless a register is controlling a status of internal state-machine, or something
It should be instantaneously writable.

Also polling should not be part of this particular *(write_reg), if a register
needs to be polled then it should be part of *(write) or *(read) .. Like 
WIP: Write-in-progress bit of flash
generic_flash_write(...) {
	while ((read_reg(STATUS_REG) & WIP) || ~timeout) {
		timeout--;
	};


With this it just came to my mind, that you also need a 'timeout' field
in 'struct spinor-cfg'. This is because different controllers would be
running at different clock speeds (and different SPI_CLK frequencies).
So they need to specify a 'timeout' value for all polling accesses.


with regards, pekon
