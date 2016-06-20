From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 20 Jun 2016 12:25:22 +0200
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <5755AE78.4030104@arm.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <57472450.4000709@arm.com> <574802AF.2080909@baylibre.com>
 <574BFA13.40009@baylibre.com> <5755AE78.4030104@arm.com>
Message-ID: <5767C492.60201@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 07:10 PM, Sudeep Holla wrote:
> 
> 
> On 30/05/16 09:30, Neil Armstrong wrote:
>> On 05/27/2016 10:17 AM, Neil Armstrong wrote:
> 
>>
>> While looking for other ARMv8 based platform, I found that the RK3368
>> platform has the same SCPI implementation as Amlogic.
>>
>> They extended it with DDR, system and thermal commands.
>>
>> Look at :
>> https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox/scpi_cmd.h
>>
>> https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/driver/mailbox/scpi_protocol.c
>>
>> So the SCPI must have a framework to allow different protocol
>> versions, and must allow command extension. Grouping Rockchip and
>> Amlogic should be done, thus needing a generic name like vendor_scpi
>> or with a version.
>>
>> Sudeep, could you somehow find out which version of the protocol
>> AmLogic and Rockchip based their SCPI development ?
>>
>>
> 
> As Caesar Wang replied, they had a previous version of SCPI and I
> suggested on how to extend the command set previously in private.
> Not sure whats the progress on that
This extension mechanism is OK for me.

> 
> Anyways I had a look at geekbox driver and it looks mostly based on the
> initial driver I wrote for initial SCPI versions. I am worried that your
> extension might help people to develop their own protocol instead of
> following the existing standards. SCPI is published now, so I vendors
> use that rather than making up their own. Also ARM is trying to
> standardize something in this area like PSCI, but that may take little
> more time as it's under discussion with vendors.
Sure, I understand ARM's point of view.
But keep in mind that some vendors already diverted by using one of your initial
out-of-tree code. This must be handled upstream whatever ARM business strategy is.

My proposal was a first step, it can be simplified by removing the list stuff
since we can consider there will be only one SCP interface.

> 
> Though this initial version of SCPI is not published, I am sure it is
> almost same as v1.0 except that the CMD is not part of payload like
> v1.0. In v1.0 it's part of payload and the mailbox is used just for
> doorbell mechanism.
I hoped it would be this simple, but it touches core defines and structure
that will over complicate the current driver. (i.e. the CMD indexes that differs,
the CMD size shift, the high and low priority redirection or struct ordering)

> IMO, we can add some compatible to indicate the pre v1.0 protocol
> and add the support to the existing driver itself. Let me know your
> thoughts.
> 

My proposal is :
- add a registry layer but with only a single scpi instance (no mode OF involved, remove drivers changes)
- add a scpi_legacy.c driver that only supports the old SCPI like Amlogic and Rockchip, and add a disclaimer for new developed SoCs
- add your extension capability to handle Amlogic's and Rockchip's extended commands

If you agree, I'll post a new patchset for review with these changes.

Thanks,
Neil
