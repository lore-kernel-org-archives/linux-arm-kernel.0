From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Aug 2016 12:24:53 +0100
Subject: [PATCH] arm64: fix address fault during mapping fdt region
In-Reply-To: <579F2BA6.1010203@zoho.com>
References: <579F197B.80101@zoho.com>
 <CAKv+Gu9QQdncCD_T8+tpdVP8qx=EKM9-PGLvb8J9RNA2qHddFw@mail.gmail.com>
 <579F2BA6.1010203@zoho.com>
Message-ID: <20160801112450.GD11119@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 06:59:50PM +0800, zijun_hu wrote:
> On 08/01/2016 05:50 PM, Ard Biesheuvel wrote:
> > On 1 August 2016 at 11:42, zijun_hu <zijun_hu@zoho.com> wrote:
> > Couldn't we simply do this instead?
> this solution maybe better, my reason as follows?
> 
> 1?it can achieve our original purpose, namely, checking whether fdt
> header is corrupted before fetching fdt size field; good fdt header can
> ensure good fdt size field included more rightly than only a magic filed
> normally

The only additional fields fdt_check_header checks are version and
last_comp_version. In the absence of corruption, deferring these checks
should be ok. We assume that the header is compatible regardless (or
those fields would be meaningless).

Even with corruption, it's possible for these to appear valid to
fdt_check_header(). For the purpose of best-effort corruption detection,
checking the magic alone in this early codepath seems ok to me. It seems
unlikely that we'd have a valid magic yet a corrupted totalsize.

That all said, I'm not against mapping the whole header if it's simple
enough to do so.

> 2?it is more portable; we only need to call fdt_check_header() and don't
> care about fdt header filed layout; moreover,fdt module is another independent
> module and arm64 only uses it and should not depend on more details of fdt
> such as size and magic fields locate within the first MIN_FDT_ALIGN bytes;
> the decision whether a fdt header is corrupted should be left to fdt team

While it's true that we assume knowledge of the FDT format, and ideally
we'd leave this to common code, we do so regardless by requiring the
header size. So both approaches assume details regarding the FDT format.

Thanks,
Mark.
