From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 23 Jun 2014 17:27:21 -0400
Subject: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <14353430.fIAk0MDUYn@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <5338610.xCINKmsENX@wuerfel>
 <CAJ5Y-eaA6vPvhbfMjys8PeSC7B+=ZLLBYh4Wi79Nh9=pwB3+sg@mail.gmail.com>
 <14353430.fIAk0MDUYn@wuerfel>
Message-ID: <CAJ5Y-ebS0axNd24VCW-ZJy=4WLYWJ_VAptdw6c7zNCTeJhut7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 June 2014 16:21, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 23 June 2014 15:46:08 Ashwin Chaugule wrote:
>> Hello,
>>
>> On 23 June 2014 15:10, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> Fair point. The more I think about this, it seems that if we want to
>> >> use the mailbox framework for ACPI kernels, we should have a PCC
>> >> specific bypass, something like the one you suggested below. The ACPI
>> >> spec defines PCC as the only "mailbox" like mechanism. There are 3 PCC
>> >> clients defined as well; CPPC, MPST and RASF. Each of these have their
>> >> own ACPI tables and so they dont require special DSDT entries.
>> >
>> > Ok, I see. Can you describe what data is in these tables?
>>
>> For CPPC, its a field for version number, number of entries and then
>> followed by a bunch of PCC entries that have the following structure:
>>
>>  51 struct pcc_register_resource {
>>  52     u8 descriptor;
>>  53     u16 length;
>>  54     u8 space_id;
>>  55     u8 bit_width;
>>  56     u8 bit_offset;
>>  57     u8 access_size;
>>  58     u64 address;
>>  59 } __attribute__ ((packed));
>>
>> These essentially describe the PCC register space to be used by the
>> respective protocol. e.g. CPPC uses these to exchange CPU performance
>> metrics between the OS and the firmware.
>> I believe MPST and RASF also follow the same format.
>
> Interesting. So I guess it's one entry per client of the PCC? How
> exactly does the client know which index to use in this table?

Nah. Just when you'd think - surely there cant be any more 4 letter
ACPI acronyms. ;)

CPPC is one PCC client by itself.

There is a table called PCCT, which describes a list of all PCC
subspaces. Each subspace is like a shared mem region dedicated to a
PCC client. e.g. a platform may choose subspace id 1 for CPPC. The
CPPC has its own table(s) (in case of CPPC, it is a table per CPU),
which lists the PCC registers using the structure above. These
registers reside in the dedicated PCC subspace.

The PCC client drivers will probe their own tables and parse the PCC
register entries from within. e.g. the CPPC driver will look for the
CPC table (per CPU) and parse its PCC registers. Each PCC register
entry reuses the "access_size" field to indicate a PCC subspace index.
This is the index into the PCCT list of subspaces. From here the
client can get the base address of its shared mem region and the
doorbell semantics for communication.

Cheers,
Ashwin
