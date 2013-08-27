From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 27 Aug 2013 02:08:16 +0200
Subject: [RFC] cleanup mach-s5p*
In-Reply-To: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
References: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
Message-ID: <14202744.Ci7A03X8EJ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Monday 26 of August 2013 09:52:47 Kukjin Kim wrote:
> Hi all,
> 
> I have a plan to remove supporting following SoCs in mainline in the
> near future.
> - s5pc100 - smdkc100

We already have this almost moved to device tree. A common clock framework 
and pin control drivers should be posted soon. Supporting this platform 
should be reasonably easy, as it has a lot in common with other SoCs like 
S3C64xx and S5PV210.

> - s5pv210(s5c110) - aquial, goni, smdkc110, smdkv210, torbreck

We already have support for device tree for this in our internal tree. 
Some RFC patches have been already posted by Mateusz Krawczuk. We intend 
to mostly support Aquila and Goni as they are the platforms we are still 
using for our work.

I also have plans to add support for FriendlyARM's {Mini,Tiny}210 board 
series, which would just translate to adding appropriate board dts files. 
It's also worth noting that S5PV210 (FriendlyARM's board specifically) is 
being supported by Pengutronix in their Barebox bootloader [1][2].

I'd be all for completely dropping legacy board files of this platform and 
others mentioned in this thread, though.

> - s5p64x0(s5p6440, s5p6450)- smdk6440, smdk6450

I haven't seen any hardware on this platform myself. As Marek said, we 
don't have any boards to test mainline support on it and I'm not aware of 
any interested users. This is probably the primary candidate to be 
dropped.

My personal addition to the above list would be:

 - unused boards based on s3c64xx

I'm yet to investigate which ones are virtually dead today. The active 
ones that I would want to be kept are Cragganmore, Mini6410 and both SMDK 
boards. They are going to be moved to DT, though. AFAIK mach-ncp could be 
safely dropped, as from what I know, it isn't used anymore.

> I think users don't seem to use that any more with mainline. If so, we
> are able to consider, it is not right now though.
> 
> How do you think?

Well, if we could drop legacy board file support for them and keep them as 
DT only, support for them could be reasonably simple. Basically the code 
in arch/arm would be limited to a single .c file per SoC (e.g. mach-
s5pv210-dt.c), a bunch of SoC-level .dtsi files and a bunch of board dts 
files.

IMHO the best thing we could do would be creating a single mach-samsung, 
where all the DT-only platforms could be located, including Exynos after 
some remaining consolidation.

Best regards,
Tomasz

[1]
http://barebox.org/index.html

[2]
http://git.pengutronix.de/?p=barebox.git;a=tree;f=arch/arm/boards/friendlyarm-tiny210;h=ee3306d5e6770b8e6568fb58e9e1824cfe59fbce;hb=HEAD
