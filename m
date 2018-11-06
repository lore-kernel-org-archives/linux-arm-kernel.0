From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Nov 2018 15:13:07 +0100
Subject: [PATCH 3/4] ARM: merge -fdata-sections BSS data to .bss section
In-Reply-To: <20181106141033.GC30658@n2100.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
 <E1gK1ae-0000or-7R@rmk-PC.armlinux.org.uk>
 <CAKv+Gu9-t0QYCfXHtRJ=Oc-Gsa2f=RdRHTP_suB2oT5pKKy7ZQ@mail.gmail.com>
 <20181106141033.GC30658@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu8nGYRYPsFZW3zcOVPMBZfA6R3PhqQ2XQBPVGLPTw9t-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2018 at 15:10, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Nov 06, 2018 at 03:08:06PM +0100, Ard Biesheuvel wrote:
>> On 6 November 2018 at 14:40, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>> > When building with -fdata-sections, the BSS data is placed into separate
>> > sections, so we need to ask the linker to group these together into the
>> > .bss output section, so that they're correctly placed.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> > ---
>> >  arch/arm/boot/compressed/vmlinux.lds.S | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
>> > index 2b963d8e76dd..3b91bc3c606f 100644
>> > --- a/arch/arm/boot/compressed/vmlinux.lds.S
>> > +++ b/arch/arm/boot/compressed/vmlinux.lds.S
>> > @@ -118,7 +118,7 @@ SECTIONS
>> >
>> >    . = BSS_START;
>> >    __bss_start = .;
>> > -  .bss                 : { *(.bss) }
>> > +  .bss                 : { *(.bss) *(.bss.*) }
>>
>> Would it make sense to sort these by alignment? Otherwise, I suspect
>> you may get a lot of padding holes due to the number of different
>> input sections, each with its own alignment.
>
> We don't bother elsewhere in the kernel linker script - do you have
> a case where we get lots of padding?
>

With -fdata-sections? How else are we ensuring that each .bss item in
its own section is not placed such that its alignment results in a
padding hole?

WIthout -fdata-sections, this is done per object, and GCC takes care
of this itself.
