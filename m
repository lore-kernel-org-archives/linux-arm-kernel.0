From: lho@apm.com (Loc Ho)
Date: Thu, 22 Oct 2015 15:27:05 -0700
Subject: [PATCH v3 0/2] Common SerDes driver for TI's Keystone Platforms
In-Reply-To: <56295B9E.9030201@ti.com>
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com>
 <5628FB36.4010303@ti.com>
 <20151022174812.GX32532@n2100.arm.linux.org.uk>
 <56295B9E.9030201@ti.com>
Message-ID: <CAPw-ZTk1vJA3YSwLHBNMYP0t5k2tW0HTKse+37rL8izWN33y-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

>>
>>
>> Again, there's other SoCs out there which have serdes.  Adding 2.5k of
>> lines for vendor serdes implementations does not scale - this needs to
>> be re-thought in a way which reduces the code maintanence burden.
>>
>> Other SoCs like Marvell Armada have serdes links which can be configured
>> between SATA, PCIe and Gbe.  Should Armada end up adding another 2.5k
>> lines to support their device too?  What happens when we have 10 of
>> these, and we have 25k lines of code here?
>>
>> Again, this does not scale.  Please look at what can be done to reduce
>> the code size when other implementations come along.
>
>
> Well, per our understanding, this driver is a Generic phy driver and we have
> implemented a device driver based on Generic Phy API. This driver is
> expected to support all of the 3 peripherals :- PCIe, 1G and 10G Ethernet.
> You have mentioned about Marvell & Armada . Did Marvell post any patch
> already? Without seeing their code, how will we be able to investigate what
> can be factored out to a generic serdes core driver? By making this
> statement, I assume you are still considering using the Generic Phy driver
> framework for SerDes drivers. Don't you?
>
> I did a search in the phy folder and these are the top ones that came out in
> terms of number of lines of code after Phy-core.c.
>
> ls *.[ch] | xargs wc -l | sort -n
>
>    943 phy-core.c
>   1279 phy-miphy28lp.c
>   1735 phy-xgene.c
>   2367 phy-keystone-serdes.c
>
> So focusing on the top 3 drivers (including keystone serdes) under phy.
>
> phy-xgene.c
> -----------
>
> Looking at other drivers under drivers/phy, I could find phy-xgene.c which
> is close Keystone SerDes driver (. This is called APM X-Gene Multi-Purpose
> PHY driver. It defines following mode per the driver code
>
>         MODE_SATA       = 0,    /* List them for simple reference */
>         MODE_SGMII      = 1,
>         MODE_PCIE       = 2,
>         MODE_USB        = 3,
>         MODE_XFI        = 4,
>
> But seems to support only MODE_SATA. From the code, it appears, this driver
> is expected to be enhanced in the future to support additional modes. I have
> copied the author to this email to participate in this discussion.

Let me comment on this APM X-Gene driver. This driver is dead and
won't be supported in near or foreseeable future. And someday, it will
be ripped out. Based on experience, this solution (having PHY driver
in Linux) can't be supported across boards and etc as it is just too
much maintenance. And therefore, we followed Arnd B guidance and move
all this into the boot loader. From Linux or OS perspective, it only
cares about the interface in which its interface with. This is just
your reference and may be this will help you as well.

-Loc
