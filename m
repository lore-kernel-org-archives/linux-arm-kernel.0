From: lacombar@gmail.com (Arnaud Lacombe)
Date: Fri, 12 Aug 2011 16:31:50 -0400
Subject: Relinking zImage when nothing changes
In-Reply-To: <20110812202450.GA28713@merkur.ravnborg.org>
References: <4E4566F0.4020001@codeaurora.org>
	<20110812180209.GA28520@merkur.ravnborg.org>
	<CACqU3MUkZBEs=v9181bixR37R4DxmkykiH5fU8PVUTd0c2a_ZA@mail.gmail.com>
	<20110812202450.GA28713@merkur.ravnborg.org>
Message-ID: <CACqU3MUV_XuhZ1jJWd3oMnyz9q4h1BwLp+z_VzQaccM7DXqzdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 12, 2011 at 4:24 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Aug 12, 2011 at 04:20:15PM -0400, Arnaud Lacombe wrote:
>> Hi,
>>
>> On Fri, Aug 12, 2011 at 2:02 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> > On Fri, Aug 12, 2011 at 10:46:24AM -0700, Stephen Boyd wrote:
>> >> I was hoping with the recent patch e78e8f2 (kernel: prevent unnecessary
>> >> rebuilding due to config_data.gz, 2011-07-05) compiling ARM linux a
>> >> second time would amount to no more linking. This doesn't seem to be the
>> >> case though. Doing a make V=2 I see that lib1funcs.S is shipped and thus
>> >> we have to recompile it although nothing actually changed. This in turn
>> >> requires us to relink the compressed vmlinux and then recreate the zImage.
>> >>
>> >> ? Kernel: arch/arm/boot/Image is ready
>> >> ? SHIPPED arch/arm/boot/compressed/lib1funcs.S - due to missing .cmd file
>> >> ? AS ? ? ?arch/arm/boot/compressed/lib1funcs.o - due to: arch/arm/boot/compressed/lib1funcs.S
>> >> ? LD ? ? ?arch/arm/boot/compressed/vmlinux - due to: arch/arm/boot/compressed/lib1funcs.o
>> >> ? OBJCOPY arch/arm/boot/zImage - due to: arch/arm/boot/compressed/vmlinux
>> >> ? Kernel: arch/arm/boot/zImage is ready
>> >>
>> >>
>> >> Is there any way to avoid this? Perhaps the shipped command could become
>> >> a bit wiser?
>> >
>> > Following patch will likely fix it:
>> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
>> > index 0c74a6f..80b6b6e 100644
>> > --- a/arch/arm/boot/compressed/Makefile
>> > +++ b/arch/arm/boot/compressed/Makefile
>> > @@ -123,7 +123,7 @@ LDFLAGS_vmlinux += -T
>> > ?# For __aeabi_uidivmod
>> > ?lib1funcs = $(obj)/lib1funcs.o
>> >
>> > -$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
>> > +$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S
>> > ? ? ? ?$(call cmd,shipped)
>> >
>> AFAIK, we have a generic rule to handle shipped files:
>>
>> from scripts/Makefile.lib:
>>
>> $(obj)/%: $(src)/%_shipped
>> ? ? ? ? $(call cmd,shipped)
>>
>> so, that rule should not be needed at all.
>
> In this case the cmd_shipped is misused to make a copy of a file.
> So the generic rule does not apply.
>
oh, indeed. I see your point.

 - Arnaud
