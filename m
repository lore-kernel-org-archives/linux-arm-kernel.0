From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 13 Sep 2018 08:57:03 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
In-Reply-To: <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
Message-ID: <20180913155703.GA22605@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 05:48:59PM +0200, C?dric Le Goater wrote:
> On 09/13/2018 03:33 PM, Guenter Roeck wrote:
[ ... ]
> >>> ? /*
> >>> ?? * The state machine needs some refinement. It is only used to track
> >>> ?? * invalid STOP commands for the moment.
> >>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> >>> ? {
> >>> ????? bus->cmd &= ~0xFFFF;
> >>> ????? bus->cmd |= value & 0xFFFF;
> >>> -??? bus->intr_status = 0;> +??? bus->intr_status &= I2CD_INTR_RX_DONE;
> >>
> >> it deserves a comment to understand which scenario we are trying to handle.
> >> ?? 
> > 
> > Ok. FWIW, I wonder if intr_status should be touched here in the first place,
> > but I neither have the hardware nor a datasheet, so I don't know if any bits
> > are auto-cleared.
> 
> I just pushed a patch on my branch with some more explanation : 
> 
> 	https://github.com/legoater/qemu/commits/aspeed-3.1
> 
That seems to suggest that none of the status bits auto-clears, and that
the above code clearing intr_status should be removed entirely.
Am I missing something ?

Thanks,
Guenter
