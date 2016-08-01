From: zijun_hu@zoho.com (zijun_hu)
Date: Mon, 1 Aug 2016 21:17:09 +0800
Subject: [PATCH] arm64: fix address fault during mapping fdt region
In-Reply-To: <20160801112450.GD11119@leverpostej>
References: <579F197B.80101@zoho.com>
 <CAKv+Gu9QQdncCD_T8+tpdVP8qx=EKM9-PGLvb8J9RNA2qHddFw@mail.gmail.com>
 <579F2BA6.1010203@zoho.com> <20160801112450.GD11119@leverpostej>
Message-ID: <579F4BD5.9060300@zoho.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2016 07:24 PM, Mark Rutland wrote:
> On Mon, Aug 01, 2016 at 06:59:50PM +0800, zijun_hu wrote:
>> On 08/01/2016 05:50 PM, Ard Biesheuvel wrote:
>>> On 1 August 2016 at 11:42, zijun_hu <zijun_hu@zoho.com> wrote:
>>> Couldn't we simply do this instead?
>> this solution maybe better, my reason as follows?
>>
>> 1?it can achieve our original purpose, namely, checking whether fdt
>> header is corrupted before fetching fdt size field; good fdt header can
>> ensure good fdt size field included more rightly than only a magic filed
>> normally
> 
> The only additional fields fdt_check_header checks are version and
> last_comp_version. In the absence of corruption, deferring these checks
> should be ok. We assume that the header is compatible regardless (or
> those fields would be meaningless).
> 
> Even with corruption, it's possible for these to appear valid to
> fdt_check_header(). For the purpose of best-effort corruption detection,
> checking the magic alone in this early codepath seems ok to me. It seems
> unlikely that we'd have a valid magic yet a corrupted totalsize.
> 
> That all said, I'm not against mapping the whole header if it's simple
> enough to do so.
>
 
okay, as indicated by another mail sent by ard.biesheuvel, "the only fields we
can assume to be mapped are 'magic' and 'totalsize'", accessing last_comp_version
or version maybe causes address fault under some extreme conditions

according to current fdt_check_header definition, another case is regard as 
good fdt header, condition (fdt_magic(dt_virt) != FDT_MAGIC) don't cover
as marked within below function body

int fdt_check_header(const void *fdt)
{
	if (fdt_magic(fdt) == FDT_MAGIC) {
		/* Complete tree */
		if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
			return -FDT_ERR_BADVERSION;
		if (fdt_last_comp_version(fdt) > FDT_LAST_SUPPORTED_VERSION)
			return -FDT_ERR_BADVERSION;
	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
		/* Unfinished sequential-write blob */
		if (fdt_size_dt_struct(fdt) == 0)  
			return -FDT_ERR_BADSTATE;

acess field size_dt_struct too, this condition is regarded as good fdt header too


	} else {
		return -FDT_ERR_BADMAGIC;
	}

	return 0;
}

>> 2?it is more portable; we only need to call fdt_check_header() and don't
>> care about fdt header filed layout; moreover,fdt module is another independent
>> module and arm64 only uses it and should not depend on more details of fdt
>> such as size and magic fields locate within the first MIN_FDT_ALIGN bytes;
>> the decision whether a fdt header is corrupted should be left to fdt team
> 
> While it's true that we assume knowledge of the FDT format, and ideally
> we'd leave this to common code, we do so regardless by requiring the
> header size. So both approaches assume details regarding the FDT format.
> 
okay, the only thing my solution is depends on is the fdt header struct name
which maybe remain unchanged in further fdt source modification
regardless of fields layout or position or header size;

by the way, my solution only maps more one SWAPPER_BLOCK_SIZE at extreme condition
(offset + sizeof(struct fdt_header)) > SWAPPER_BLOCK_SIZE, it can occurs very rarely,
even it happens, it is no matter due to the fast mapping operations

That all said, ard.biesheuvel's can resolves address fault too, you can decide which
solution to used, maybe ask fdt team for some advisements

> Thanks,
> Mark.
> 
