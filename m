From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 6 Dec 2016 17:26:59 -0500
Subject: [PATCH 4/5] ARM: BCM5301X: Specify all RAM by including extra
 block
In-Reply-To: <CACna6rwdKHtgp+g58B3HrDnkYZoGGZUdSqVFAGXZbf8tNTBZPg@mail.gmail.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
 <20161206171714.22738-4-zajec5@gmail.com>
 <20161206200621.GB2768@broadcom.com>
 <CACna6rwdKHtgp+g58B3HrDnkYZoGGZUdSqVFAGXZbf8tNTBZPg@mail.gmail.com>
Message-ID: <20161206222657.GA3888@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 09:57:31PM +0100, Rafa? Mi?ecki wrote:
> On 6 December 2016 at 21:06, Jon Mason <jon.mason@broadcom.com> wrote:
> > On Tue, Dec 06, 2016 at 06:17:13PM +0100, Rafa? Mi?ecki wrote:
> >> From: Rafa? Mi?ecki <rafal@milecki.pl>
> >>
> >> So far we were specifying only the first block which is always limited
> >> up to 128 MiB. There are many devices with 256 MiB and few with 512 MiB.
> >
> > Assuming that NS is like NSP (and I'm pretty sure it is), there are 2
> > ways to access the first 128M of RAM, a proxy starting at address 0
> > and the real address.  I think you are splitting RAM by accessing it
> > both ways, when you really should just be accessing it at the real
> > address.
> 
> I need some more help, please.
> 
> This patch (quite well tested) confirms that 0x88000000 can be used to
> access RAM at offset 128 MiB. If this is a real address and whole
> space is contiguous, it means the base real address should be
> 0x80000000. So using 0x0 and 0x80000000 should allow accessing
> beginning of the RAM. I took a device that was working just fine with:
> reg = <0x00000000 0x08000000>;
> and I replaced it with:
> reg = <0x80000000 0x08000000>;
> but it broke things, kernel didn't boot with the last message being:
> [    0.000000] Memory policy: Data cache writealloc
> 
> I can see that bcm958525er.dts, bcm958525xmc.dts, bcm958623hr.dts,
> bcm958625k.dts bcm988312hr.dts are using 0x60000000 as base address.
> It seems to be different from Northstar but I tried following entry
> anyway:
> reg = <0x60000000 0x08000000>;
> and I got kernel hang just like in the previous try.
> 
> Did I miss something? Or does Northstar seem to be actually different than NSP?

Per the BCM5301X Preliminary Programmer's Register Reference guide
(page 394), under the second titled "System Address Mapping".
There is a table listing the System Address Mapping.  The parts that
are of interest in this converstation are (and forgive my
approxmiation, but I cannot cut'n'paste from it):

Address Range                Size            Description
---------------------------------------------------
0x0000_0000-0x07FF_FFFF    128 MB       DDR2/3 SDRAM Memory Region*
0x8000_0000-0xBFFF_FFFF    1 G          DDR2/3 SDRAM Large Region

* The DDR2/3 SDRAM Memory Region (128MB) is a subset of the DDR2/3
SDRAM Large Region (1GB).  Additionally, 0x0000_0000-0x07FF_FFFF is
aliased to 0x8000_0000-0x87FF_FFFF

However, since you say it isn't working for you, then there must be
some other missing peice.  I'll retract my comment for now, and
hopefully we can double back and get it working in the future.

Thanks,
Jon
