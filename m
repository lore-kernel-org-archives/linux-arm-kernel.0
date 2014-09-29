From: asierra@xes-inc.com (Aaron Sierra)
Date: Mon, 29 Sep 2014 14:05:47 -0500 (CDT)
Subject: [RFT PATCH v2] mtd: ixp4xx: Unrequire CONFIG_MTD_CFI_BE_BYTE_SWAP
In-Reply-To: <m3fvfac1cf.fsf@t19.piap.pl>
References: <1800715024.324263.1411508605796.JavaMail.zimbra@xes-inc.com>
 <m3fvfac1cf.fsf@t19.piap.pl>
Message-ID: <2014545596.82095.1412017547779.JavaMail.zimbra@xes-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Original Message -----
> From: "Krzysztof Ha?asa" <khalasa@piap.pl>
> Sent: Monday, September 29, 2014 2:50:08 AM
> 
> Aaron Sierra <asierra@xes-inc.com> writes:
> 
> > The .swap member of the map_info structure is provided for situations
> > where a mapping must always be big or little endian regardless of the
> > endianness of the system performing the access.
> 
> I like the idea but the patch doesn't work :-(
> 
> Without the patch:
> IXP4XX-Flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID
> 0x000089 Chip ID 0x008922
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Using buffer write method
> Using auto-unlock on power-up/resume
> cfi_cmdset_0001: Erase suspend on write enabled
> Searching for RedBoot partition table in IXP4XX-Flash.0 at offset 0x1fe0000
> 5 RedBoot partitions found on MTD device IXP4XX-Flash.0
> 
> With the patch applied:
> IXP4XX-Flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID
> 0x000089 Chip ID 0x008922
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Intel/Sharp Extended Query Table at 0x010A
> Using buffer write method
> Using auto-unlock on power-up/resume
> cfi_cmdset_0001: Erase suspend on write enabled
> Searching for RedBoot partition table in IXP4XX-Flash.0 at offset 0x1fe0000
> No RedBoot partition table detected in IXP4XX-Flash.0
> 
> > +++ b/drivers/mtd/maps/ixp4xx.c
> 

[ snip agreed code ]

> 
> >  #define	BYTE0(h)	((h) & 0xFF)
> >  #define	BYTE1(h)	(((h) >> 8) & 0xFF)
> >
> > -#else
> ...
> > -#define	BYTE0(h)	(((h) >> 8) & 0xFF)
> > -#define	BYTE1(h)	((h) & 0xFF)
> > -#endif
> 
> This is used by ixp4xx_copy_from(). I don't exactly know what is MTD
> layer going to do with map.swap = CFI_BIG_ENDIAN, but I think the
> natural thing (= big endian on this CPU) is to copy data in big-endian
> order, and then maybe (in LE mode) swap it.

Your guess regarding .swap is correct. The swapping is performed by
inline functions defined in include/linux/mtd/cfi.h via
cfiX_to_cpu/cpu_to_cfiX macros.

> 
> In fact, it detects those RedBoot partitions when I use the original BE
> BYTE0/BYTE1 macros (this second set, deleted by your patch).
> Tested in BE mode only for now, can't give it more time at the moment
> but will do soon.

Thanks Krzysztof, I see what I did wrong. I will submit a new patch that
defines BYTE0/BYTE1 to work for both endian modes.

-Aaron
