From: pekon@ti.com (Gupta, Pekon)
Date: Thu, 5 Sep 2013 06:32:58 +0000
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <522817D7.1010206@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com> <20130904095523.GT3084@sirena.org.uk>
 <52270B8E.5080402@freescale.com> <20130904113322.GA5859@sirena.org.uk>
 <20130905014350.GA2261@gmail.com>
 <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA0C885@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ? 2013?09?05? 12:25, Gupta, Pekon ??:
> > I would rather suggest to get these values from DT bindings specific to
> could you show me what values should i set in the DT bindings?
> The spi nor command? or the dummy? or something else?
> 
Taking example of READ command for S25FL128S NOR flash devices..
S25FL128S supports following flavors of READ modes.
	4FAST_READ Read Fast (4-byte Address) 0C
	4READ Read (4-byte Address) 13
	4DOR Read Dual Out (4-byte Address) 3C
	4QOR Read Quad Out (4-byte Address) 6C
	4DIOR Dual I/O Read (4-byte Address) BC
	4QIOR Quad I/O Read (4-byte Address) EC
	4DDRFR Read DDR Fast (4-byte Address) 0E
	4DDRDIOR DDR Dual I/O Read (4-byte Address) BE
	4DDRQIOR DDR Quad I/O Read (4-byte Address) EE

But due to board constrains and your use-case, you would prefer only few
read modes. Those opcodes you can specify via following DT property.
"qspi, flash-read-command"

Same way you can have DT property for
"qspi, flash-write-command"
"qspi, flash-erase-command"
"qspi, flash-address-mode" = <4-byte/3-byte>
"qspi, flash-dummy-cycles" = <integer>

Example: How to select opcodes in DT ?
(step-1) eliminate opcode which cannot be used due to board constrains.
 your board connects only 2 data I/O between device and controller,  So you
 cannot use any of the QUAD  Read opcodes. Thus your choice is limited to
 DUAL or SINGLE modes only.

(step-2) select opcode based on use-case.
(a) To maximize your throughput you would mostly use DUAL read opcode
- fsl-qspi, flash-read-opcode = 0x3C  /* 4DOR Read Dual Out (4-byte Address) */
- fsl-qspi, flash-read-opcode = 0xBC  /* 4DIOR Dual I/O Read (4-byte Address) */
(b) But If you are using XIP then you would single out to:
- fsl-qspi, flash-read-opcode = 0xBC  /* 4DIOR Dual I/O Read (4-byte Address) */

Though I agree, end-user should be transparent of all these,
but this is better than asking them to submit patches for each new NOR device
..Any thoughts  ?

with regards, pekon
