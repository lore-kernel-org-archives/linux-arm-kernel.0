From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 17 Nov 2015 20:17:35 +0800
Subject: [PATCH 09/13] ARM: Xen: Initialize Xen specific UEFI runtime
 services
In-Reply-To: <CAKv+Gu9-g6fttchWkg_ptCGwUD-hbyM2F0x1Wrv=dAa6bsMVBQ@mail.gmail.com>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>	<1447754231-7772-10-git-send-email-shannon.zhao@linaro.org>
 <CAKv+Gu9-g6fttchWkg_ptCGwUD-hbyM2F0x1Wrv=dAa6bsMVBQ@mail.gmail.com>
Message-ID: <564B1ADF.70105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/17 19:28, Ard Biesheuvel wrote:
>> @@ -308,13 +311,18 @@ static int __init arm64_enable_runtime_services(void)
>> >         }
>> >         set_bit(EFI_SYSTEM_TABLES, &efi.flags);
>> >
>> > -       if (!efi_virtmap_init()) {
>> > -               pr_err("No UEFI virtual mapping was installed -- runtime services will not be available\n");
>> > -               return -1;
>> > -       }
>> > +       if (!xen_initial_domain()) {
>> > +               if (!efi_virtmap_init()) {
>> > +                       pr_err("No UEFI virtual mapping was installed -- runtime services will not be available\n");
>> > +                       return -1;
>> > +               }
>> >
> I'd prefer it if we could separate the code logically, rather than
> putting xen_initial_domain() tests in all the code paths.
> 
> For instance, we could re-use the EFI_PARAVIRT flag, and set if from
> the Xen init code. Then, we could simply test it here, and bail early.
> That way, you can have a Xen specific alternative (which does not use
> the virtmap etc anyway) in a xen source file.
> 
Ok, will do. Thanks.

-- 
Shannon
