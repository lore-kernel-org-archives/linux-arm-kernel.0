From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 8 Sep 2015 21:36:01 +0200
Subject: [PATCH 15/16] mtd: mtdcore: fix initcall level
In-Reply-To: <55E91746.4060502@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
 <1440592108-3740-16-git-send-email-holler@ahsoftware.de>
 <20150901211938.GJ81844@google.com> <55E68A72.30909@ahsoftware.de>
 <55E91746.4060502@ahsoftware.de>
Message-ID: <55EF38A1.2040201@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.09.2015 um 06:00 schrieb Alexander Holler:
> Am 02.09.2015 um 07:34 schrieb Alexander Holler:
>> Am 01.09.2015 um 23:19 schrieb Brian Norris:
>>> Hi Alexander,
>>>
>>> No judgment here for the rest of this series, but for this patch:
>>>
>>> On Wed, Aug 26, 2015 at 02:28:27PM +0200, Alexander Holler wrote:
>>>> The mtd-core has to be initialized before other dependent mtd-drivers,
>>>> otherwise a crash might occur.
>>>>
>>>> Currently mtd_init() is called in the initcall-level device, which is
>>>> the
>>>> same level where most mtd-drivers will end up. By luck this seemed to
>>>> have
>>>> been called most of the time before other mtd-drivers without having
>>>> been
>>>> explicitly enforced.
>>>
>>> I can't really speak for the original authors, but it does not appear to
>>> be entirely "by luck." Link order was one of the de facto ways to get
>>> this ordering (though it's not really a great one), and mtdcore was
>>> always linked first within the drivers/mtd/ directory structure.
>>>
>>> But that's just background, I think this is worth fixing anyway. It
>>> could, for instance, become a problem if drivers are located outside
>>> drivers/mtd/; I see random board files in arch/ that register with MTD,
>>> and I'm actually not sure how they have never tripped on this.

As I've just had a look at my patches in order to clean up the patch for 
parallel initialization (to post it here too):

drivers/mtd/ofparts.c has the same problem. In order to let the 
NAND-driver see the partitions defined in the DT I had to move this into 
another initcall level (fs sync) too.

Regards,

Alexander Holler
