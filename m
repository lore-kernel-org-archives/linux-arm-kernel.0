From: angus.clark@st.com (Angus Clark)
Date: Wed, 4 Dec 2013 08:21:05 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com> <5298AA23.7080404@st.com>
 <529E976E.4050104@freescale.com> <529ED29C.1030208@st.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
Message-ID: <529EE5F1.9080806@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pekon,

On 12/04/2013 07:19 AM, Gupta, Pekon wrote:
> Unless a register is controlling a status of internal state-machine, or something
> It should be instantaneously writable.

Yes, that is my point.  Some register writes are instant, other are not,
particularly those that involve non-volatile status or configuration bits.

> Also polling should not be part of this particular *(write_reg), if a register
> needs to be polled then it should be part of *(write) or *(read) .. Like 
> WIP: Write-in-progress bit of flash
> generic_flash_write(...) {
> 	while ((read_reg(STATUS_REG) & WIP) || ~timeout) {
> 		timeout--;
> 	};

I am in two minds about where the WTR loop should live.  On the one hand, moving
it to the "generic_flash_write()" call offers H/W controllers the opportunity to
optimise the polling, if they support such a feature (I know of some that will
in the future).

However, requiring the H/W driver to perform the polling, including knowledge of
the STATUS CMD, and the WIP bit-field, just seems like moving too much
"intelligence" away from the spi-nor layer.  What concerns me is when we get on
to reading/clearing error flags (as now mandated on some Serial Flash devices,
e.g. n25p512 and n25q00a), this will also need to be part of the generic write.

> With this it just came to my mind, that you also need a 'timeout' field
> in 'struct spinor-cfg'. 

Yes, that is a good point.

I would propose that the spi-nor layer retains responsibility for determining
whether or not 'WTR' is required for a particular operation, and a suitable
timeout.  At some point, during initialisation, the H/W driver will need to
inform the spi-nor layer about its capabilities (e.g. support for DUAL or QUAD
mode, any warm-reset requirements, etc), and native support of WIP polling could
be part of this set.  The spi-nor layer could then decide whether to add the WTR
flag and timeout to the spinor-cfg transfer, or to take responsibility itself,
and execute its own polling loop.  This gives greatest flexibility, which seems
to be an important factor, while retaining the knowledge in the spi-nor layer.

Cheers,

Angus
