From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 07 Apr 2017 15:29:36 +0100
Subject: [RFC kvm-unit-tests PATCH 8/8] Makefiles: fix up the arm build
 include and link paths
In-Reply-To: <20170407135658.nayjvdgm4jgtbqqo@kamzik.brq.redhat.com>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-9-alex.bennee@linaro.org>
 <20170407135658.nayjvdgm4jgtbqqo@kamzik.brq.redhat.com>
Message-ID: <87h9209tpr.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andrew Jones <drjones@redhat.com> writes:

> On Thu, Apr 06, 2017 at 08:07:27PM +0100, Alex Benn?e wrote:
>> We still need to tell the compiler the correct search path for finding
>> headers and the like. This is slightly complicated by the "dynamic"
>> asm search path which is in our build tree but (may be) symlinked to
>> the right architectures headers.
>>
>> Also we explicitly include SRCDIR for the linking scripts as VPATH
>> doesn't seem to find them well enough.
>>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>  arm/Makefile.common     | 15 +++++++++------
>>  scripts/asm-offsets.mak |  4 +++-
>>  2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/arm/Makefile.common b/arm/Makefile.common
>> index 74c7394..b1fead1 100644
>> --- a/arm/Makefile.common
>> +++ b/arm/Makefile.common
>> @@ -16,7 +16,10 @@ tests-common += $(TEST_DIR)/pmu.flat
>>  tests-common += $(TEST_DIR)/gic.flat
>>  tests-common += $(TEST_DIR)/psci.flat
>>
>> -tests-all = $(tests-common) $(tests)
>> +scripts-common += $(TEST_DIR)/run
>> +scripts-common += $(TEST_DIR)/unittests.cfg
>> +
>> +tests-all = $(tests-common) $(tests) $(scripts_common)
>>  all: $(tests-all)
>>
>>  ##################################################################
>> @@ -26,13 +29,13 @@ CFLAGS += -std=gnu99
>>  CFLAGS += -ffreestanding
>>  CFLAGS += -Wextra
>>  CFLAGS += -O2
>> -CFLAGS += -I lib -I lib/libfdt
>> +CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
>>
>>  # We want to keep intermediate files
>>  .PRECIOUS: %.elf %.o
>>
>>  asm-offsets = lib/$(ARCH)/asm-offsets.h
>> -include scripts/asm-offsets.mak
>> +include $(SRCDIR)/scripts/asm-offsets.mak
>>
>>  cflatobjs += lib/util.o
>>  cflatobjs += lib/alloc.o
>> @@ -60,11 +63,11 @@ start_addr := $(shell printf "%x\n" $$(( $(phys_base) + $(kernel_offset) )))
>>
>>  FLATLIBS = $(libcflat) $(LIBFDT_archive) $(libgcc) $(libeabi)
>>  %.elf: LDFLAGS = $(CFLAGS) -nostdlib
>> -%.elf: %.o $(FLATLIBS) arm/flat.lds $(cstart.o)
>> +%.elf: %.o $(FLATLIBS) $(SRCDIR)/arm/flat.lds $(cstart.o)
>>  	$(CC) $(LDFLAGS) -o $@ \
>> -		-Wl,-T,arm/flat.lds,--build-id=none,-Ttext=$(start_addr) \
>> +		-Wl,-T,$(SRCDIR)/arm/flat.lds,--build-id=none,-Ttext=$(start_addr) \
>>  		$(filter %.o, $^) $(FLATLIBS) \
>> -		lib/auxinfo.c -DPROGNAME=\"$(@:.elf=.flat)\"
>> +		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$(@:.elf=.flat)\"
>>
>>  %.flat: %.elf
>>  	$(OBJCOPY) -O binary $^ $@
>> diff --git a/scripts/asm-offsets.mak b/scripts/asm-offsets.mak
>> index b2578a6..ecf583f 100644
>> --- a/scripts/asm-offsets.mak
>> +++ b/scripts/asm-offsets.mak
>> @@ -29,11 +29,13 @@ define make_asm_offsets
>>  endef
>>
>>  $(asm-offsets:.h=.s): $(asm-offsets:.h=.c)
>> +	mkdir -p $(dir $@)
>>  	$(CC) $(CFLAGS) -fverbose-asm -S -o $@ $<
>
> For some reason I'm not a big fan of all these mkdirs getting sprinkled
> around.  Maybe we can just have the arch makefiles be sure to create
> lib/$(ARCH) first?

Yeah I guess its a bit of a hammer to crack a nut. I guess the correct
way to deal with it is to have a proper dependency for build
directories.

I spent some time looking at QEMU's build-systems approach to it but
there was some deep magic involved so I went simple instead.

>>  $(asm-offsets): $(asm-offsets:.h=.s)
>>  	$(call make_asm_offsets)
>> -	cp -f $(asm-offsets) lib/generated
>> +	mkdir -p lib/generated
>
> Could make this directory from configure

Sure. I guess it depends on if we are likely to see other such
directories need creating.

>
>> +	cp -f $(asm-offsets) lib/generated/
>>
>>  asm_offsets_clean:
>>  	$(RM) $(asm-offsets) $(asm-offsets:.h=.s) \
>> --
>> 2.11.0
>>
>
> Thanks,
> drew


--
Alex Benn?e
