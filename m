From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Fri, 11 May 2012 14:43:50 +0530
Subject: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
In-Reply-To: <20120510191152.GN21851@atomide.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
 <20120510191152.GN21851@atomide.com>
Message-ID: <CAMrsUdJn6G1p29QZQbo6J_-aadj=tMrfCEM5GMJSUwTdRqg05g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 12:41 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [120510 06:09]:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The commit (bce492c0 ?ARM: OMAP2+: UART: Fix incorrect population of
>> default uart pads) removed default uart pads that where getting populated
>> and which was making rx pin wakeup capable. If uart pads was used in
>
> Nitpick.. this should say "were used" here ? ? ? ? ? ? ? ? ^^^

will change this.

>
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -295,8 +353,7 @@ void __init omap_serial_board_init(struct omap_uart_port_info *info)
>> ? ? ? ? ? ? ? bdata.pads = NULL;
>> ? ? ? ? ? ? ? bdata.pads_cnt = 0;
>>
>> - ? ? ? ? ? ? if (cpu_is_omap44xx() || cpu_is_omap34xx())
>> - ? ? ? ? ? ? ? ? ? ? omap_serial_fill_default_pads(&bdata);
>> + ? ? ? ? ? ? omap_serial_check_wakeup(&bdata, uart);
>
> Should this section become:
>
> ? ? ? ? ? ? ? ?if (!info) {
> ? ? ? ? ? ? ? ? ? ? ? ?omap_serial_check_wakeup(&bdata, uart);
> ? ? ? ? ? ? ? ? ? ? ? ?omap_serial_init_port(&bdata, NULL);
> ? ? ? ? ? ? ? ?} else {
> ? ? ? ? ? ? ? ? ? ? ? ?omap_serial_init_port(&bdata, &info[uart->num]);
> ? ? ? ? ? ? ? ?}
>
> As if you have bdata, then there should not be anything to mux,
> right?

populating bdata should not depend on port_info,
omap_serial_board_init takes only port info parameter and tries to populate
wakeup parameter since it has not received the same from board file.
And board file may or may not pass port info.

So populating bdata -> for uart wakeup pin should not be coupled with
availability of port info.

--
Thanks,
Govindraj.R
