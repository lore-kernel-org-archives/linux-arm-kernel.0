From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 14:54:46 +0200
Subject: [RFC PATCH 2/2] Kbuild: avoid partial linking of
 drivers/built-in.o
In-Reply-To: <551943CB.3010303@suse.cz>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>
 <551943CB.3010303@suse.cz>
Message-ID: <CAKv+Gu92E2w1huFLyTmfe5mypZrP5gDBD2i5Jqmbf0d3_GAF_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 14:38, Michal Marek <mmarek@suse.cz> wrote:
> On 2015-03-30 13:49, Ard Biesheuvel wrote:
>> The recursive partial linking of vmlinux can result in a
>> drivers/built-in.o that is so huge that it interferes with
>> the ability of the linker to emit veneers in the final link
>> stage if the symbols are out of reach. This is caused by the
>> fact that those veneers, which should be emitted close enough
>> to the original call site, can only be emitted after the .text
>> section of drivers/built-in.o, whose size pushes those veneers
>> out of range.
>
> Is this a limitation of a particular ARM ABI or a limitation of a state
> of the art ARM linker or something else? If such a hack is necessary, it
> needs to be accompanied with an explanation as to in which environments
> it is needed, whether it can be removed at some point in future, what is
> the exact error it causes, etc. Also, are you able to gauge the
> limitation? Will it at some point affect fs/built-in.o or
> drivers/net/built-in.o?
>

The limitation results from the fact that ARM branch instructions are
limited to 24-bits of relative offset, and depending on the
instruction set (ARM or Thumb) this translates to +/- 32 MB or +/- 16
MB respectively.

Note that using -ffunction-sections works around the problem as well,
but it typically uses more space. There are other archs that add this,
to work around a similar issue.

The errors it causes are build time linker errors, i.e., after
crossing a certain size threshold, you just cannot build vmlinux
anymore.

It is not something that we would able to remove in the future, as it
is simply a result of the ISA capabilities and the build strategy that
relies heavily on partial linking. Other linkers would not be able to
do a better job, as the drivers/built-in.o(.text) section just exceeds
the maximum size that allows a branch instruction to jump out of it.

I am not sure whether it would affect other subdirs, but it is not
entirely unlikely.

A more structural approach would be to limit the contents of the
built-in.o files to the mod_init/_exit/_etc input sections, and let
those pull in everything else through a libbuilt-in.a at the same
level that contains the .text/.data etc, each of which would be
combined with the constituent ones as we do for built-in.o now. I
haven't played around with this extensively, though.

>
>> So instead, avoid building drivers/built-in.o, and instead, add
>> the constituent parts to the command line of the final link.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Makefile | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index e734965b1604..1eb6c246a586 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -558,7 +558,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
>>
>>  # Objects we will link into vmlinux / subdirs we need to visit
>>  init-y               := init/
>> -drivers-y    := drivers/ sound/ firmware/
>> +drivers-y    := sound/ firmware/
>>  net-y                := net/
>>  libs-y               := lib/
>>  core-y               := usr/
>> @@ -569,6 +569,16 @@ ifeq ($(dot-config),1)
>>  -include include/config/auto.conf
>>
>>  ifeq ($(KBUILD_EXTMOD),)
>> +
>> +# drivers/built-in.o can become huge, which interferes with the linker's
>> +# ability to emit stubs for branch targets that are out of reach for the
>> +# ordinary relative branch instructions
>> +include $(srctree)/drivers/Makefile
>> +drivers-y += $(addprefix drivers/,$(sort $(obj-y)))
>> +drivers-m += $(addprefix drivers/,$(sort $(obj-m)))
>
> I think this will break should we ever put a .c file in drivers/ directly.
>

Yes, it will
