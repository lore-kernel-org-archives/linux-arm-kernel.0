From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Oct 2015 10:35:00 -0700
Subject: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
 controller
In-Reply-To: <20151012215459.GA8843@kryptos>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
 <1443808606-21203-4-git-send-email-anup.patel@broadcom.com>
 <20151004214943.GA28904@localhost>
 <39063E8F96E11742B35A201CC5D095B7AD54C1@SJEXCHMB10.corp.ad.broadcom.com>
 <20151006134119.GB26818@localhost> <56144A62.70300@broadcom.com>
 <5614574C.2060701@gmail.com>
 <39063E8F96E11742B35A201CC5D095B7AD8ADD@SJEXCHMB10.corp.ad.broadcom.com>
 <20151012215459.GA8843@kryptos>
Message-ID: <561D40C4.4030703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/15 14:54, Josh Cartwright wrote:
> On Wed, Oct 07, 2015 at 03:33:50AM +0000, Anup Patel wrote:
>> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
>>> On 06/10/15 15:25, Scott Branden wrote:
> [..]
>>> Then instead of adding a "reset flag" to Device Tree, another approach could be
>>> to put the desired or currently configured exhaustive list of NAND timings in
>>> Device Tree, and based on that you could have this:
>>>
>>> - the NAND controller driver finds that these timings match the current
>>> configuration, you are good to go
>>>
>>> - the NAND controller drivers finds a difference in how current timings are
>>> configured vs. desired timings, and issues a controller reset, prior to applying
>>> new timing configuration
>>
>> To add to this ...
>>
>> The mechanism to reset is BRCM NAND controller is SOC specific so the
>> SoC independent BRCM NAND driver (i.e. brcmnand.c) does not know how
>> to reset the NAND controller.
>>
>> For iProc SoC family, the NAND controller reset is through IDM register
>> space which is only iomap'ed by iproc_nand.c.
>>
>> We might end-up having one more SoC specific callback which will be
>> Provided by iproc_nand.c to brcmnand.c.
> 
> Not that I'm familiar with these SoCs, but I did want to chime in and
> make sure you are aware of the existing reset_controller_dev
> abstraction, which is intended to solve exactly this problem.  Including
> a reset_control_get_optional() that might fit your use case.  See
> include/linux/reset{,-controller}.h.

I almost suggested that, and then looked more closely at where this
reset register is located, and it happens to be in the NAND controller
itself (IPROC IDM which is the iProc SHIM to the NAND controller), so
coming up with a reset controller driver and a reset controller consumer
for that simple use case sounds both unnecessary and complex.

The core of the discussion is about disguising this NAND controller
reset as a way to preserve previously configured NAND timings, which is
at best a hack and an unstated dependency with the firmware.
-- 
Florian
