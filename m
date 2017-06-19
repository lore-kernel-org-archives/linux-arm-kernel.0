From: ore@pengutronix.de (Oleksij Rempel)
Date: Mon, 19 Jun 2017 09:31:03 +0200
Subject: [RFC PATCH 0/3] provide imx rproc driver
In-Reply-To: <20170619051338.GA3064@Sanchayan-Arch>
References: <20170614204855.18347-1-o.rempel@pengutronix.de>
 <20170619051338.GA3064@Sanchayan-Arch>
Message-ID: <544aa538-b9b6-1ed5-ffea-919fa4ebd644@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanchayan,

On 19.06.2017 07:13, Sanchayan wrote:
> Hello Oleksij,
>
> On 17-06-14 22:48:52, Oleksij Rempel wrote:
>> Hallo all,
>>
>> this is RFC patchset to provide remoteproc functionality on
>> imx7d SoC.
>> Since current kernel do not have devicetrees for board which
>> I used for testing, this RFC patchset includes this too.
>>
>> For testing I used this simple counter written in ASM:
>> ======================================
>>         .syntax unified
>>         .text
>>         .thumb
>>         .int 0x10020000                 @ Initial SP value
>>         .int reset + 1
>>
>> reset:
>>
>>         mov     r0, #0x55
>>         ldr     r1, =(0x40)
>> 1:
>>         str     r0, [r1]
>>         add     r0, 1
>>         b       1b
>>
>>         /* Dummy data, required by remoteproc loader */
>>         /* Please FIXME, this part seem to be incorrect */
>>         .data
>>         .section .resource_table, "aw"
>>         .word   1, 0, 0, 0      /* struct resource_table base */
>>         .word   0               /* uint32_t offset[1] */
>> ============================================================
>> compiled with:
>> ${CROSS}as -o imx7m4.o imx7m4.S
>> ${CROSS}ld -Ttext=0x0 -o imx7m4.elf imx7m4.o
>> cp imx7m4.elf /srv/nfs/sid-armhf/lib/firmware/rproc-imx_rproc-fw
>>
>> Functionality was confirmed with current OpenOCD master.
>> OpenOCD cfg file can be found here:
>> https://github.com/olerem/openocd/blob/imx7-2017.06.14/tcl/target/imx7.cfg
>>
>> Comment and suggestions are welcome.
>
> Have you by chance also tried testing this with FreeRTOS code running on the
> M4 side?

no, currently my priority is to provide basic functionality with easy 
understandable target code and dependencies.
