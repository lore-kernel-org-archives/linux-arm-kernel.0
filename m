From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Mar 2018 13:40:14 +0100
Subject: [PATCH v2 0/8] PECI device driver introduction
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180306124014.GB13950@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Introduction of the Platform Environment Control Interface (PECI) bus
> device driver. PECI is a one-wire bus interface that provides a
> communication channel between Intel processor and chipset components to
> external monitoring or control devices. PECI is designed to support the
> following sideband functions:
> 
> * Processor and DRAM thermal management
>   - Processor fan speed control is managed by comparing Digital Thermal
>     Sensor (DTS) thermal readings acquired via PECI against the
>     processor-specific fan speed control reference point, or TCONTROL.
>     Both TCONTROL and DTS thermal readings are accessible via the processor
>     PECI client. These variables are referenced to a common temperature,
>     the TCC activation point, and are both defined as negative offsets from
>     that reference.
>   - PECI based access to the processor package configuration space provides
>     a means for Baseboard Management Controllers (BMC) or other platform
>     management devices to actively manage the processor and memory power
>     and thermal features.
> 
> * Platform Manageability
>   - Platform manageability functions including thermal, power, and error
>     monitoring. Note that platform 'power' management includes monitoring
>     and control for both the processor and DRAM subsystem to assist with
>     data center power limiting.
>   - PECI allows read access to certain error registers in the processor MSR
>     space and status monitoring registers in the PCI configuration space
>     within the processor and downstream devices.
>   - PECI permits writes to certain registers in the processor PCI
>     configuration space.
> 
> * Processor Interface Tuning and Diagnostics
>   - Processor interface tuning and diagnostics capabilities
>     (Intel(c) Interconnect BIST). The processors Intel(c) Interconnect
>     Built In Self Test (Intel(c) IBIST) allows for infield diagnostic
>     capabilities in the Intel UPI and memory controller interfaces. PECI
>     provides a port to execute these diagnostics via its PCI Configuration
>     read and write capabilities.
> 
> * Failure Analysis
>   - Output the state of the processor after a failure for analysis via
>     Crashdump.
> 
> PECI uses a single wire for self-clocking and data transfer. The bus
> requires no additional control lines. The physical layer is a self-clocked
> one-wire bus that begins each bit with a driven, rising edge from an idle
> level near zero volts. The duration of the signal driven high depends on
> whether the bit value is a logic '0' or logic '1'. PECI also includes
> variable data transfer rate established with every message. In this way,
> it is highly flexible even though underlying logic is simple.
> 
> The interface design was optimized for interfacing to Intel processor and
> chipset components in both single processor and multiple processor
> environments. The single wire interface provides low board routing
> overhead for the multiple load connections in the congested routing area
> near the processor and chipset components. Bus speed, error checking, and
> low protocol overhead provides adequate link bandwidth and reliability to
> transfer critical device operating conditions and configuration
> information.
> 
> This implementation provides the basic framework to add PECI extensions
> to the Linux bus and device models. A hardware specific 'Adapter' driver
> can be attached to the PECI bus to provide sideband functions described
> above. It is also possible to access all devices on an adapter from
> userspace through the /dev interface. A device specific 'Client' driver
> also can be attached to the PECI bus so each processor client's features
> can be supported by the 'Client' driver through an adapter connection in
> the bus. This patch set includes Aspeed 24xx/25xx PECI driver and a generic
> PECI hwmon driver as the first implementation for both adapter and client
> drivers on the PECI bus framework.

Ok, how does this interact with ACPI/SMM BIOS/Secure mode code? Does
Linux _need_ to control the fan? Or is SMM BIOS capable of doing all
the work itself and Linux has just read-only access for monitoring
purposes?

Pavel

-- (english) http://www.livejournal.com/~pavelmachek
(cesky, pictures)
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/438a28ae/attachment.sig>
