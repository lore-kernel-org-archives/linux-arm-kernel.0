From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Thu, 18 Nov 2010 10:38:34 -0600
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247388682@dbde02.ent.ti.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
	<4CE124AE.4080301@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ACE1@dbde02.ent.ti.com>
	<4CE1560F.6080705@mvista.com>
	<AANLkTimDpYrx_OWg7ABXqRJ5JYzhpVbbyzVMhmFD6Wxi@mail.gmail.com>
	<4CE2AB73.3050109@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234ADA4BC@dbde02.ent.ti.com>
	<4CE2ECCD.8090603@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247388682@dbde02.ent.ti.com>
Message-ID: <AANLkTinu5tNSOhtBLJDMb+yj5ec1MQtEbGan4LZngCZK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 10:21 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Michael,
>
> On Wed, Nov 17, 2010 at 02:12:53, Michael Williamson wrote:
>>
>> Help me out. ?Why do we need generic pin lists?
>>
>
> They might help in cases where all boards will use the same set of
> pins. For example, every one who uses I2C will most likely both the
> clock and data pins from the IP. For more complex peripherals with
> different pins options they serve a documentation purpose at best.
>
>> It seems to me that the "generic pin list" for da850.c isn't practical for most
>> (if not all) of the peripherals. ?They should be done using __initdata in
>> each board file.
>
> Yes, agreed.
>
>>
>> Just a cursory glance at what's in da850.c highlights several items being set
>> up for the EVM and not generically. ?For example:
>>
>> - da850_uart1_pins and da850_uart2_pins: I believe both have RTS/CTS pins which
>> ? for a generic definition should be included as for UART0, but would then
>> ? be unused as the EVM doesn't use these pins in this function.
>
> Yes, the generic pin list should have RTS and CTS pins defined for UART1
> and UART2. This needs fixing.
>
>>
>> - da850_mcasp_pins: if generic, must include all 16 AXR pins. ?I think you'd
>> ? be hard pressed to find a board configuration that would use all 16 AXR pins
>> ? for the McASP. ?I'm fairly sure the EVM uses the pins called out, and uses
>> ? other pins for other functions. ?So it's likely this structure wouldn't get used.
>
> Yes, the generic pin list should either be completed or removed
> altogether and the existing pin list da850_mcasp_pins should be
> copied into the board file and called da850_evm_mcasp_pins.
>
>>
>> - da850_mmcsd0_pins : includes 2 GPIO pins (specific to the EVM, though possible for
>> ? other boards) for the card detect and write protect signals. ?These pins are
>> ? completely arbitrary for that particular board design. I also believe that
>> ? the complete mmcsd0 port has 4 more data lines as part of it's peripheral, although
>> ? the driver doesn't support using them.
>
> This is incorrect again. The generic pin list should be completed
> (or removed) and the existing list should be copied into the EVM board
> file as da850_evm_mmcsd0_pins.
>
>>
>> - da850_emif25_pins interface doesn't include the generic pins for some of
>> ? the SDRAM functions.
>
> Yes, this should be completed (or removed). This list is unused anyway.
>
>>
>> - da850_cpgmac_pins defines both RMII and MII pins. ?I don't think any board
>> ? would want to configure both sets at the same time. ?Seems like this should
>> ? never get used...
>
> Agreed.
>
>>
>> It's also incomplete. ?What about the uPP pin list? ?Or the VPIF? ?Etc.
>
> These should be added as the drivers for these devices are
> supported.
>
>>
>> I think a board file author should be familiar enough with the SoC to understand
>> what peripheral pins he should be configuring for his/her particular hardware setup
>> and explicitly specify them in the board file.
>
> Agree.
>
>>
>> If you remove the common pin-mux lists and move them to a board file, then once you
>> configure your specific platform, is there any more memory used than with
>> the common scheme? ?Of course, there would be replication of pin-mux code in the board
>
> There is no memory wastage. All the pin lists are init data.
>
> I too prefer all generic pin lists which are most likely not
> going to be used at all to be removed. Unused stuff like this
> will only make code difficult to read.
>
> Thanks,
> Sekhar
>
>

HI Sekhar

Let me see if I understand, you prefer to remove the unused pin list,
but that will produce a lot of changes on each board that used these
pin list. I do not have those boards, in order to test if that works
:(

I want to help to fix it and give a complete and right support to the
hawk board.

Please give me a tip of how to do it

Regards

Victor Rodriguez
