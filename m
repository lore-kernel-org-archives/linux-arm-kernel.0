From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 13 Mar 2017 15:42:48 +0100
Subject: [PATCH v3 01/19] KVM: arm/arm64: Add vITS save/restore API
 documentation
In-Reply-To: <CAFEAcA_hobSQZvOQHGgdoJYw9q099GNrY=5ffjYO5YeePtKdNA@mail.gmail.com>
References: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
 <1488800074-21991-2-git-send-email-eric.auger@redhat.com>
 <CAFEAcA_hobSQZvOQHGgdoJYw9q099GNrY=5ffjYO5YeePtKdNA@mail.gmail.com>
Message-ID: <6f86ec3f-6b9e-34ba-628a-c2ef7b8c3529@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 13/03/2017 14:08, Peter Maydell wrote:
> On 6 March 2017 at 12:34, Eric Auger <eric.auger@redhat.com> wrote:
>> Add description for how to access vITS registers and how to flush/restore
>> vITS tables into/from memory
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> I've had a look through this; a mix of typo corrections
> and other questions below. I'm not very familiar with the ITS
> so mostly it's requests for clarification...
> 
>> ---
>>
>> v1 -> v2:
>> - DTE and ITE now are 8 bytes
>> - DTE and ITE now indexed by deviceid/eventid
>> - use ITE name instead of ITTE
>> - mentions ITT_addr matches bits [51:8] of the actual address
>> - mentions LE layout
>> ---
>>  Documentation/virtual/kvm/devices/arm-vgic-its.txt | 78 ++++++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
>> index 6081a5b..49ade0c 100644
>> --- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
>> @@ -36,3 +36,81 @@ Groups:
>>      -ENXIO:  ITS not properly configured as required prior to setting
>>               this attribute
>>      -ENOMEM: Memory shortage when allocating ITS internal data
>> +
>> +  KVM_DEV_ARM_VGIC_GRP_ITS_REGS
>> +  Attributes:
>> +      The attr field of kvm_device_attr encodes the offset of the
>> +      ITS register, relative to the ITS control frame base address
>> +      (ITS_base).
>> +
>> +      kvm_device_attr.addr points to a __u64 value whatever the width
>> +      of the addressed register (32/64 bits).
>> +
>> +      Writes to read-only registers are ignored by the kernel except
>> +      for a single register, GITS_READR. Normally this register is RO
>> +      but it needs to be restored otherwise commands in the queue will
>> +      be re-executed after CWRITER setting.
>> +
>> +      For other registers, Getting or setting a register has the same
> 
> "getting"
sure
> 
>> +      effect as reading/writing the register on real hardware.
>> +  Errors:
>> +    -ENXIO: Offset does not correspond to any supported register
>> +    -EFAULT: Invalid user pointer for attr->addr
>> +    -EINVAL: Offset is not 64-bit aligned
>> +
>> +  KVM_DEV_ARM_VGIC_GRP_ITS_TABLES
>> +  Attributes
>> +       The attr field of kvm_device_attr is not used.
> 
> I think we should say "must be zero, or the call fails with -ESOMETHING",
> so we have the option of using attr for something in future if needed.
OK
> 
>> +
>> +       request the flush-save/restore of the ITS tables, namely
>> +       the device table, the collection table, all the ITT tables,
>> +       the LPI pending tables. On save, the tables are flushed
>> +       into guest memory at the location provisioned by the guest
>> +       in GITS_BASER (device and collection tables), on MAPD command
> 
> should this be "in the MAPD command" ?
OK I will reword this into "at the address indicated by ... MAPD command
ITT_addr field"
> 
>> +       (ITT_addr), GICR_PENDBASERs (pending tables).
>> +
>> +       This means the GIC should be restored before the ITS and all
>> +       ITS registers but the GITS_CTRL must be restored before
> 
> "GITS_CTLR".
OK
> 
>> +       restoring the ITS tables.
>> +
>> +       Note the LPI configuration table is read-only for the
>> +       in-kernel ITS and its save/restore goes through the standard
>> +       RAM save/restore.
>> +
>> +       The layout of the tables in guest memory defines an ABI.
>> +       The entries are laid in little endian format as follows;
>> +
>> +    The device table and ITE are respectively indexed by device id and
>> +    eventid. The collection table however is not indexed by collection id:
>> +    CTE are written at the beginning of the buffer.
>> +
>> +    Device Table Entry (DTE) layout: entry size = 8 bytes
>> +
>> +    bits:     | 63 ... 45 | 44 ... 5 | 4 ... 0 |
>> +    values:   |   next    | ITT_addr |  Size   |
>> +
>> +    where
>> +    - ITT_addr matches bits [48:8] of the ITT address (256B aligned).
>> +    - next field is meaningful only if the entry is valid (ITT_addr != NULL).
> 
> Probably clearer as != 0, since it's a field rather than a pointer.
OK
> 
> The MAPD command lets the guest specify bits [50:8] of
> ITT address -- any reason for not storing bits [50:49] here?
> (in fact you can see the format of MAPD has more reserved
> bits for wider physical address sizes in future -- should
> we be trying to future proof our format too?)
The in-kernel ITS implements 48 bits of PA at the moment (BASER, CBASER,
PENDBASER, PROPBASER). Reading the code again it actually extracts
[8:44] range in the MAPD command line but I would have expected it to
use [8:47]. Andre, if by chance you read this, what is the rationale?

