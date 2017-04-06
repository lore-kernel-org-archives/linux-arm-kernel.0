From: daniel.kiper@oracle.com (Daniel Kiper)
Date: Thu, 6 Apr 2017 17:20:40 +0200
Subject: [PATCH] arm64: xen: Implement EFI reset_system callback
In-Reply-To: <ed7f64f4-17db-e2a5-f362-b382666cbc36@suse.com>
References: <20170405181417.15985-1-julien.grall@arm.com>
 <e5b548be-2ec3-9b4f-a456-929d5fb881ab@oracle.com>
 <b8c9c6cd-906a-2360-ca9f-d34a45258567@suse.com>
 <3f6f5853-cd08-8afc-f71a-b0c1545c7564@arm.com>
 <20170406142710.GE4372@olila.local.net-space.pl>
 <ed7f64f4-17db-e2a5-f362-b382666cbc36@suse.com>
Message-ID: <20170406152040.GH4372@olila.local.net-space.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 04:38:24PM +0200, Juergen Gross wrote:
> On 06/04/17 16:27, Daniel Kiper wrote:
> > On Thu, Apr 06, 2017 at 09:32:32AM +0100, Julien Grall wrote:
> >> Hi Juergen,
> >>
> >> On 06/04/17 07:23, Juergen Gross wrote:
> >>> On 05/04/17 21:49, Boris Ostrovsky wrote:
> >>>> On 04/05/2017 02:14 PM, Julien Grall wrote:
> >>>>> The x86 code has theoritically a similar issue, altought EFI does not
> >>>>> seem to be the preferred method. I have left it unimplemented on x86 and
> >>>>> CCed Linux Xen x86 maintainers to know their view here.
> >>>>
> >>>> (+Daniel)
> >>>>
> >>>> This could be a problem for x86 as well, at least theoretically.
> >>>> xen_machine_power_off() may call pm_power_off(), which is efi.reset_system.
> >>>>
> >>>> So I think we should have a similar routine there.
> >>>
> >>> +1
> >>>
> >>> I don't see any problem with such a routine added, in contrast to
> >>> potential "reboots" instead of power off without it.
> >>>
> >>> So I think this dummy xen_efi_reset_system() should be added to
> >>> drivers/xen/efi.c instead.
> >>
> >> I will resend the patch during day with xen_efi_reset_system moved
> >> to common code and implement the x86 counterpart (thought, I will
> >> not be able to test it).
> >
> > I think that this is ARM specific issue. On x86 machine_restart() calls
> > xen_restart(). Hence, everything works. So, I think that it should be
> > fixed only for ARM. Anyway, please CC me when you send a patch.
>
> What about xen_machine_power_off() (as stated in Boris' mail)?

Guys what do you think about that:

--- a/drivers/firmware/efi/reboot.c
+++ b/drivers/firmware/efi/reboot.c
@@ -55,7 +55,7 @@ static void efi_power_off(void)

 static int __init efi_shutdown_init(void)
 {
-       if (!efi_enabled(EFI_RUNTIME_SERVICES))
+       if (!efi_enabled(EFI_RUNTIME_SERVICES) || efi_enabled(EFI_PARAVIRT))
                return -ENODEV;

        if (efi_poweroff_required())


Julien, for ARM64 please take a look at arch/arm64/kernel/efi.c:efi_poweroff_required(void).

I hope that tweaks for both files should solve our problem.

Daniel
