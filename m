From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 6 Dec 2016 21:57:31 +0100
Subject: [PATCH 4/5] ARM: BCM5301X: Specify all RAM by including extra
 block
In-Reply-To: <20161206200621.GB2768@broadcom.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
 <20161206171714.22738-4-zajec5@gmail.com>
 <20161206200621.GB2768@broadcom.com>
Message-ID: <CACna6rwdKHtgp+g58B3HrDnkYZoGGZUdSqVFAGXZbf8tNTBZPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2016 at 21:06, Jon Mason <jon.mason@broadcom.com> wrote:
> On Tue, Dec 06, 2016 at 06:17:13PM +0100, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> So far we were specifying only the first block which is always limited
>> up to 128 MiB. There are many devices with 256 MiB and few with 512 MiB.
>
> Assuming that NS is like NSP (and I'm pretty sure it is), there are 2
> ways to access the first 128M of RAM, a proxy starting at address 0
> and the real address.  I think you are splitting RAM by accessing it
> both ways, when you really should just be accessing it at the real
> address.

I need some more help, please.

This patch (quite well tested) confirms that 0x88000000 can be used to
access RAM at offset 128 MiB. If this is a real address and whole
space is contiguous, it means the base real address should be
0x80000000. So using 0x0 and 0x80000000 should allow accessing
beginning of the RAM. I took a device that was working just fine with:
reg = <0x00000000 0x08000000>;
and I replaced it with:
reg = <0x80000000 0x08000000>;
but it broke things, kernel didn't boot with the last message being:
[    0.000000] Memory policy: Data cache writealloc

I can see that bcm958525er.dts, bcm958525xmc.dts, bcm958623hr.dts,
bcm958625k.dts bcm988312hr.dts are using 0x60000000 as base address.
It seems to be different from Northstar but I tried following entry
anyway:
reg = <0x60000000 0x08000000>;
and I got kernel hang just like in the previous try.

Did I miss something? Or does Northstar seem to be actually different than NSP?