Marc suggested me to shrink the field to 48 bits in previous to enlarge
next field. Now if preferred I definitively can encode the whole length
at the expense of next field.
> 
> I don't see anything in the spec for MAPD that forbids the guest
> from using physical address 0 as the ITT_addr, though maybe I
> missed it.
Correct I didn't as well. Marc told me size could be 0 to. So if I
cannot rely on such assumption, I don't have any choice but adding a
valid bit.
> 
>> +    It equals to 0 if this entry is the last one; otherwise it corresponds
>> +    to the minimum between the offset to the next device id and 2^19 -1.
>> +
>> +    Collection Table Entry (CTE) layout: entry size = 8 bytes
>> +
>> +    bits:     | 63| 62 ..  52  | 51 ... 16 | 15  ...   0 |
>> +    values:   | V |    RES0    |  RDBase   |    ICID     |
>> +
> 
> We should document the meanings of the CTE fields here.
OK I will add this.
> 
>> +    Interrupt Translation Entry (ITE) layout: entry size = 8 bytes
>> +
>> +    bits:     | 63 ... 48 | 47 ... 16 | 15 ... 0 |
>> +    values:   |    next   |   pINTID  |  ICID    |
>> +
>> +    - next field is meaningful only if the entry is valid (pINTID != NULL).
>> +    It equals to 0 if this entry is the last one; otherwise it corresponds
>> +    to the minimum between the eventid offset to the next ITE and 2^16 -1.
> 
> This seems to be missing some of the fields in the suggested
> ITE contents in the GIC spec table 6-3. Is that OK?
> In particular it's missing the virtual-interrupt related fields.
> Is pINTID==0 really not a valid interrupt ID value?
Marc sent an RFC to support GICv4 features in ITS driver but currently
both ITS driver and ITS in-kernel emulation have no support for this.

in MAPI chapter a note says
pINTID ? 0x2000 for a valid LPI INTID. I don't think you can translate
anything else than an LPI.
> 
> 
> These CTE/ITE/DTE formats don't seem to have any kind of
> "escape hatch" for allowing backwards compatible extensions
> to the format. Do we need one? (I think that's particularly
> likely to be useful where there's an ITS feature we don't
> currently implement but might perhaps want to in future,
> like GICv4 virtual interrupt injection.)

Maybe we could rely on the ITS registers (that must be restored before
the tables) to get any info about the format used to encode the table
entries. We have GITS_CTLR[1] that can help discriminate between GICv3/
GICv4. GITS_BASER.Entry_size can be 8B for current implementation and
16B for an enhanced implementation. CTE[52:62] can be used to encode a
format version.

> 
>> +    LPI Pending Table layout:
>> +
>> +    As specified in the ARM Generic Interrupt Controller Architecture
>> +    Specification GIC Architecture version 3.0 and version 4. The first
>> +    1kB is not modified and therefore should contain zeroes.
>> --
>> 2.5.5

Thanks for this new review round.

Best Regards

Eric
> 
> thanks
> -- PMM
> 
