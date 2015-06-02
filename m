From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Jun 2015 10:13:26 +0100
Subject: [PATCH v9 4/6] Documentation: DT: PL011: hi6220: add compatible
 string for Hisilicon designed UART
In-Reply-To: <CACRpkdav_5x6RC9F++ErvqGyxDCF-=kap7-jCsO4zZ6QGVLfBQ@mail.gmail.com>
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>	<1432950661-23060-5-git-send-email-bintian.wang@huawei.com>
 <CACRpkdav_5x6RC9F++ErvqGyxDCF-=kap7-jCsO4zZ6QGVLfBQ@mail.gmail.com>
Message-ID: <556D73B6.4090608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/15 09:59, Linus Walleij wrote:
> On Sat, May 30, 2015 at 3:50 AM, Bintian Wang <bintian.wang@huawei.com> wrote:
> 
>> Hisilicon does some performance enhancements based on PL011(e.g. larger
>> FIFO length), so add one compatible string "hisilicon,hi6220-uart" for
> 
> That compatible string in the commit message is not even
> the same as in the patch.
> 
>> future optimisations or workarounds works.
>>
>> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Maybe I missed out on the earlier conversation, but do you
> mean that the PrimeCell ID has not been properly set up
> to something unique in this HiSilicon version of the PL011
> block?
> 
> Even if so: do not override the compatible string like this,
> that is not the PrimeCell style.
> 
> Define an 8 bit vendor ID (like tha ASCII for 'H' 0x48
> or whatever) and encode it for these variants, if the
> hardware is just using the ARM default PrimeCell
> ID, override it in the device tree like Broadcom
> are doing in arch/arm/boot/dts/bcm2835.dtsi:
> 
> arm,primecell-periphid = <0x00241011>;
> 
> Maybe yours would be:
> 
> arm,primecell-periphid = <0x00048011>;
> 
> For a first HiSilicon variant, then do some
> <include/linux/amba/bus.h>:
> 
> enum amba_vendor {
>         AMBA_VENDOR_ARM = 0x41,
> +       AMBA_VENDOR_HISILICON = 0x48,
> 
> Then patch drivers/tty/serial/amba_pl011.c to add vendor_hisilicon
> and a match table for 0x00048011 just like everyone else.

That feels weird. This amba_vendor enum is not under control of the DT
author, nor the kernel. This is a set of codes that are managed by a
third party (probably ARM). What if some company with a name starting
with 'H' (Hilarious Inc?) comes up with some actual HW and ends up
conflicting with the above?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
