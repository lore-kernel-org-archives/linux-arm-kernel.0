From: alexis.rodet@bvs-tech.com (Alexis RODET)
Date: Mon, 22 Nov 2010 10:58:06 +0100
Subject: [PATCH] Renaming 'struct flash_platform_data' into 'struct
	spi_flash_platform_data' in include/linux/spi/flash.h
In-Reply-To: <20101121044720.GA6088@tarshish>
References: <20101117160514.GA5308@n2100.arm.linux.org.uk>
	<4CE6B27D.2000909@bvs-tech.com> <20101121044720.GA6088@tarshish>
Message-ID: <4CEA3EAE.4080700@bvs-tech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As I discussed with Russell King on the list
linux-arm-kernel at lists.infradead.org, there is a problem with the double
definition of 'struct flash_platform_data' that are incompatible:

in arch/arm/include/asm/mach/flash.h:
struct flash_platform_data {
    const char    *map_name;
    const char    *name;
    unsigned int    width;
    int        (*init)(void);
    void        (*exit)(void);
    void        (*set_vpp)(int on);
    void        (*mmcontrol)(struct mtd_info *mtd, int sync_read);
    struct mtd_partition *parts;
    unsigned int    nr_parts;
};

in include/linux/spi/flash.h:
struct flash_platform_data {
    char        *name;
    struct mtd_partition *parts;
    unsigned int    nr_parts;

    char        *type;

    /* we'll likely add more ... use JEDEC IDs, etc */
};


Both headers are included in a number of machines or driver.
They make conflict when one has both spi flash and an other type of mtd flash on the same machine (my case).

I suppose the ARM version has no reason not to be platform independent, but that is an other problem.

I propose to rename SPI version of the structure as it is the younger and it is included in a less number of files.
The patch (already sent on linux-arm-kernel at lists.infradead.org) is in attachment.

Best regards,
Alexis RODET


Le 21/11/2010 05:47, Baruch Siach a ?crit :
> Hi Alexis,
>
> On Fri, Nov 19, 2010 at 06:23:09PM +0100, Alexis RODET wrote:
>>> It would, however, be nice if _someone_ out there could produce a patch
>> Here is the patch and here is the command line used for doing this:
> You need to CC the MTD maintainer and mailing list (David Woodhouse 
> <dwmw2@infradead.org>, and linux-mtd at lists.infradead.org respectively), and 
> maybe also the SPI subsystem maintainers (David Brownell 
> <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, 
> spi-devel-general at lists.sourceforge.net).
>
> baruch
>

-------------- next part --------------
An embedded message was scrubbed...
From: Alexis RODET <alexis.rodet@bvs-tech.com>
Subject: [PATCH] Renaming 'struct flash_platform_data' into 'struct spi_flash_platform_data'
 in include/linux/spi/flash.h
Date: Fri, 19 Nov 2010 18:23:09 +0100
Size: 25208
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101122/8f4f2919/attachment-0001.mht>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: alexis_rodet.vcf
Type: text/x-vcard
Size: 315 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101122/8f4f2919/attachment-0001.vcf>
