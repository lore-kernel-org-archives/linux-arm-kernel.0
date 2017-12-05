From: keescook@chromium.org (Kees Cook)
Date: Tue, 5 Dec 2017 11:35:59 -0800
Subject: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
In-Reply-To: <20171205133601.GX10595@n2100.armlinux.org.uk>
References: <20170823135836.52fb44fc@gandalf.local.home>
 <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
 <20170823150351.606ba09f@gandalf.local.home>
 <20171205114709.f6aj6i426keq2cn5@camel2.lan>
 <20171205131416.GW10595@n2100.armlinux.org.uk>
 <20171205132339.behn34z6b7ci2m4j@camel2.lan>
 <5b9b86cf-4b62-c984-fe52-a22df8fce33c@raspberrypi.org>
 <20171205133601.GX10595@n2100.armlinux.org.uk>
Message-ID: <CAGXu5jJb0PCSuC4DuOkh5-901iVLcmmPpn1G7UBq3-r9DaeMvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 5:36 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Dec 05, 2017 at 01:30:11PM +0000, Phil Elwell wrote:
>> This was my initial explanation:
>>
>> 1. Data which is marked __ro_after_init is initially writeable.
>>
>> 2. The ro_perms data covers kernel text, read-only data and __ro_after_init data.
>>
>> 3. set_kernel_text_rw marks everything in ro_perms as writeable.
>>
>> 4. set_kernel_text_ro marks everything in ro_perms as read-only, including the __ro_after_init data.
>>
>> 5. Using the function tracing code involves code modification, resulting in calls to
>>    __ftrace_modify_code and set_kernel_text_ro.
>>
>> 6. Therefore if function tracing is enabled before kernel_init has completed then the __ro_after_init
>>    data is made read-only prematurely.
>
> My question still stands, but let me rephrase.  Do we need
> set_kernel_text_*() to touch the read-only data?

We don't _need_ to, but they're all contiguous, so the ro_perms array
used by set_kernel_text_*() is actually only a single entry:

static struct section_perm ro_perms[] = {
        /* Make kernel code and rodata RX (set RO). */
        {
                .name   = "text/rodata RO",
                .start  = (unsigned long)_stext,
                .end    = (unsigned long)__init_begin,
...


-Kees

-- 
Kees Cook
Pixel Security
