From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 19 Jan 2017 23:06:07 +0100
Subject: [PATCH v5 0/2] Add support for the ethernet switch on the
 ESPRESSObin
In-Reply-To: <20170119214934.27442-1-gregory.clement@free-electrons.com>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
Message-ID: <20170119220607.GA25907@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> While comparing the datasheet and the ops functions used, some
> question came to me. They should not prevent applying this series,
> but their answer would help me to have a better understanding of the
> dsa subsystem.
> 
> - Are the temperature related operation still useful with dsa2 ?

No. I'm in the process of moving the code into the Marvell PHY driver,
since the sensor is in the embedded PHYs.

What ID does the embedded PHY use? The 6390 has a blank ID, where as
older device have a real ID.

> - Why the setup is done differently between the 6390 and the 6352
>   families when the have exactly the same register?

EDSA on 6390 works differently to 6352, meaning it breaks. So we need
to run the 6390 with DSA tagging, not EDSA. Maybe this is the source
of the differences?

It should also be noted that the 6390 support is not yet complete. I
have a few more patches in my tree to post.

>   - On the Port Controller 2, the bit PORT_CONTROL_2_MAP_DA is set for
>     6352 and not for 6390 whereas the same bit exists in 6360 and the
>     description for this bit is the same for both datasheet.

Humm, it does look like it is missing mv88e6xxx_6390_family(chip).
 
> 
>   - Register PORT_ATU_CONTROL and PORT_PRI_OVERRIDE are reset on 6352
>     and not on 6390. While here again the registers description are
>     the same.

And the same here. I've mostly been working on where the 6390 is
different. Where it is the same i've mostly ignored it so far :-)

There is also an ongoing effort to remove all these big if statements
with a list of families.

     Andrew
