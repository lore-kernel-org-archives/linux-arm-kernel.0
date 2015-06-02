From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 12:24:24 +0100
Subject: [PATCH v9 4/6] Documentation: DT: PL011: hi6220: add compatible
 string for Hisilicon designed UART
In-Reply-To: <556D8B98.2040703@huawei.com>
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
 <1432950661-23060-5-git-send-email-bintian.wang@huawei.com>
 <CACRpkdav_5x6RC9F++ErvqGyxDCF-=kap7-jCsO4zZ6QGVLfBQ@mail.gmail.com>
 <556D8B98.2040703@huawei.com>
Message-ID: <20150602112424.GC2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 06:55:20PM +0800, Bintian wrote:
> On 2015/6/2 16:59, Linus Walleij wrote:
> >On Sat, May 30, 2015 at 3:50 AM, Bintian Wang <bintian.wang@huawei.com> wrote:
> >
> >>Hisilicon does some performance enhancements based on PL011(e.g. larger
> >>FIFO length), so add one compatible string "hisilicon,hi6220-uart" for
> >
> >That compatible string in the commit message is not even
> >the same as in the patch.
> The UART0 is PL011 compatible, the UART1/2 have some performance
> enhancements features, so based on Mark's suggestion and I add this
> compatible string just for future use.

Please don't submit it with this series.

This patch should not be part of this series, it should be part of the
series which modifies the PL011 driver, so it can be reviewed along with
those changes.

Until then, I'm going to NAK this patch.

The thing that worries me though is that the subject line says this
is a "Hisilicon *designed* UART".  If Hisilicon _designed_ this UART,
presumably they have changed the *vendor* field of the UART ID _not_
to indicate that ARM Ltd designed it?

If they've merely modified the parameters, and given the ARM Ltd PL011
a larger fifo, then there isn't really much of a problem - we've been
here before, except the vendor has had a real vendor ID for the field
(in the case of ST), plus we've had different FIFO lengths for ARM
hardware too (32 bytes instead of 16 for revision 3 and above.)

Lastly, if you're not having to modify the PL011 driver in any way,
you don't need to have a compatible.  In any case, you _shouldn't_ for
AMBA devices.  AMBA does not match drivers based on OF compatible
strings, so using OF compatible strings with the AMBA bus is just wrong.
The AMBA compatible strings are there so that the generic OF code knows
how to create the devices.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
