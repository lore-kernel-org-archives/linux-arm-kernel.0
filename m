From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 8 Aug 2015 23:05:42 +0200
Subject: [PATCH v4 2/2] usb: Add support for ACPI identification to
 xhci-platform
In-Reply-To: <20150808153710.GA11851@kroah.com>
References: <CADaLNDkeOP+gBw0qdSDha551w+w+q4ry9-EevDw5giyiQGdnqA@mail.gmail.com>
 <5e302acb5b03c9bf61ecfb9b5b37e8b3b520bed9.1438994178.git.dhdang@apm.com>
 <20150808012905.GA10407@kroah.com>
 <CABxcv=nAxKqt06js1epALu8Y_61bZ+XeRwy_N=oQUTeRVCh6-w@mail.gmail.com>
 <20150808153710.GA11851@kroah.com>
Message-ID: <CABxcv=nRpAec7yGa8xK0Or7Jk5fzF-5SsZ+_Dn2Oa1xqntys+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

On Sat, Aug 8, 2015 at 5:37 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Aug 08, 2015 at 07:43:40AM +0200, Javier Martinez Canillas wrote:
>> Hello Greg,
>>
>> On Sat, Aug 8, 2015 at 3:29 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Aug 07, 2015 at 06:03:36PM -0700, Duc Dang wrote:
>> >> Provide the methods to let ACPI identify the need to use
>> >> xhci-platform. Change the Kconfig files so the
>> >> xhci-plat.o file is selectable during kernel config.
>> >>
>> >> This has been tested on an ARM64 machine with platform XHCI, an
>> >> x86_64 machine with XHCI, and an x86_64 machine without XHCI.
>> >> There were no regressions or error messages on the machines
>> >> without platform XHCI.
>> >>
>> >> [dhdang: regenerate the patch over 4.2-rc5]
>> >> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
>> >> Signed-off-by: Duc Dang <dhdang@apm.com>
>> >>
>> >> ---
>> >> Changes from v3:
>> >>       Regenerate the patch over 4.2-rc5
>> >>       No code change
>> >>
>> >> Changes from v2
>> >>       Replaced tristate with a boolean as the driver doesn't
>> >>               compile as a module
>> >>       Correct --help-- to ---help---
>> >>
>> >> Changes from v1
>> >>       Renamed from "add support for APM X-Gene to xhci-platform"
>> >>       Removed changes to arm64/Kconfig
>> >>       Made CONFIG_USB_XHCI_PLATFORM a user selectable config option
>> >>
>> >>  drivers/usb/host/Kconfig     |  7 ++++++-
>> >>  drivers/usb/host/xhci-plat.c | 11 +++++++++++
>> >>  2 files changed, 17 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> >> index 8afc3c1..96231ee 100644
>> >> --- a/drivers/usb/host/Kconfig
>> >> +++ b/drivers/usb/host/Kconfig
>> >> @@ -32,7 +32,12 @@ config USB_XHCI_PCI
>> >>         default y
>> >>
>> >>  config USB_XHCI_PLATFORM
>> >> -     tristate
>> >> +     tristate "xHCI platform driver support"
>> >> +     ---help---
>> >> +       Say 'Y' to enable the support for the xHCI host controller
>> >> +       as a platform device. Many ARM SoCs provide USB this way.
>> >> +
>> >> +       If unsure, say 'Y'.
>> >>
>> >>  config USB_XHCI_MVEBU
>> >>       tristate "xHCI support for Marvell Armada 375/38x"
>> >> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> >> index 5d03f8b..14b40d2 100644
>> >> --- a/drivers/usb/host/xhci-plat.c
>> >> +++ b/drivers/usb/host/xhci-plat.c
>> >> @@ -19,6 +19,7 @@
>> >>  #include <linux/usb/phy.h>
>> >>  #include <linux/slab.h>
>> >>  #include <linux/usb/xhci_pdriver.h>
>> >> +#include <linux/acpi.h>
>> >>
>> >>  #include "xhci.h"
>> >>  #include "xhci-mvebu.h"
>> >> @@ -262,6 +263,15 @@ static const struct of_device_id usb_xhci_of_match[] = {
>> >>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
>> >>  #endif
>> >>
>> >> +#ifdef CONFIG_ACPI
>> >
>> > You shoudn't need this #ifdef, right?
>> >
>>
>> Why it is not needed?
>
> Why is it needed?
>

As explained, to have avoid having an unused variable.

>> The driver does .acpi_match_table = ACPI_PTR(usb_xhci_acpi_match) and
>> ACPI_PTR() is NULL if CONFIG_ACPI is not enabled. Which can happen
>> AFAIU since the driver also supports OF. So without the #ifdef guards,
>> .acpi_match_table = NULL and the struct acpi_device_id
>> usb_xhci_acpi_match[] will be built but not used.
>
> Which is just fine, right?
>

I've seen people having different opinions about this specific case
(using #ifdef guards for ACPI, OF, etc match tables definition),
that's why I asked.

>> Or am I missing something?
>
> Don't put #ifdef in .c files if at all possible is the kernel style
> rules.
>

I know but as you said the rule is to not have #ifdef if possible. But
I understand now that for you this case doesn't justify the #ifdefery.

> thanks,
>
> greg k-h

Best regards,
Javier
