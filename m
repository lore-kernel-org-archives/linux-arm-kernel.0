From: Jeremy.Linton@arm.com (Jeremy Linton)
Date: Thu, 17 Sep 2015 10:33:39 -0700
Subject: [PATCH 7/7] arm64: Mark kernel page ranges contiguous
In-Reply-To: <CAPvkgC3QOvHdQRuvAmdRDnbfQCMOBX2aPcoLER7grc5yZ-MF4A@mail.gmail.com>
References: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
 <1442430186-9083-8-git-send-email-jeremy.linton@arm.com>
 <CAPvkgC3QOvHdQRuvAmdRDnbfQCMOBX2aPcoLER7grc5yZ-MF4A@mail.gmail.com>
Message-ID: <F58048940DF89C44BFA5A966565B5D23EBA34EE592@SPOCK.usa.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

|Hi Jeremy,
|One quick comment for now below.
|I ran into a problem testing this on my Seattle board, and needed the fix
|below.
<snip>
|> -       } while (pte++, addr += PAGE_SIZE, addr != end);
|> +               next = min(end, (addr + CONT_SIZE) & CONT_MASK);
|> +               if (((addr | next | phys) & CONT_RANGE_MASK) == 0) {
|> +                       /* a block of CONT_RANGE_SIZE PTEs */
|> +                       __populate_init_pte(pte, addr, next, phys,
|> +                                           prot | __pgprot(PTE_CONT));
|> +                       pte += CONT_RANGE;
|> +               } else {
|> +                       /*
|> +                        * If the range being split is already inside of a
|> +                        * contiguous range but this PTE isn't going to be
|> +                        * contiguous, then we want to unmark the adjacent
|> +                        * ranges, then update the portion of the range we
|> +                        * are interrested in.
|> +                        */
|> +                        clear_cont_pte_range(pte, addr);
|> +                        __populate_init_pte(pte, addr, next, phys, prot);
|> +                        pte += CONT_RANGE_OFFSET(next - addr);
|
|I think this should instead be:
|pte += (next - addr) >> PAGE_SHIFT;
|
|Without the above change, I get panics on boot with my Seattle board when
|efi_rtc is initialised.
|(I think the EFI runtime stuff exacerbates the non-contiguous code path
|hence I notice it on my system).

I think that implies you have linear mappings >= 2M that aren?t aligned. Ok, but that almost sounds like something we want to complain about if we detect it.






-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
