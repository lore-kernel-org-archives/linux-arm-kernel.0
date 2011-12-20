From: aneesh@ti.com (Aneesh V)
Date: Tue, 20 Dec 2011 15:46:49 +0530
Subject: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
In-Reply-To: <4EEFC23A.30201@gmail.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
 <4EEFC23A.30201@gmail.com>
Message-ID: <4EF06091.1050102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 December 2011 04:31 AM, Rob Herring wrote:
> On 12/19/2011 08:05 AM, Aneesh V wrote:
>> This is an RFC to add new device tree bindings for DDR memories and
>> EMIF - TI's DDR SDRAM controller.
>>
>> The first patch adds bindings for DDR memories. Currently,
>> we have added properties for only DDR3 and LPDDR2 memories.
>> However, the binding can be easily extended to describe
>> other types such as DDR2 in the future.
>>
>> The second patch provides the bindings for the EMIF controller.
>>
>> The final patch provides DT data for EMIF controller instances
>> in OMAP4 and LPDDR2 memories attached to them on various boards.
>>
>> Thanks to Rajendra for answering my numerous queries on device tree.
>>
>> This is a re-post of the RFC that was posted to devicetree-discuss ml,
>> now sent to a larger audience and looping out an internal list.
>> Please ignore the previous version.
>
> There's already a standard way (i.e. JEDEC standard) to define DDR chip
> configuration that's called SPD. Why invent something new? While this is
> normally an i2c eeprom on a DIMM, there's no reason you couldn't get it
> from somewhere else including perhaps the DT. There's already code in
> u-boot that can parse SPD data.

Thanks for pointing this out. I looked into this a bit. I see some
difficulties in adopting SPD for our needs.

1. Our primary target is LPDDR2 and I can't seem to find an SPD
standard for LPDDR2. Maybe, because automatic memory detection is not
that critical in the embedded world.

2. I did find one for DDR SDRAM memories(Appendix D, Rev 1.0 - maybe
for the first generation of PC DDR memories). But many of the AC timing
parameters needed to program our controller are not listed in it.

3. We do not really need DDR3 support at the moment because we do not
intend to scale DDR frequency in platforms with DDR3 memory. This is
due the to limited operating frequency range of DDR3.

So, I was wondering whether I should limit the binding to only LPDDR2
and have an SPD based binding for DDR2/DDR3 if that is required later?
What do you think?

>
> In general, is it really feasible to parse the DTB before DDR is
> initialized?

As pointed out by Tony we rely on bootloader for the initial SDRAM
configuration. The kernel SDRAM controller driver is used mainly for
DVFS and thermal management.

best regards,
Aneesh
