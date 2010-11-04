From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 4 Nov 2010 17:54:00 +0200
Subject: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board
	file
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC3BB@dbde02.ent.ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
	<AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
	<AANLkTinNrZNuZnFfJKGLF9J3zsHsOTK0+VmUmYH88+c3@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC323@dbde02.ent.ti.com>
	<AANLkTik3gO1Rm2U8-Rm2t2M83sdCjz_Oktpve_gDrbNM@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC331@dbde02.ent.ti.com>
	<AANLkTinfO5e9JewdTDxasTRrUAXhGaQs=n6=HnqOQP7S@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC3BB@dbde02.ent.ti.com>
Message-ID: <AANLkTikbcHM4MpWm9ar-hLZBh3g5PkD3PK6FxY_bGd8u@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 4, 2010 at 2:52 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
>> -----Original Message-----
>> It has changed in 2.5.36, take a look how it was in 2.6.35, when it
>> worked for me:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
>> 2.6.git;a=blob;f=drivers/mtd/nand/omap2.c;h=ee87325c7712a8eeee4bbc683f9301
>> 4c9901f337;hb=9fe6206f400646a2322096b56c59891d530e8d51
>>
>> notice how 2.5.36 has CONFIG_MTD_NAND_OMAP_HWECC defined and 2.6.35
>> doesn't.
>>
>> The test case is simple:
>> format and use NAND on 2.6.35 or earlier, works fine.
>> upgrade to 2.6.36 or 2.6.37-rc1 and try to mount the same NAND
>> partition - lots of ECC errors.
>
> [Ghorai] I tested this and working fine in zoom3.
>
> And as you mentioned there may be an issue we need to identify,
> So remove this #define form 2.6.36 and let me know the test result.

After removing #define it works, but only without
CONFIG_MTD_NAND_OMAP_PREFETCH. With prefetch enabled, sub-page reads
return ECC errors, for example:

nanddump -p -l 1024 -s 512 /dev/mtd3
ECC: 3 uncorrectable bitflip(s) at offset 0x00000200

nanddump -p -l 1024 -s 0 /dev/mtd3
nanddump -p -l 1024 -s 1024 /dev/mtd3
works ok.

Sub-pages need to be working for UBI, my NAND partitions are formatted
with UBIFS.
