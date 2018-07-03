From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 3 Jul 2018 09:51:48 +0200
Subject: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
In-Reply-To: <9a9ef2bc-a66f-2af7-8766-b74426f062a6@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <CAJZ5v0h5+O8xf_EqRPfdvtjQ7BvxLp8veaxB-7WsD8wq7RUFpA@mail.gmail.com>
 <9a9ef2bc-a66f-2af7-8766-b74426f062a6@arm.com>
Message-ID: <CAJZ5v0j+9QOw1s3W07QRPDRydsdw7uSAgpvOwF_5302+zeViOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2018 at 12:30 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
> On 07/02/2018 04:52 PM, Rafael J. Wysocki wrote:
>>
>> On Mon, Jul 2, 2018 at 11:41 PM, Jeremy Linton <jeremy.linton@arm.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> I'm experiencing two problems with commit 5088814a6e931 which is "ACPICA:
>>> AML parser: attempt to continue loading table after error"
>>>
>>> The first is this boot failure on a thunderX2:
>>>
>>> [   10.770098] ACPI Error: Ignore error and continue table load
>>> (20180531/psobject-604)
>>>      [   10.777926] Unable to handle kernel NULL pointer dereference at
>>>      [   10.950199] Call trace:
>>>
>>>      [   10.952663]  acpi_ps_peek_opcode+0x1c/0x40
>>>      [   10.956797]  acpi_ps_create_op+0x54/0x278
>>>      [   10.960842]  acpi_ps_parse_loop+0x1b4/0x6c8
>>>      [   10.965063]  acpi_ps_parse_aml+0xe0/0x2b4
>>>      [   10.969108]  acpi_ps_execute_table+0xa0/0x104
>>>      [   10.973505]  acpi_ns_execute_table+0x120/0x194
>>>      [   10.977989]  acpi_ns_parse_table+0x34/0x68
>>>      [   10.982122]  acpi_ns_load_table+0x4c/0xbc
>>>      [   10.986169]  acpi_tb_load_namespace+0x1d4/0x240
>>>      [   10.990744]  acpi_load_tables+0x50/0xbc
>>>      [   10.994614]  acpi_init+0xb8/0x374
>>>      [   10.997959]  do_one_initcall+0x54/0x208
>>>      [   11.001829]  kernel_init_freeable+0x224/0x300
>>>      [   11.006229]  kernel_init+0x18/0x118
>>>      [   11.009747]  ret_from_fork+0x10/0x18
>>>      [   11.013354] Code: aa0003f3 aa1e03e0 d503201f f9400661 (39400020)
>>>      [   11.019535] ---[ end trace 2bd8068593cf8acc ]---
>>>      [   11.024195] Kernel panic - not syncing: Fatal exception
>>>      [   11.029488] SMP: stopping secondary CPUs
>>>      [   11.033480] ---[ end Kernel panic - not syncing: Fatal exception
>>> ]---
>>>
>>> Which does appear to be the result of some bad data in the table, but it
>>> was
>>> working with 4.17, and reverting this commit solves the problem.
>>
>>
>> But this commit fixes another regression which was more widespread.
>>
>> Apparently, we can't work around all of the errors in the tables out
>> there at the same time. :-/
>
>
> NP, Let me see if I can come up with a way to harden the
> parse_loop/create_op code enough that it doesn't crash the machine.

Sure.  I'll look at it too.
