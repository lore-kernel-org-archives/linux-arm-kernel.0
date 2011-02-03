From: per.fransson.ml@gmail.com (Per Fransson)
Date: Thu, 3 Feb 2011 11:14:45 +0100
Subject: [PATCH v2] ARM: kexec: selective MMU identity mapping
In-Reply-To: <20110203073232.GA2708@acer>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
	<20110203073232.GA2708@acer>
Message-ID: <AANLkTi=ft4rvX4RmNr1veiWR7ED1aLp94hm0Ky8q4-OW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ok, I've tried to summarize your comments:

* Break out turning off the MMU.

  - Not sure about this one, the changes rely on each other anyway.
But if you insist...

* Don't add a kexec specific structure as argument to identity_mapping_add().

  - How about a separate 'store_mapping_for(<address to store for>,
<where to store>)' function?
    Could it be placed idmap.c as well?

* Always use processor.reset, regardless of #ifdef MULTI_CPU

  - Yes

* beq -> bneq in relocate_new_kernel()

  - errare humanum est =o)

* better way to check for the MMU actually being off?

  - Will reading the M bit of the System Control Register do?

* Prettier, more general copy lists for restoring the page table entries.

  - Are there any such pre-existing types, e.g.

        struct {
            size_t howmuch;
            void * towhere;
            char what[0];
        }

    or something similar?

* The old 0x0-PAGE_OFFSET 1-1 mapping doesn't cover the physical
addresses needed if these are
  higher, e.g. 0xd0000000--. Thus it will never work.

  - My patch will identity map the needed addresses regardless of
whether they are located in the
    user or kernel space ranges. This at least *could* work, if we are
lucky and it doesn't coincide
    with the mappings for the code we still need to run before turning
off the MMU.

* The jump to physical addresses in cpu_reset() needs to account for
PHYS_OFFSET!=0

  - Yes

* Move ARM specific struct definitions to ARM specific header

  - Yes

* Tested on ARMv4/v5 CPUs?

  - No, sorry, there are none available to me. They should work like
they used to if they don't use
    any other code than the cpu_reset() and relocate_new_kernel()
functions once the MMU has been
    turned off.

Regards,
Per
