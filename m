From: al.stone@linaro.org (Al Stone)
Date: Wed, 04 Feb 2015 15:39:16 -0700
Subject: [RFC v3] ACPI on arm64 TODO List, 4 Feb 2015
Message-ID: <54D29F94.4080709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update for 4 Feb 2015:

Back in September 2014, a meeting was held at Linaro Connect where we
discussed what issues remained before the arm64 ACPI core patches could
be merged into the kernel, creating the TODO list below.  I should have
published this list sooner; I got focused on trying to resolve some of
the issues instead.

We have made some progress on all of these items.  But, I want to make
sure we haven't missed something.  Since this list was compiled by only
the people in the room at Connect, it is probable we have.  I, for one,
do not yet claim omniscience.

So, I want to ask the ARM and ACPI communities:

  -- Is this list correct?

  -- Is this list complete?

Below is what we currently know about; very brief notes on status are
included.  The TL;DR versions of the TODO list and the current status
can be found at:

   https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/CoreUpstreamNotes

and I'll do my best to kept that up to date.

Thanks.  Any and all feedback is greatly appreciated.


Changes since 11 Jan 2015:
-- v7 of ACPI core patches posted; lots of discussion around GICs,
   documentation, and how to handle acpi=force
-- Merging requested, discussed, NAK'd until further changes and sign-offs
   and ACKs from subsystem maintainers
-- v8 of ACPI core patches posted, updated per v7 discussions; significant
   changes to GIC handling and documentation, much larger collection of
   sign-offs of all kinds; _OSC and _DSD review processes suggested; handling
   of acpi=force codified
-- v1 of _OSI patches posted; v2 posted today; _OSC addressed in ACPI core v8
   patches
-- Additional FWTS runs, CI loop integration
-- luvOS v1 patches posted and reviewed; working on updating GRUB and FWTS; CI
   loop built and running
-- _DSD process suggested in ACPI core v8 patches
-- Grant's summary of the ACPI rationale now part of the documentation


Changes since 14 Dec 2014:
-- v6 of ACPI core patches posted
-- Good progress in _OSI investigation, started preparing RFC for the
   mailing lists
-- Precise definition of kernel behavior when defaulting to DT and/or
   using acpi=force being discussed again
-- FWTS now runs and results posted after each merge of leg-kernel
   (includes ACPI) with Linus' tree (i.e., each -rc).
-- ACPI on arm64 kernel document updated, under extensive discussion on
   the lists; starting coordination with SBBR content.
-- Firmware Summit: planned for 26 Mar 2015, San Jose, CA, at the ARM
   office; mailing list (with archives) now up and running; updated
   agenda being prepared
-- Merged items "Demonstrate the ACPI core patches work", and "Platform
   support patches need review" because of their similarity.
-- Further discussions have occurred regarding "Why ACPI?" and the
   usage of _DSD, more still needed


TODO List for ACPI on arm64:
============================
1. Define how Aarch64 OS identifies itself to firmware
   * Problem:
     * _OSI method is demonstrably unreliable. On x86, Linux claims to
       be Windows.
     * Proposal to use _OSC method as replacement is complicated and
       creates an explosion of combinations
   * Solution:
     * Draft and propose OS identification rules to ABST and ASWG for
       inclusion in ACPI spec.
     * Draft and propose recommended practice for current ACPI 5.1 spec
       platforms.
   * Status: general agreement to deprecate _OSI completely, replace _OS_,
     and v2 of patches to do so posted (https://lkml.org/lkml/2015/2/3/877);
     _OSC process suggested in ACPI on arm64 documentation

2. Linux must choose DT booting by default when offered both ACPI and DT
   on arm64
   * Status: DONE, again, after incorporating discussion into v8 of core patches

3. Linux UEFI/ACPI testing tools must be made available
   * Problem:
     * Hardware/Firmware vendors do not have tools to test Linux compatibility.
     * Common problems go undetected if not tested for.
   * Solution:
     * Port FWTS tool and LuvOS distribution to AArch64
     * Make LuvOS images readily available
     * Require hardware vendors to actively test against old and new kernels.
   * Status:
     * LuvOS and FWTS ported to arm64; patches in mainline; additional test
       cases being written.
     * CI loop set up to run FWTS on Foundation model for each -rc merge of
       Linus' tree into leg-kernel.
     * AMD Seattle results pending updated kernel patches.
     * LuvOS details at https://wiki.linaro.org/LEG/Engineering/luvOS
       * v1 patches out and reviewed
       * CI loop up and running
       * Working on update of GRUB2 and FWTS

4. Set clear expectations for those providing ACPI for use with Linux
   * Problem:
     * Hardware/Firmware vendors can and will create ACPI tables that
       cannot be used by Linux without some guidance
     * Kernel developers cannot determine whether the kernel or firmware
       is broken without knowing what the firmware should do
   * Solution: document the expectations, and iterate as needed.  Enforce
     when we must.
   * Status: significant rewrite and additions to kernel documentation;
     starting to coordinate content with SBBR; firmware summit date and
     location firm, agenda updated, kernel docs shared for discussion.

5. Platform support patches need verification and review
   * Problem: the core Aarch64 patches have been reviewed and are in good
     shape, but there is not yet a good example of server platform support
     patches that use them.
   * Solution: post *good* patches for multiple ACPI platforms, demonstrating
     that both the core patches work, and that the use of the ACPI core makes
     sense.
   * Status:
     * Lots of changes to subsystem patches (GIC, PCI, ...) all over the place
     * ACPI core works on at least the Foundation model, Juno, APM Mustang,
       and AMD Seattle
     * FWTS results for the Foundation model have been posted
     * First version for AMD Seattle has been posted to the public linaro-acpi
       mailing list for initial review, refined versions to be posted to
       broader lists after a few iterations for basic cleanup

6. How does the kernel handle_DSD usage?
   * Problem:
     * _DSD defines key-value properties in the DT style. How do we ensure
       _DSD bindings are well defined?
     * How do we ensure DT and _DSD bindings remain consistent with each other?
   * Solution: public documentation for all bindings, and a process for
     defining them
   * Status: proposal documented in ACPI core patches to require patch authors
     to submit bindings with drivers, then register with UEFI Forum; kernel
     Documentation/devicetree/bindings remains the default if no other location
     exists.

7. Why is ACPI required?
   * Problem:
     * arm64 maintainers still haven't been convinced that ACPI is necessary.
     * Why do hardware and OS vendors say ACPI is required?
   * Solution: discussions between those who want ACPI and arm64 maintainers
   * Status: DONE, and documentation added to proposed kernel docs; firmware
     summit for broader discussion still planned.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
