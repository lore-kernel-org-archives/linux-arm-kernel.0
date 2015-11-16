From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 20:01:03 +0100
Subject: [PATCH v2 07/12] ARM: split off core mapping logic from
 create_mapping
In-Reply-To: <20151116185519.GE8644@n2100.arm.linux.org.uk>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-8-git-send-email-ard.biesheuvel@linaro.org>
 <20151116185519.GE8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-P45_S2aHE2Dr=i-2e29-DvmSBR_JWec=JPcZeTMn02Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 19:55, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 16, 2015 at 07:32:32PM +0100, Ard Biesheuvel wrote:
>> In order to be able to reuse the core mapping logic of create_mapping
>> for mapping the UEFI Runtime Services into a private set of page tables,
>> split it off from create_mapping() into a separate function
>> __create_mapping which we will wire up in a subsequent patch.
>
> I'm slightly worried about this.  Generally, these functions setup
> global mappings.  If you're wanting to have a private set of page
> tables for UEFI, and those private page tables contain global
> mappings which are different from the mappings in the kernel's page
> tables, then you need careful break-TLBflush-make handling when
> switching from the kernel's page tables to the private UEFI ones,
> and vice versa.
>
> Has this aspect been considered?
>

Yes. The UEFI mappings are all below 1 GB, and the top kernel end is
reused as we do for ordinary userland page tables. The switch to the
UEFI page tables performs a full TLB flush. What it does not do is
break before make, as far as I can tell, so any pointers regarding how
to implement that would be appreciated (this is implemented in 11/12)

-- 
Ard.
