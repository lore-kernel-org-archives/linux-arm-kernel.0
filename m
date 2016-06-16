From: jcm@redhat.com (Jon Masters)
Date: Thu, 16 Jun 2016 03:54:46 -0400 (EDT)
Subject: [Linaro-acpi] [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space
 accessors against platfrom specific ECAM quirks
In-Reply-To: <CADaLNDnjEuGvWxCMPb=9fiCeVMgF0RRzT2n1SjNw3o57gRUhcg@mail.gmail.com>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
 <e3174a09-e6f8-126d-d3c5-648d1cfd2b74@redhat.com>
 <CADaLNDnjEuGvWxCMPb=9fiCeVMgF0RRzT2n1SjNw3o57gRUhcg@mail.gmail.com>
Message-ID: <891827D4-0ECE-4A55-B79D-E5C7C23A0B04@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

:) We should be good with a match on XGENE (but be careful with substring matching) as long as future platforms change that to eg XGENE3 (which is a publicly announced future chip). What you want to avoid is a shorter match later triggering on a future generation.

There are a lot of folks eagerly awaiting Moonshot running an upstream kernel in F25, both for 64 and 32-bit (VMs running 32-bit can replace older builders). I can picture a wonderful world in which this whole ARM server ecosystem works properly with folks doing what they should have three years ago and development happening on upstream kernels with ACPI. Then things become incredibly dull just like x86 - do the dev against upstream, pull into an enterprise distro after it is tested out in a Fedora cycle...and no random nonsense patches. Next thing we know there will be media reports covering silicon that won't end with a rant about how they couldn't get the right firmware and hacked up Ubuntu kernel booting.

Best, and goodnight :)

Jon.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Jun 16, 2016, at 03:46, Duc Dang <dhdang@apm.com> wrote:
> 
>> On Wed, Jun 15, 2016 at 11:31 PM, Jon Masters <jcm@redhat.com> wrote:
>>> On 06/13/2016 09:54 AM, Gabriele Paoloni wrote:
>>> Hi Tomasz, Jon
>> 
>> Hi Gab,
>> 
>> Sorry for the lag in following up.
>> 
>> <snip>
>> 
>>> As you can see here Liudongdong has replaced oem_revision with
>>> oem_table_id.
>>> 
>>> Now it seems that there are some platforms that have already shipped
>>> using a matching based on the oem_revision (right Jon?)
>> 
>> Actually, it turns out (Cov is correct) that we can just match on OEM
>> Table ID. The revision should not generally be needed and the vendors
>> will just need to make sure that they change OEM Table ID in future
>> silicon. An example from two shipping platforms:
>> 
>> 1). AppliedMicro Mustang:
>> 
>> [000h 0000   4]                    Signature : "MCFG"    [Memory Mapped
>> Configuration table]
>> [004h 0004   4]                 Table Length : 0000003C
>> [008h 0008   1]                     Revision : 01
>> [009h 0009   1]                     Checksum : 4A
>> [00Ah 0010   6]                       Oem ID : "APM   "
>> [010h 0016   8]                 Oem Table ID : "XGENE   "
>> [018h 0024   4]                 Oem Revision : 00000002
>> [01Ch 0028   4]              Asl Compiler ID : "INTL"
>> [020h 0032   4]        Asl Compiler Revision : 20140724
>> 
>> 2). HP(E[0]) Moonshot:
>> 
>> [000h 0000   4]                    Signature : "MCFG"    [Memory Mapped
>> Configuration table]
>> [004h 0004   4]                 Table Length : 0000003C
>> [008h 0008   1]                     Revision : 01
>> [009h 0009   1]                     Checksum : 48
>> [00Ah 0010   6]                       Oem ID : "APM   "
>> [010h 0016   8]                 Oem Table ID : "XGENE   "
>> [018h 0024   4]                 Oem Revision : 00000001
>> [01Ch 0028   4]              Asl Compiler ID : "HP  "
>> [020h 0032   4]        Asl Compiler Revision : 00000001
>> 
>> I have pinged the semiconductor (Applied) and insisted upon a written
>> plan (which I have now) for handling the first affect generation(s) and
>> future chip roadmap stuff, along with how they plan to upstream this
>> immediately as part of this thread. I have also done similar with each
>> of the other vendors (this is something ARM or Linaro should be doing).
>> But I particularly care about X-Gene because I want it to be loved as
>> shipping silicon in production systems (Moonshot) that are sitting and
>> waiting in the Fedora Phoenix datacenter in large quantity to come
>> online if only an upstream kernel would actually boot on them :)
> 
> Thanks for the MCFG information on Moonshot system, Jon.
> 
> I will make sure the posted quirk for X-Gene takes care for HPE
> Moonshot system as well.
> 
> Regards,
> Duc Dang.
> 
>> 
>>> However I guess that if in FW they have defined oem_table_id properly
>>> they should be able to use this mechanism without needing to a FW update.
>> 
>> Correct.
>> 
>>> Can these vendors confirm this?
>> 
>> I've checked all current shipping silicon and prototypes.
>> 
>>> Tomasz do you think this can work for Cavium Thunder?
>> 
>> Will let the vendors followup directly as well.
>> 
>> Jon.
>> 
>> [0] Fortunately that name change doesn't factor when using semiconductor
>> matching...hopefully none of the non-complaint IP companies in gen1
>> stuff get bought and change their table names. In the unlikely event
>> that that does happen, I will preemptively beat them up and ensure that
>> something crazy doesn't happen with table contents.
>> 
>> --
>> Computer Architect | Sent from my Fedora powered laptop
