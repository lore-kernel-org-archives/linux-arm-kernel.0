From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Feb 2015 15:51:54 +0800
Subject: [PATCH] xen/arm: allow console=hvc0 to be omitted for guests
In-Reply-To: <1423553200.5851.15.camel@citrix.com>
References: <1422626319-30752-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.DEB.2.02.1502100648050.29696@kaball.uk.xensource.com>
 <1423553200.5851.15.camel@citrix.com>
Message-ID: <CAKv+Gu8kQ5e9dKTp9+e_11pnvskOPjin7ODpxXTj+HmTj+fPag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2015 at 15:26, Ian Campbell <ian.campbell@citrix.com> wrote:
> On Tue, 2015-02-10 at 07:00 +0000, Stefano Stabellini wrote:
>> On Fri, 30 Jan 2015, Ard Biesheuvel wrote:
>> > This patch registers hvc0 as the preferred console if no console
>> > has been specified explicitly on the kernel command line.
>> >
>> > The purpose is to allow platform agnostic kernels and boot images
>> > (such as distro installers) to boot in a Xen/ARM domU without the
>> > need to modify the command line by hand.
>> >
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > ---
>> >
>> > This applies on top of the patch Julien is cooking up to move the
>> > call to xen_guest_init() to an earlier boot stage. This needs to
>> > be at least before the call to console_init() in start_kernel()
>> > for this patch to do anything meaningful.
>>
>> This patch looks good but there isn't much point in queuing this up
>> without the prerequisite.
>>
>> Julien, what patch exactly is that? What is the status of it?
>>
>>
>> >  arch/arm/xen/enlighten.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> > index c7ca936ebd99..61382cafa877 100644
>> > --- a/arch/arm/xen/enlighten.c
>> > +++ b/arch/arm/xen/enlighten.c
>> > @@ -24,6 +24,7 @@
>> >  #include <linux/cpuidle.h>
>> >  #include <linux/cpufreq.h>
>> >  #include <linux/cpu.h>
>> > +#include <linux/console.h>
>> >
>> >  #include <linux/mm.h>
>> >
>> > @@ -322,6 +323,9 @@ static int __init xen_guest_init(void)
>> >
>> >     register_cpu_notifier(&xen_cpu_notifier);
>> >
>> > +   if (!console_set_on_cmdline)
>> > +           add_preferred_console("hvc", 0, NULL);
>
> FWIW on x86 this doesn't depend on console_set_on_cmdline, does it need
> to here?
>

I didn't check the code, but it seems inappropriate to add a preferred
console implicitly if the user has set 'console=' on the command line.

> On x86 it does depend on !xen_initial_domain. I suppose on the principal
> that a VT is normally available there. I suppose that doesn't apply to
> ARM so much, although it could.
>

OK, I got confused by the xen_guest_init(). So do you mean if if
(!xen_initial_domain) should be added?

-- 
Ard.
