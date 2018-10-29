From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Oct 2018 15:12:29 +0000
Subject: [PATCH] arm: mm: fault: check ADFSR in case of abort
In-Reply-To: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
Message-ID: <20181029151228.GG30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 02:20:51PM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> When running into situations like:
> "Unhandled fault: synchronous external abort (0x210) at 0xXXX"
> or
> "Unhandled prefetch abort: synchronous external abort (0x210) at 0xXXX"
> it is useful to know the content of ADFSR (Auxiliary Data Fault Status
> Register) to indicate an ECC double-bit error in L1 or L2 cache.
> 
> Refer to:
> Cortex-A15 Technical Reference Manual, Revision: r2p1
> [6.4.8. Error Correction Code]

This is CPU independent code, and so must only access registers that are
present on all CPUs which may run that code.

Here's the extract from the ARM ARM for the ADFSR and AIFSR:

  The position of these registers is architecturally-defined, but the
  content and use of the registers is IMPLEMENTATION DEFINED. An
  implementation can use these registers to return additional fault
  status information. An example use of these registers is to return
  more information for diagnosing parity errors.

So by testing bits in this register, you are making use of
implementation defined values.

It also goes on to say:

  These registers are not implemented in architecture versions before
  ARMv7.

So before ARMv7, we have to take note of the unimplemented CP15 rules:

2. In an allocated CP15 primary register, accesses to all unallocated
   encodings are UNPREDICTABLE for accesses at PL1 or higher.  This
   means that any MCR or MRC access from PL1 or higher with a
   combination of <CRn>, <opc1>, <CRm> and <opc2> values not shown in,
   or referenced from, Full list of VMSA CP15 registers, by coprocessor
   register number on page B3-1481, that would access an allocated
   CP15 primary register, is UNPREDICTABLE. As indicated by rule 1, for
   the ARMv7-Aarchitecture, the allocated CP15 primary registers are:
   ? in any VMSA implementation, c0-c3, c5-c11, c13, and c15
   ...

So I'd prefer if we didn't attempt to read this register on CPUs where
this isn't explicitly implemented.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
