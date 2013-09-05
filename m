From: b32955@freescale.com (Huang Shijie)
Date: Thu, 5 Sep 2013 15:45:30 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA0C885@DBDE04.ent.ti.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com> <20130904095523.GT3084@sirena.org.uk>
 <52270B8E.5080402@freescale.com> <20130904113322.GA5859@sirena.org.uk>
 <20130905014350.GA2261@gmail.com>
 <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C885@DBDE04.ent.ti.com>
Message-ID: <5228369A.9000904@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?05? 14:32, Gupta, Pekon ??:
>> ? 2013?09?05? 12:25, Gupta, Pekon ??:
>>> I would rather suggest to get these values from DT bindings specific to
>> could you show me what values should i set in the DT bindings?
>> The spi nor command? or the dummy? or something else?
>>
> Taking example of READ command for S25FL128S NOR flash devices..
> S25FL128S supports following flavors of READ modes.
> 	4FAST_READ Read Fast (4-byte Address) 0C
> 	4READ Read (4-byte Address) 13
> 	4DOR Read Dual Out (4-byte Address) 3C
> 	4QOR Read Quad Out (4-byte Address) 6C
> 	4DIOR Dual I/O Read (4-byte Address) BC
> 	4QIOR Quad I/O Read (4-byte Address) EC
> 	4DDRFR Read DDR Fast (4-byte Address) 0E
> 	4DDRDIOR DDR Dual I/O Read (4-byte Address) BE
> 	4DDRQIOR DDR Quad I/O Read (4-byte Address) EE
>
> But due to board constrains and your use-case, you would prefer only few
> read modes. Those opcodes you can specify via following DT property.
> "qspi, flash-read-command"
>
> Same way you can have DT property for
> "qspi, flash-write-command"
> "qspi, flash-erase-command"
> "qspi, flash-address-mode" =<4-byte/3-byte>
> "qspi, flash-dummy-cycles" =<integer>
thanks for your suggestion.

I ever thought of this solution.

But i do not think this is not a good solution. :(

Firstly, the NOR flash S25FL128S may be used by other boards or other 
platform.
So if other person uses the S25FL128S, he has to add the SPI NOR 
command(such as 0xbe, 0xec),
this is really not needed. Why not add these SPI NOR command now?


Secondly, this controller not only needs the write/erase/read, but also 
need other SPI NOR commands
such as Write-Enable/Read-status/Configurate the Register. if we add 
these SPI NOR commands to
the DT binding, it will be more ugly to veryone. That's why the Patch 1 
is needed.


The only value should be set in the DT is the _dummy_ value. But Add the 
dummy support should be an other
patchset's job. I think it is a little complicated to add the dummy support.

The fast-read uses 8bit dummy, the quad-read may needs 6bit dummy, and 
so on..

How can we transfer the dummy value to the device? Add a value to the 
spi_transfer{}?
I planed to submit another patchset to fix the dummy issue, since it 
maybe needs more discussion,
i did not include the dummy patches in this patch set.








> Example: How to select opcodes in DT ?
> (step-1) eliminate opcode which cannot be used due to board constrains.
>   your board connects only 2 data I/O between device and controller,  So you
>   cannot use any of the QUAD  Read opcodes. Thus your choice is limited to
>   DUAL or SINGLE modes only.
we have 4 data I/O lines between the device and controller, i only need 
the Quad mode. :)

thanks
Huang Shijie
