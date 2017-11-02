From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 15:13:32 +0000
Subject: [PATCH 06/17] coresight: tmc: Make ETR SG table circular
In-Reply-To: <CANLsYkwKgCEQ5QXLR2ERqrL5JdCbgS1rwJfWLQD8XGmaH+O9Fw@mail.gmail.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-7-suzuki.poulose@arm.com>
 <20171101234717.GA16611@xps15>
 <db0a9a62-e2b5-6895-f7b9-42989d3d56e2@arm.com>
 <CANLsYkwKgCEQ5QXLR2ERqrL5JdCbgS1rwJfWLQD8XGmaH+O9Fw@mail.gmail.com>
Message-ID: <20171102151332.GB9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 08:40:16AM -0600, Mathieu Poirier wrote:
> On 2 November 2017 at 06:00, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> > On 01/11/17 23:47, Mathieu Poirier wrote:
> >>
> >> On Thu, Oct 19, 2017 at 06:15:42PM +0100, Suzuki K Poulose wrote:
> >>>
> >>> Make the ETR SG table Circular buffer so that we could start
> >>> at any of the SG pages and use the entire buffer for tracing.
> >>> This can be achieved by :
> >>>
> >>> 1) Keeping an additional LINK pointer at the very end of the
> >>> SG table, i.e, after the LAST buffer entry, to point back to
> >>> the beginning of the first table. This will allow us to use
> >>> the buffer normally when we start the trace at offset 0 of
> >>> the buffer, as the LAST buffer entry hints the TMC-ETR and
> >>> it automatically wraps to the offset 0.
> >>>
> >>> 2) If we want to start at any other ETR SG page aligned offset,
> >>> we could :
> >>>   a) Make the preceding page entry as LAST entry.
> >>>   b) Make the original LAST entry a normal entry.
> >>>   c) Use the table pointer to the "new" start offset as the
> >>>      base of the table address.
> >>> This works as the TMC doesn't mandate that the page table
> >>> base address should be 4K page aligned.
> >>>
> >>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> ---
> >
> >
> >>> +static int __maybe_unused
> >>> +tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table, u64 base_offset)
> >>> +{
> >>> +       u32 last_entry, first_entry;
> >>> +       u64 last_offset;
> >>> +       struct tmc_sg_table *sg_table = etr_table->sg_table;
> >>> +       sgte_t *table_ptr = sg_table->table_vaddr;
> >>> +       ssize_t buf_size = tmc_sg_table_buf_size(sg_table);
> >>> +
> >>> +       /* Offset should always be SG PAGE_SIZE aligned */
> >>> +       if (base_offset & (ETR_SG_PAGE_SIZE - 1)) {
> >>> +               pr_debug("unaligned base offset %llx\n", base_offset);
> >>> +               return -EINVAL;
> >>> +       }
> >>> +       /* Make sure the offset is within the range */
> >>> +       if (base_offset < 0 || base_offset > buf_size) {
> >>> +               base_offset = (base_offset + buf_size) % buf_size;
> >>> +               pr_debug("Resetting offset to %llx\n", base_offset);
> >>> +       }
> >>> +       first_entry = tmc_etr_sg_offset_to_table_index(base_offset);
> >>> +       if (first_entry == etr_table->first_entry) {
> >>> +               pr_debug("Head is already at %llx, skipping\n",
> >>> base_offset);
> >>> +               return 0;
> >>> +       }
> >>> +
> >>> +       /* Last entry should be the previous one to the new "base" */
> >>> +       last_offset = ((base_offset - ETR_SG_PAGE_SIZE) + buf_size) %
> >>> buf_size;
> >>> +       last_entry = tmc_etr_sg_offset_to_table_index(last_offset);
> >>> +
> >>> +       /* Reset the current Last page to Normal and new Last page to
> >>> NORMAL */
> >>> +       tmc_etr_sg_update_type(&table_ptr[etr_table->last_entry],
> >>> +                                ETR_SG_ET_NORMAL);
> >>> +       tmc_etr_sg_update_type(&table_ptr[last_entry], ETR_SG_ET_LAST);
> >>> +       etr_table->hwaddr = tmc_etr_sg_table_index_to_daddr(sg_table,
> >>> +                                                           first_entry);
> >>> +       etr_table->first_entry = first_entry;
> >>> +       etr_table->last_entry = last_entry;
> >>> +       pr_debug("table rotated to offset %llx-%llx, entries (%d - %d),
> >>> dba: %llx\n",
> >>> +                       base_offset, last_offset, first_entry,
> >>> last_entry,
> >>> +                       etr_table->hwaddr);
> >>
> >>
> >> The above line generates a warning when compiling for ARMv7.
> >
> >
> > Where you running with LPAE off ? That could probably be the case,
> > where hwaddr could be 32bit or 64bit depending on whether LPAE
> > is enabled. I will fix it.
> 
> My original setup did not have LPAE configured but even when I do
> configure it I can generate the warnings.
> 
> Compiler:
> 
> arm-linux-gnueabi-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
> 
> Let me know if you want my .config file.

For those who don't know... (it seems it's an all too common mistake).

In the printf format definition, the flag can be used to determine the
data type for the format.  Of those flags, the two which are relevant
here are:

	l	printf expects a "long" or "unsigned long" type.
	ll	printf expects a "long long" or "unsigned long long" type.

The size of "long" or "long long" is ABI dependent.  Typically, on
32-bit platforms, "long" is 32-bit and "long long" is 64-bit.  On
64-bit platforms, "long" is 64-bit and "long long" is 128-bit.

Moreover, ABIs can mandate alignment requirements for these data types.
This can cause problems if you do something like:

	u64 var = 1;

	printk("foo %lx\n", var);

If a 32-bit architecture mandates that arguments are passed in ascending
32-bit registers from r0, and 64-bit arguments are to be passed in an
even,odd register pair, then the above printk() is a problem.

The format specifies a "long" type, which is 32-bit type, printk() will
expect the value in r1 for the above, but the compiler has arranged to
pass "var" in r2,r3.  So the end result is that the above prints an
undefined value - whatever happens to be in r1 at the time.

Don't laugh, exactly this problem is in kexec-tools right now!

The kernel data types (and C99 data types) that are typed using the bit
width map to the standard C types.  What this means is that a "u64"
might be "long" if building on a 64-bit platform, or "long long" if
building on a 32-bit platform:

include/uapi/asm-generic/int-ll64.h:typedef unsigned long long __u64;
include/uapi/asm-generic/int-l64.h:typedef unsigned long __u64;

This means if you try and pass a u64 integer variable to printf, you
really can't use either of the "l" or "ll" flags, because you don't
know which you should be using.

The guidance at the top of Documentation/printk-formats.txt concerning
s64/u64 is basically incorrect:

Integer types
=============

::

        If variable is of Type,         use printk format specifier:
        ------------------------------------------------------------
                s64                     %lld or %llx
                u64                     %llu or %llx


The only way around this is:

1) to cast to the appropriate non-bitwidth defined type and use it's
   format flag (eg, unsigned long long if you need at least 64-bit
   precision, and use "ll" in the format.  Yes, on 64-bit it means you
   get 128-bit values, but that's a small price to pay for stuff working
   correctly.)

2) we do as done in userspace, and define a PRI64 which can be inserted
   into the format, but this is messy (iow, eg, "%"PRI64"x").  I
   personally find this rather horrid, and I suspect it'll trip other
   kernel developers sanity filters too.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
