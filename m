From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 04 Jul 2015 01:50:25 +0200
Subject: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <5596E0E5.9030300@redhat.com>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <55961C3A.8080907@huawei.com> <5596E0E5.9030300@redhat.com>
Message-ID: <2493292.PBLH7t7v9z@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 03, 2015 01:22:13 PM Al Stone wrote:
> On 07/02/2015 11:23 PM, Hanjun Guo wrote:
> > Hi Rafael,
> > 
> > On 2015/7/3 8:21, Rafael J. Wysocki wrote:
> >> On Thursday, July 02, 2015 05:48:34 PM Al Stone wrote:
> >>> Add the __ACPI_FADT_SPEC_VERSION() helper macro to build a proper version
> >>> number from a major and minor revision number.  Add also macros that use
> >>> the helper to construct the current version from the values in the FADT
> >>> (i.e., ACPI_FADT_SPEC_VERSION) and both the 5.1 and 6.0 versions.
> >>>
> >>> These macros are added in order to simplify retrieving and comparing ACPI
> >>> specification version numbers, since this is becoming a more frequent need.
> >>> In particular, there are some architectures that require at least a certain
> >>> version of the spec, and there are differences in some structure sizes that
> >>> have changed with recent versions but can only be tracked by spec version
> >>> number.
> >>>
> >>> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
> >>> Signed-off-by: Al Stone <al.stone@linaro.org>
> >>> ---
> >>>  include/linux/acpi.h | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >>> index c471dfc..0e525e8 100644
> >>> --- a/include/linux/acpi.h
> >>> +++ b/include/linux/acpi.h
> >>> @@ -48,6 +48,16 @@
> >>>  #include <acpi/acpi_io.h>
> >>>  #include <asm/acpi.h>
> >>>  
> >>> +#define __ACPI_FADT_SPEC_VERSION(major, minor) \
> >>> +	((unsigned int)major << 8 | (unsigned int)minor)
> >>> +
> >>> +#define ACPI_FADT_SPEC_VERSION	\
> >>> +	__ACPI_FADT_SPEC_VERSION(acpi_gbl_FADT.header.revision, \
> >>> +				 acpi_gbl_FADT.minor_revision)
> >>> +
> >>> +#define ACPI_FADT_SPEC_VERSION_51 __ACPI_FADT_SPEC_VERSION(5, 1)
> >>> +#define ACPI_FADT_SPEC_VERSION_60 __ACPI_FADT_SPEC_VERSION(6, 0)
> >> I'd add underscores here, eg. ACPI_FADT_SPEC_VERSION_6_0
> > 
> > Agreed.
> 
> Will do.  This was a flip of the coin, on my part.
> 
> >> And what if there is 5.2 or even 5.3?
> > 
> > Hmm, do you mean in the future or just now? for both two cases,
> > only 5.1 and 5.1 errata (still has the same ACPI version with 5.1)
> > will be available, then jump to 6.0 and going forward if new versions
> > in the future.
> > 
> > I'm not sure if I understand your question correctly, if
> > not, please correct me :)
> > 
> > Thanks
> > Hanjun
> 
> I'm not sure I understand the question, either.  Traditionally, the
> spec versioning has been exclusively linear -- i.e., now that 6.0
> has replaced 5.1, there will be no more 5.x.  There may be errata
> published (e.g., there was a 5.1A, and a 6.0A is forthcoming) but
> the errata are not encoded in tables anywhere since they are meant
> only as corrections to the base version.  This is unlikely to change,
> but not impossible, of course :).
> 
> The only reason for putting in macros for 5.1 and 6.0 is that those
> are the versions that I'm concerned with for this particular fix and
> I know I will use them.  If others are needed, I'd have those that
> need them add them.

It seems to me that you only need to compare acpi_gbl_FADT.header.revision
with 6 for this fix, though (if less than 6, use the old way, or use the
new way otherwise).

Isn't that the case?

Rafael
